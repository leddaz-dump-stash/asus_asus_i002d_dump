a=`cat /proc/cmdline`
test="androidboot.id.ddr="
pos=`awk -v a="$a" -v b="$test" 'BEGIN{print index(a,b)}'`
pos=`expr $pos - 1`
len=`echo ${#test}`
len=`expr $len + 1`
#echo $pos
#echo $len
#echo $a

target=${a:$pos:$len}
#echo $target

id=`echo $target|cut -d "=" -f 2`
#echo id=$id

case $id in
	0 )
		type="DDR5"
;;
	1 )
		type="DDR5"
;;
	2 )
		vid="MICRON"
		type="DDR5"
;;
	3 )
		vid="SAMSUNG"
		type="DDR5"
		fake_id="0x1"
;;
	4 )
		type="DDR4"
;;
	5 )
		vid="HYNIX"
		type="DDR4"
;;
	6 )
		vid="MICRON"
		type="DDR4"
;;
	7 )
		vid="SAMSUNG"
		type="DDR4"
		fake_id="0x1"
;;
	* )
		vid="unknown_vendor"
		type="unknown_type"
;;

esac
echo vid=$vid type=$type


sizeK=`cat /proc/meminfo  |grep -i MemTotal |awk '{print $2}'`
sizeM=`expr $sizeK / 1024`
sizeG=`expr $sizeM / 1024`
echo $sizeK KB
echo $sizeM MB
echo $sizeG GB
unit=GB

#setprop asus.ddr_info "$vid $type $sizeG$unit"
setprop vendor.asus.ddr_info "$vid"

setprop ro.vendor.atd.memvendor "$fake_id"
setprop ro.vendor.atd.platform "Qualcomm Snapdragon 865 Qcta-core CPUs, 2.842GHz"

