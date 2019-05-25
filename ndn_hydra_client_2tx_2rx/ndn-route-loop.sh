#!/bin/bash

while read line; do sudo nfdc face create udp://$line; done < /home/ubuntu/ips.out

