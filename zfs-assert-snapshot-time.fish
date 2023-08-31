#!/usr/bin/env fish
function zfs-assert-snapshot-time --argument dataset max_age

    set -q dataset[1]; or set dataset $ROS_ZFS_DATASET_TO_CHECK
    set -q dataset[1]; or begin
        echo "I need to know which dataset to check. or set the ROS_ZFS_DATASET_TO_CHECK env var"
        return 1
    end
    set -q max_age[1]; or set max_age $ROS_ZFS_SNAPSHOT_MAX_AGE
    set -q max_age[1]; or begin
        echo "I need to know the max age this dataset can be; either run this function via `zfs-assert-snapshot-time <dataset> <max_age> or set the env var ROS_ZFS_SNAPSHOT_MAX_AGE"
        return 1
    end
    set now_epoch (date +"%s")
    set -e snapshot_times

    for snap_record in (zfs list -o creation,name -t snapshot $dataset)
        echo $snap_record | grep -q $dataset; or continue

        set record_parts (string split ' ' $snap_record)[..-2]
        set snap_date $record_parts[..-2]
        set -q snap_date[1]; or echo "snap_date was empty"
        set -a snapshot_times (date --date="$snap_date" +"%s")
    end
    set sorted_times (string collect $snapshot_times | sort | string split '\n')

    set latest_snapshot_time $sorted_times[-1]
    set how_long_since_snap (math "$now_epoch - $latest_snapshot_time")
    return (test $how_long_since_snap -le $max_age)
end
