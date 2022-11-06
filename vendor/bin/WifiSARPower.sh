#ReceiverOn=`getprop vendor.asus.sar.audio`
Wifion=`getprop wlan.driver.status`
Country=`getprop vendor.asus.operator.iso-country`
#SKU=`getprop ro.boot.id.prj`
#CustomerID=`getprop ro.config.CID`
#Wigigon=`getprop vendor.wigig.driver.status`
Softapon=`getprop vendor.wlan.softap.driver.status`
WlanDbs=`getprop vendor.wlan.dbs`
Slm=`getprop vendor.asus.sar.sla`

log -t WifiSARPower enter WlanDbs=$WlanDbs Wifion=$Wifion Softapon=$Softapon Country=$Country Slm=$Slm


if [ "$Softapon" == "ok" ]; then
    echo 1 > /proc/driver/UTSstatus
else
    echo 0 > /proc/driver/UTSstatus
fi

if [ "$Wifion" == "ok" ] || [ "$WlanDbs" == "1" ] || ["$Softapon" == "ok"]; then
        case "$Country" in
            *"IT"* | *"DE"* | *"UK"* | *"BE"* | *"NL"* | *"ES"* | *"DK"* | *"FI"* | *"NO"* | *"SE"* | *"PT"* |*"PL"* | *"RO"* | *"CZ"* | *"SK"* | *"HU"* )
                if [ "$Softapon" == "ok" ] || [ "$Slm" == "1" ]; then
                    vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 1 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 1 --END_ATTR --END_ATTR --END_CMD

                    log -t WifiSARPower CE Hotspot or SLM
                else
                    vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 0 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 0 --END_ATTR --END_ATTR --END_CMD

                    log -t WifiSARPower CE
                fi
        ;;
        esac
fi

