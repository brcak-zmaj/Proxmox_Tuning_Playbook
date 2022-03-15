#!/bin/bash

XS_ZFSARC="yes"
RAM_SIZE_GB=$(( $(vmstat -s | grep -i "total memory" | xargs | cut -d" " -f 1) / 1024 / 1000))

if [ "$XS_ZFSARC" == "yes" ] ; then
    ## Optimise ZFS arc size accoring to memory size
    if [ "$(command -v zfs)" != "" ] ; then
      if [[ RAM_SIZE_GB -le 16 ]] ; then
        MY_ZFS_ARC_MIN=536870911
        MY_ZFS_ARC_MAX=536870912
    elif [[ RAM_SIZE_GB -le 32 ]] ; then
        # 1GB/1GB
        MY_ZFS_ARC_MIN=1073741823
        MY_ZFS_ARC_MAX=1073741824
      else
        MY_ZFS_ARC_MIN=$((RAM_SIZE_GB * 1073741824 / 16))
        MY_ZFS_ARC_MAX=$((RAM_SIZE_GB * 1073741824 / 8))
      fi
      # Enforce the minimum, incase of a faulty vmstat
      if [[ MY_ZFS_ARC_MIN -lt 536870911 ]] ; then
        MY_ZFS_ARC_MIN=536870911
      fi
      if [[ MY_ZFS_ARC_MAX -lt 536870912 ]] ; then
        MY_ZFS_ARC_MAX=536870912
      fi
      cat <<EOF > /etc/modprobe.d/99-xs-zfsarc.conf
#  ZFS tuning

# Use 1/16 RAM for MAX cache, 1/8 RAM for MIN cache, or 1GB
options zfs zfs_arc_min=$MY_ZFS_ARC_MIN
options zfs zfs_arc_max=$MY_ZFS_ARC_MAX

# use the prefetch method
options zfs l2arc_noprefetch=0

# max write speed to l2arc
# tradeoff between write/read and durability of ssd (?)
# default : 8 * 1024 * 1024
# setting here : 500 * 1024 * 1024
options zfs l2arc_write_max=524288000
options zfs zfs_txg_timeout=60
EOF
    fi
fi
