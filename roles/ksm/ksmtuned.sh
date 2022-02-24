#!/bin/bash

tune="yes"
ram_size=$(( $(vmstat -s | grep -i "total memory" | xargs | cut -d" " -f 1) / 1024 / 1000))

if [ "$tune" == "yes" ] ; then
    /usr/bin/env DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::='--force-confdef' install ksm-control-daemon
    if [[ ram_size -le 16 ]] ; then
        # start at 50% full
        KSM_THRES_COEF=50
        KSM_SLEEP_MSEC=80
    elif [[ ram_size -le 32 ]] ; then
        # start at 60% full
        KSM_THRES_COEF=40
        KSM_SLEEP_MSEC=60
    elif [[ ram_size -le 64 ]] ; then
        # start at 70% full
        KSM_THRES_COEF=30
        KSM_SLEEP_MSEC=40
    elif [[ ram_size -le 128 ]] ; then
        # start at 80% full
        KSM_THRES_COEF=20
        KSM_SLEEP_MSEC=20
    else
        # start at 90% full
        KSM_THRES_COEF=10
        KSM_SLEEP_MSEC=10
    fi
    sed -i -e "s/\# KSM_THRES_COEF=.*/KSM_THRES_COEF=${KSM_THRES_COEF}/g" /etc/ksmtuned.conf
    sed -i -e "s/\# KSM_SLEEP_MSEC=.*/KSM_SLEEP_MSEC=${KSM_SLEEP_MSEC}/g" /etc/ksmtuned.conf
fi
