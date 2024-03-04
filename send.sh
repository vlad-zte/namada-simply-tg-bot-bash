#!/bin/bash           
## v0.1 cometbft                      
source $HOME/.bash_profile  
##
BOT_TOKEN='****'
CHANNEL_ID="-100****"
DAEMON=namadad
RPC_PORT=26657
NODE=http://127.0.0.1:$RPC_PORT
VALIDATOR_ADDRESS=tnam1****
##
DAEMON_STATUS=`systemctl status $DAEMON |grep Active | awk '{print $2}'`
VERSION=`namada --version `
BLOCK_HEIGHT=`curl -s http://localhost:$RPC_PORT/status 2> /dev/null | jq .result.sync_info.latest_block_height | xargs`
PEERS=`curl -s http://localhost:$RPC_PORT/net_info | jq -r '.result.n_peers' `
VOTING_POWER=`curl -s http://localhost:$RPC_PORT/status  2> /dev/null  | jq .result.validator_info.voting_power | xargs`
POSITION=`namada client bonded-stake --node $NODE | grep -v -e "Last committed epoch:" -e "Consensus validators:" | cat -n | grep $VALIDATOR_ADDRESS | awk '{print $1}' `
STATUS_CURRENT=`namadac validator-state --validator $VALIDATOR_ADDRESS --node $NODE | sed "s/Validator $VALIDATOR_ADDRESS//"`
VALIDATOR_ADDRESS_HASH=$(curl -s localhost:26657/status | jq -r .result.validator_info.address)
MISSED_BLOCKS=0
for (( i=$BLOCK_HEIGHT; i>$BLOCK_HEIGHT-50 ; i-- )); do
    signatures=` curl -s "http://localhost:$RPC_PORT/block?height=${i}" | jq -r '.result.block.last_commit.signatures[].validator_address' `
    if ! echo "$signatures" | grep -q $VALIDATOR_ADDRESS_HASH; then
      MISSED_BLOCKS=$((MISSED_BLOCKS+1))
    fi
done
##
echo DAEMON_STATUS $DAEMON_STATUS | tee -a $LOG;
echo VERSION $VERSION | tee -a $LOG;
echo BLOCK_HEIGHT $BLOCK_HEIGHT | tee -a $LOG;
echo PEERS $PEERS | tee -a $LOG;
echo VOTING_POWER $VOTING_POWER | tee -a $LOG;
echo POSITION $POSITION | tee -a $LOG; 
echo STATUS_CURRENT $STATUS_CURRENT | tee -a $LOG;
echo MISSED_BLOCKS $MISSED_BLOCKS | tee -a $LOG;
##
MESSAGE_TEXT=" %0A
DAEMON STATUS $DAEMON_STATUS
VERSION $VERSION
BLOCK HEIGHT $BLOCK_HEIGHT
PEERS $PEERS
VOTING POWER $VOTING_POWER
POSITION $POSITION
STATUS $STATUS_CURRENT
MISSED BLOCKS $MISSED_BLOCKS
"
##
echo $MESSAGE_TEXT
##
curl -s -X POST https://api.telegram.org/bot$BOT_TOKEN/sendMessage \
-d chat_id=$CHANNEL_ID \
-d parse_mode="Markdown" \
-d text="$MESSAGE_TEXT" 
echo ""
