#!/bin/bash
cd `dirname $0`
ARCH=$(adb shell getprop ro.product.cpu.abi | tr -d '\r')
DEVICE=$(adb shell getprop ro.product.device | tr -d '\r')
SERIAL=$(adb shell getprop ro.serialno | tr -d '\r')
DIR=../libs/armeabi-v7a
if [ "$ARCH" == "arm64-v8a" ]; then
DIR=../libs/arm64-v8a
fi
adb push ${DIR}/dirtycow /data/local/tmp/dirtycow
adb push ${DIR}/cow-run-as /data/local/tmp/run-as
adb push ${DIR}/exploitta /data/local/tmp/exploitta
adb push ${DIR}/dumpta /data/local/tmp/dumpta
adb push ${DIR}/checkta /data/local/tmp/checkta
adb push backupTADevice.sh /data/local/tmp
adb shell "chmod 755 /data/local/tmp/*"
TAIMG="TA_${DEVICE}_${SERIAL}_$(date -u +%Y%m%d-%H%M).img"
adb shell /data/local/tmp/backupTADevice.sh ${TAIMG}
adb pull /data/local/tmp/${TAIMG} ${TAIMG}
adb shell "rm -f /data/local/tmp/dirtycow /data/local/tmp/run-as /data/local/tmp/exploitta /data/local/tmp/dumpta /data/local/tmp/backupTADevice.sh"
echo "TA Sucessfully pulled to ${TAIMG}"
