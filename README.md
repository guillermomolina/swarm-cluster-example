# swarm-cluster-example

To be deployed on 3 [google-cloud](https://console.cloud.google.com/compute/instances) virtual macines called instance-1, instance-2 and instance-3

## Master node (instance-1)
```bash
sudo -i
apt install git
git clone https://github.com/guillermomolina/swarm-cluster-example
cd swarm-cluster-example
./run-master.sh
```

## Slave nodes (instance-2 and instance-3)
```bash
sudo -i
apt install git
git clone https://github.com/guillermomolina/swarm-cluster-example
cd swarm-cluster-example
./run-worker.sh
```
