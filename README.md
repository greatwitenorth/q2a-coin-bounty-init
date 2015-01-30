# Setup Q2A with the Coin Bounty plugin
This sets up a fresh ubuntu server running a Bitcoin and Auroracoin wallet, along with a Q2A install. MYSQL, PHP, and Apache are automaitcally installed, and credentials are written to the ```qa-config.php``` file.

# Getting started
```
git clone https://github.com/greatwitenorth/q2a-coin-bounty-init.git
cd q2a-coin-bounty-init
vagrant up
```

## Install on VPS
If you want to try this on a live VPS just execute the init.sh script. Please note you'll need a VPS with at least 40GB storage and about 2GB or ram running Ubuntu 14.04. WARNING: I have not implemented many security features in the install script. Use at your own risk. Also, you'll want to purchase a ssl certificate. This script uses a self assigned one by default.
``` 
source (curl -s https://raw.githubusercontent.com/greatwitenorth/q2a-coin-bounty-init/master/init.sh)
```

## Important
Once the wallets are installed, it will take quite some time for them to download their repsective blockchains and sync with the network. Be patient.

# Configure the plugin
Once the machine has started up, visit [https://localhost:8080](https://localhost:8080) in your browser to finish setup (accept the self signed certificate). You'll then want to navigate to ```Admin -> Plugins``` and click the ```options``` link beside Coin Bounty.

Here you can add in the newly created wallet settings. You'll need to fetch your credentials from the following files:
```
/home/bitcoind/.bitcoind/bitcoind.conf
/home/auroracoind/.auroracoind/auroracoind.conf
```

## Setting up the cron
todo, cron instutions here...