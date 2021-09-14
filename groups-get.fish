function groups-get
 getent group | cut -d: -f1;
end
