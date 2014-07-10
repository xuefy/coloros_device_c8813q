#!/bin/bash

DIR=`pwd`
CUSTDIR=$DIR/customize
java -jar $CUSTDIR/apktool.jar if $DIR/new-update/system/framework/oppo-framework-res.apk
java -jar $CUSTDIR/apktool.jar if $DIR/new-update/system/framework/framework-res.apk

echo "开始处理 Mms ..."
rm -rf $CUSTDIR/Mms_apk
java -jar $CUSTDIR/apktool.jar d -s $DIR/new-update/system/app/Mms.apk -o $CUSTDIR/Mms_res
cd $CUSTDIR/Mms_res
patch -p1 < ../Mms_res.patch
cd $CUSTDIR
java -jar $CUSTDIR/apktool.jar b Mms_res -o Mms_nosign.apk
rm -rf $CUSTDIR/Mms_res
unzip -o Mms_nosign.apk res/layout/conversation_list_item.xml
mv -f $DIR/new-update/system/app/Mms.apk $CUSTDIR/Mms_nosign.apk
zip -m Mms_nosign.apk res/layout/conversation_list_item.xml
java -jar ${PORT_TOOLS}/signapk.jar ${PORT_TOOLS}/keys/platform.x509.pem ${PORT_TOOLS}/keys/platform.pk8 Mms_nosign.apk $DIR/new-update/system/app/Mms.apk
rm -rf res/ Mms_nosign.apk
cd $DIR
echo "Mms 处理完成"
echo ""

echo "开始处理 oppo-framework ..."
rm -rf $CUSTDIR/oppo-framework_dex
${PORT_TOOLS}/apktool d $DIR/new-update/system/framework/oppo-framework.jar $CUSTDIR/oppo-framework_dex
cd $CUSTDIR/oppo-framework_dex
patch -p1 < ../oppo-framework_dex.patch
cd $CUSTDIR
${PORT_TOOLS}/apktool b oppo-framework_dex oppo-framework.jar
mv -f $CUSTDIR/oppo-framework.jar $DIR/new-update/system/framework/oppo-framework.jar
rm -rf $CUSTDIR/oppo-framework_dex
cd $DIR
echo "oppo-framework 处理完成"
echo ""

cp -rf $CUSTDIR/res_mod/mod/* $DIR/new-update/
rm -f $DIR/new-update/system/app/OppoCompass.apk
#bash customize_crypt_frameworks.sh
