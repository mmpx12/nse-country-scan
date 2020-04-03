#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

count=0
nbrline=$(wc -l iplist.csv | cut -d ' ' -f 1)
mkdir -p /usr/share/nmap/nselib/country/list

while read line; do
  count=$(($count+1))
  percent=$(($count*100/$nbrline))
  echo -ne "\rProgress:  $percent%"
  while IFS=, read -r ip_start ip_end code_country country; do
    IFS=. read -r is1 is2 is3 is4 <<< $ip_start
    IFS=. read -r ie1 ie2 ie3 ie4 <<< $ip_end
    [ "$is1" -eq "$ie1" ] && ip1="$is1" || ip1="$is1-$ie1"
    [ "$is2" -eq "$ie2" ] && ip2="$is2" || ip2="$is2-$ie2"
    [ "$is3" -eq "$ie3" ] && ip3="$is3" || ip3="$is3-$ie3"
    [ "$is4" -eq "$ie4" ] && ip4="$is4" || ip4="$is4-$ie4"
    range="$ip1.$ip2.$ip3.$ip4"
    echo  "$range" >> "/usr/share/nmap/nselib/country/list/$code_country"
    echo "$code_country $country" >> country_list.lst
  done <<< $line
done < iplist.csv

sort -u -o /usr/share/nmap/nselib/country/country_list.lst country_list.lst
echo ""
