function disk-benchmark --argument FILE SIZE TIME
sudo fio --filename=$FILE --size=$SIZE --direct=1 --rw=randrw --bs=4k --ioengine=libaio --iodepth=256 --runtime=$TIME --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1
end
