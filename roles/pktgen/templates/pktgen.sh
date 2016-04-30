#!/bin/sh

cnt=1000000
tx_eth=eth1
rx_eth=eth2
pktsize=60
delay=10

src_mac="08:00:27:e7:5d:b6"
dst_mac="08:00:27:9a:aa:40"
src_ip="10.0.0.1"
dst_ip="10.0.0.2"

modprobe pktgen

echo "rem_device_all" > /proc/net/pktgen/kpktgend_0
echo "add_device ${tx_eth}" > /proc/net/pktgen/kpktgend_0
echo "add_device ${rx_eth}" > /proc/net/pktgen/kpktgend_0

echo "count ${cnt}" > /proc/net/pktgen/${tx_eth}
echo "clone_skb 1" > /proc/net/pktgen/${tx_eth}
echo "pkt_size ${pktsize}" > /proc/net/pktgen/${tx_eth}
echo "delay ${delay}" > /proc/net/pktgen/${tx_eth}
echo "src_min ${src_ip}" > /proc/net/pktgen/${tx_eth}
echo "src_max ${src_ip}" > /proc/net/pktgen/${tx_eth}
echo "src_mac ${src_mac}" > /proc/net/pktgen/${tx_eth}
echo "dst ${dst_ip}" > /proc/net/pktgen/${tx_eth}
echo "dst_mac ${dst_mac}" > /proc/net/pktgen/${tx_eth}

echo "start" > /proc/net/pktgen/pgctrl

