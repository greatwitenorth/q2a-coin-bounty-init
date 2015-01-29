# Setup Q2A with the Coin Bounty plugin
This sets up a fresh ubuntu server running a Bitcoin and Auroracoin wallet, along with a Q2A install. MYSQL, PHP, and Apache are automaitcally installed, and credentials are written to the ```qa-config.php``` file.

# Getting started
```
git clone https://github.com/greatwitenorth/q2a-coin-bounty-init.git
cd q2a-coin-bounty-init
vagrant up
```

## Important
Once the wallets are installed, it will take quite some time for them to download their repsective blockchains and sync with the network. Be patient.

# Configure the plugin
Once the machine has started up, visit [localhost:8080](http://localhost:8080) in your browser to finish setup. You'll then want to navigate to ```Admin -> Plugins``` and click the ```options``` link beside Coin Bounty.

Here you can add in the newly created wallet settings. You'll need to fetch your credentials from the following files:
```
/home/bitcoind/.bitcoind/bitcoind.conf
/home/auroracoind/.auroracoind/auroracoind.conf
```