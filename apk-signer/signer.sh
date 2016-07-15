#!/bin/sh
signer_dir(){
    for file in $1/*
    do
        if [ -d $file ] ;
        then
            signer_dir $file
        elif [ -f $file ] ;
        then
          if [ ${file##*.} = 'apk' ] ;
          then
            jarsigner -verbose -keystore whcyit.keystore -signedjar $(basename $file .apk)-signed.apk $(basename $file) whcyit -storepass whcyit
          fi
        fi
    done
}

echo '正在签名.....'
if [ $# -gt 0 ] ;
then
    signer_dir "$1"
else
    signer_dir "."
fi
echo '签名完成.....'

