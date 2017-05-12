contract owned{
  address owner;
  function owned () {owner = msg.sender;}
  modifier onlyOwner {
          if (msg.sender != owner)
              throw;
          _;
        }
  }
  
contract ipfsstate is owned{
//variables
string public currentAddr;
uint public dateUpdated;
uint stateCount;

// structure to hold the old addresses and timestamps
struct state {
  string ipfsAddr;    
  uint date;
 }

//mapping
mapping(uint => state) stateList;

//events
event stateUpdate(string comment);

//add a new ipfs state address 
function updater (string _newipfs) onlyOwner {
    //bump the current data to the list of old adrs before adding new data
        uint id = stateCount ++;
        state a = stateList[id];
        a.ipfsAddr = currentAddr;
        a.date = dateUpdated;
    //update the current public data with the new information
        currentAddr = _newipfs;
        dateUpdated = block.timestamp;
    //send an alert event
        stateUpdate('New file has arrived');
    }
//outputs    
function oldstate(uint _id) constant returns (string){
    return stateList[_id].ipfsAddr;
}
function olddate(uint _id) constant returns (uint){
    return stateList[_id].date;
}

//safety functions
function kill() onlyOwner{
      selfdestruct(owner);
      //kills contract 
    }
}
