function zfs-assert-snapshot-time --argument dataset max_age

    set -q dataset[1]; or set dataset $ROS_ZFS_DATASET_TO_CHECK
    set -q dataset[1]; or begin
        echo "I need to know which dataset to check. or set the ROS_ZFS_DATASET_TO_CHECK env var"
        return
    end
    set -q max_age[1]; or set max_age $ROS_ZFS_SNAPSHOT_MAX_AGE
    set -q max_age[1]; or begin
        echo "I need to know the max age this dataset can be; either run this function via `zfs-assert-snapshot-time <dataset> <max_age> or set the env var ROS_ZFS_SNAPSHOT_MAX_AGE"
        return
    end
    set -e snapshot_times
    for snap_record in (zfs list -o creation,name -t snapshot $dataset)
        echo $snap_record | grep -q $dataset; or continue

        set record_parts (string split ' ' $snap_record)[..-2]
        set snap_date $record_parts[..-2]
        echo $snap_date
        set -a snapshot_times (date --date="$snap_date" +"%s")
    end
end
