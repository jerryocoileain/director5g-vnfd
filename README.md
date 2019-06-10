
## build

The build script creates all the following VNFD and NS files:

1. ndn_hydra_client_2tx_2rx_vnfd.tar.gz
2. ndn_hydra_server_vnfd.tar.gz
3. ndn_hydra_client_rx2_vnfd.tar.gz
4. ndn_hydra_client_rx2_vnfd.tar.gz
5. ndn_hydra_basic_nsd.tar.gz
6. ndn_cdn_server_vnf.tar.gz

File 5 is a basic experiment consisting of a 2-EVI Base Station (ndn_hydra_client_2tx_rx and ndn_hydra_server), 2 clients (rx1 and rx3, for the 1st and 2nd EVI, respectively), and the ndn_cdn server hosting NDN data.

To execute the build script just type:

```
./build
```

## osm

The osm script is a simple utilitaria to easen the task of installing, uninstalling, creating, and deleting VNDFs and NSDs.
Type the following command to get a detailed usage of it:
```
./osm l
```

## basic_nsd

This scenario represents a case with 2 slices (in this case we dont have any performance difference between them).


![The scenario is as follows:](figure/ndn_hydra_slice_ping_scheme.png)


### Testing

- From "ndn_hydra_client_2tx_2rx" ping  the tap interfaces of "ndn_hydra_rx1" and "ndn_hydra_rx2" with IPs 1.1.1.2 and 2.2.2.2, respectively.
```
ping 1.1.1.2
```
or
```
ping 2.2.2.2
```

- From "ndn_hydra_rx1" ping the tap0 interface of ""ndn_hydra_client_2tx_2rx", IP 1.1.1.1
```
ping 1.1.1.1
```


- From "ndn_hydra_rx2" ping the tap1 interface of ""ndn_hydra_client_2tx_2rx", IP 2.2.2.1
```
ping 2.2.2.1
```

## Troubleshooting

Access our OpenStack server. 

![You should see your VMs as shown below:](figure/ndn_vms_open_stack.png)


Access each VM and kill the python process.



* In machine "ndn_hydra-server" exec (replace 192.168.5.54 by the ip of iris2):
```
python ~/gr-hydra/grc_blocks/app/ansible_hydra_gr_server.py --ansibleIPPort 192.168.5.54:5000
```

* In machine "ndn_hydra_client_2tx_2rx" exec (replace 192.168.5.82 by the IP of iris2):
```
python ~/gr-hydra/grc_blocks/app/ansible_hydra_gr_client_2tx_2rx.py --ansibleIP 192.168.5.82
```

* In machine "ndn_hydra_rx1" exec:
```
python ~/gr-hydra/grc_blocks/app/ansible_hydra_vr1_rx.py
```

* In machine "ndn_hydra_rx1" exec (will request aideens_dolmen segments 000-057 x 30times):
```
for ii in {000..030}; do for i in {000..057}; do ndncatchunks ndn:/dp/data/cc/aideens_dolmen_19_$i >file.ou ; done;echo "-------------------------";echo $ii;echo "-------------------------"; done
```
* In machine "ndn_hydra_rx2" exec:
```
python ~/gr-hydra/grc_blocks/app/ansible_hydra_vr2_rx.py
```
* In machine "ndn_hydra_rx2" exec (will request aideens_dolmen segments 000-057 x 30times):
```
for ii in {000..030}; do for i in {000..057}; do ndncatchunks ndn:/dp/data/cc/aideens_dolmen_19_$i >file.ou ; done;echo "-------------------------";echo $ii;echo "-------------------------"; done

