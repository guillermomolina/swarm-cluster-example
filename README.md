# swarm-cluster-example

## Master node
```bash
sudo -i
apt install git
git clone https://github.com/guillermomolina/swarm-cluster-example
cd swarm-cluster-example
./run-master.sh
```

## Slave nodes
```bash
sudo -i
apt install git
git clone https://github.com/guillermomolina/swarm-cluster-example
cd swarm-cluster-example
./run-worker.sh
```
