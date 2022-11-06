#!/vendor/bin/sh
TP_VER_PACK=`cat /sys/bus/i2c/devices/i2c-4/4-0038/fts_fw_version`

setprop vendor.touch.version.driver "$TP_VER_PACK"
