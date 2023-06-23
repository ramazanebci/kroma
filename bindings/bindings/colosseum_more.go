// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package bindings

import (
	"encoding/json"

	"github.com/kroma-network/kroma/bindings/solc"
)

const ColosseumStorageLayoutJSON = "{\"storage\":[{\"astId\":1000,\"contract\":\"contracts/L1/Colosseum.sol:Colosseum\",\"label\":\"_initialized\",\"offset\":0,\"slot\":\"0\",\"type\":\"t_uint8\"},{\"astId\":1001,\"contract\":\"contracts/L1/Colosseum.sol:Colosseum\",\"label\":\"_initializing\",\"offset\":1,\"slot\":\"0\",\"type\":\"t_bool\"},{\"astId\":1002,\"contract\":\"contracts/L1/Colosseum.sol:Colosseum\",\"label\":\"segmentsLengths\",\"offset\":0,\"slot\":\"1\",\"type\":\"t_mapping(t_uint256,t_uint256)\"},{\"astId\":1003,\"contract\":\"contracts/L1/Colosseum.sol:Colosseum\",\"label\":\"challenges\",\"offset\":0,\"slot\":\"2\",\"type\":\"t_mapping(t_uint256,t_struct(Challenge)1005_storage)\"},{\"astId\":1004,\"contract\":\"contracts/L1/Colosseum.sol:Colosseum\",\"label\":\"verifiedPublicInputs\",\"offset\":0,\"slot\":\"3\",\"type\":\"t_mapping(t_bytes32,t_bool)\"}],\"types\":{\"t_address\":{\"encoding\":\"inplace\",\"label\":\"address\",\"numberOfBytes\":\"20\"},\"t_array(t_bytes32)dyn_storage\":{\"encoding\":\"dynamic_array\",\"label\":\"bytes32[]\",\"numberOfBytes\":\"32\"},\"t_bool\":{\"encoding\":\"inplace\",\"label\":\"bool\",\"numberOfBytes\":\"1\"},\"t_bytes32\":{\"encoding\":\"inplace\",\"label\":\"bytes32\",\"numberOfBytes\":\"32\"},\"t_mapping(t_bytes32,t_bool)\":{\"encoding\":\"mapping\",\"label\":\"mapping(bytes32 =\u003e bool)\",\"numberOfBytes\":\"32\",\"key\":\"t_bytes32\",\"value\":\"t_bool\"},\"t_mapping(t_uint256,t_struct(Challenge)1005_storage)\":{\"encoding\":\"mapping\",\"label\":\"mapping(uint256 =\u003e struct Types.Challenge)\",\"numberOfBytes\":\"32\",\"key\":\"t_uint256\",\"value\":\"t_struct(Challenge)1005_storage\"},\"t_mapping(t_uint256,t_uint256)\":{\"encoding\":\"mapping\",\"label\":\"mapping(uint256 =\u003e uint256)\",\"numberOfBytes\":\"32\",\"key\":\"t_uint256\",\"value\":\"t_uint256\"},\"t_struct(Challenge)1005_storage\":{\"encoding\":\"inplace\",\"label\":\"struct Types.Challenge\",\"numberOfBytes\":\"192\"},\"t_uint256\":{\"encoding\":\"inplace\",\"label\":\"uint256\",\"numberOfBytes\":\"32\"},\"t_uint64\":{\"encoding\":\"inplace\",\"label\":\"uint64\",\"numberOfBytes\":\"8\"},\"t_uint8\":{\"encoding\":\"inplace\",\"label\":\"uint8\",\"numberOfBytes\":\"1\"}}}"

var ColosseumStorageLayout = new(solc.StorageLayout)

var ColosseumDeployedBin = "0x608060405234801561001057600080fd5b506004361061018c5760003560e01c806357133278116100e35780638f1d37761161008c578063cfb4474d11610066578063cfb4474d146104c0578063d2ee3075146104e7578063d5145ebc1461050e57600080fd5b80638f1d37761461039a5780639ded395214610486578063b8b1a27c146104ad57600080fd5b80635c622a0e116100bd5780635c622a0e146103545780636fe0e559146103745780637ecc14be1461038757600080fd5b8063571332781461031b578063572419a01461032e578063586b74141461034157600080fd5b80631f6ee4c5116101455780634394c5841161011f5780634394c584146102aa5780635375b891146102df57806354fd4d501461030657600080fd5b80631f6ee4c51461025b57806329204bc814610270578063360864171461028357600080fd5b80631728fad1116101765780631728fad1146102055780631bdd4b74146102185780631be4e27e1461023857600080fd5b80621c2ff6146101915780630d304c08146101e2575b600080fd5b6101b87f000000000000000000000000000000000000000000000000000000000000000081565b60405173ffffffffffffffffffffffffffffffffffffffff90911681526020015b60405180910390f35b6101f56101f0366004612fa1565b610535565b60405190151581526020016101d9565b6101f5610213366004612fa1565b610553565b61022b610226366004612fa1565b61056a565b6040516101d99190612ff5565b6101f5610246366004612fa1565b60036020526000908152604090205460ff1681565b61026e61026936600461314b565b6106ad565b005b6101f561027e366004613277565b6107f6565b6101b87f000000000000000000000000000000000000000000000000000000000000000081565b6102d17f000000000000000000000000000000000000000000000000000000000000000081565b6040519081526020016101d9565b6102d17f000000000000000000000000000000000000000000000000000000000000000081565b61030e610860565b6040516101d99190613321565b61026e610329366004613334565b610903565b61026e61033c366004612fa1565b610a9e565b61026e61034f366004612fa1565b610b74565b610367610362366004612fa1565b610e6e565b6040516101d991906133b6565b61026e6103823660046134e7565b610e85565b61026e61039536600461357d565b610fff565b6104216103a8366004612fa1565b6002602052600090815260409020805460018201546003830154600484015460059094015460ff8085169567ffffffffffffffff61010087041695690100000000000000000081049092169473ffffffffffffffffffffffffffffffffffffffff6a010000000000000000000090930483169492169288565b6040805160ff909916895267ffffffffffffffff90971660208901529415159587019590955273ffffffffffffffffffffffffffffffffffffffff92831660608701529116608085015260a084015260c083019190915260e0820152610100016101d9565b6101b87f000000000000000000000000000000000000000000000000000000000000000081565b6102d16104bb3660046135c9565b6115bb565b6102d17f000000000000000000000000000000000000000000000000000000000000000081565b6102d17f000000000000000000000000000000000000000000000000000000000000000081565b6102d17f000000000000000000000000000000000000000000000000000000000000000081565b600081815260026020526040812061054c81611654565b9392505050565b600081815260026020526040812061054c81611668565b604080516101208101825260008082526020820181905291810182905260608082018390526080820183905260a082015260c0810182905260e08101829052610100810191909152600082815260026020818152604092839020835161012081018552815460ff808216835267ffffffffffffffff61010083041683860152690100000000000000000082041615158287015273ffffffffffffffffffffffffffffffffffffffff6a010000000000000000000090910481166060830152600183015416608082015292810180548551818502810185019096528086529394919360a086019383018282801561067f57602002820191906000526020600020905b81548152602001906001019080831161066b575b5050505050815260200160038201548152602001600482015481526020016005820154815250509050919050565b60008b81526002602052604090206106c4816116b0565b6106d08a828b8b611846565b6106dc89898989611a3b565b60006106ec8a6020013589611b56565b60008181526003602052604090205490915060ff161561079f5760405162461bcd60e51b815260206004820152604d60248201527f436f6c6f737365756d3a207075626c696320696e70757420746861742068617360448201527f20616c7265616479206265656e2076616c6964617465642063616e6e6f74206260648201527f65207573656420616761696e2e00000000000000000000000000000000000000608482015260a4015b60405180910390fd5b600081815260036020526040902080547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00166001179055600582018c90556107e78d8d611c09565b50505050505050505050505050565b6000828152600260205260408120805473ffffffffffffffffffffffffffffffffffffffff8481166a01000000000000000000009092041614806108565750600181015473ffffffffffffffffffffffffffffffffffffffff8481169116145b9150505b92915050565b606061088b7f0000000000000000000000000000000000000000000000000000000000000000611d90565b6108b47f0000000000000000000000000000000000000000000000000000000000000000611d90565b6108dd7f0000000000000000000000000000000000000000000000000000000000000000611d90565b6040516020016108ef939291906135ec565b604051602081830303815290604052905090565b600084815260026020526040902061091a816116b0565b805460009061092d9060ff166001613691565b90506109b881836002018781548110610948576109486136b6565b90600052602060002001548460020188600161096491906136e5565b81548110610974576109746136b6565b9060005260206000200154878780806020026020016040519081016040528093929190818152602001838360200280828437600092019190915250611ecd92505050565b60006109c383612073565b905060006109d182886136fd565b84600401546109e091906136e5565b9050610a238487878080602002602001604051908101604052809392919081815260200183836020028082843760009201919091525086925087915061209f9050565b83547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff001660ff8416178455610a57846120c9565b6040805160ff8516815242602082015289917fa2bae20ceacd256f82b17383dce1a4ae47160249716414a902f45a7f234e8302910160405180910390a25050505050505050565b6000818152600260205260409020610ab5816116b0565b6000828152600260208190526040822080547fffff0000000000000000000000000000000000000000000000000000000000001681556001810180547fffffffffffffffffffffffff00000000000000000000000000000000000000001690559190610b2390830182612f23565b506000600382018190556004820181905560059091015560405142815282907fe8f652f9f21a63a0e34171413bdc9d92cd79d0bb8bc66f3c92efedf25a3e32db906020015b60405180910390a25050565b3373ffffffffffffffffffffffffffffffffffffffff7f00000000000000000000000000000000000000000000000000000000000000001614610c1f5760405162461bcd60e51b815260206004820152602d60248201527f436f6c6f737365756d3a2073656e646572206973206e6f74207468652073656360448201527f757269747920636f756e63696c000000000000000000000000000000000000006064820152608401610796565b60008181526002602052604090206006610c388261216a565b6007811115610c4957610c49613387565b14610cbc5760405162461bcd60e51b815260206004820152602760248201527f436f6c6f737365756d3a2074686973206368616c6c656e6765206973206e6f7460448201527f2070726f76656e000000000000000000000000000000000000000000000000006064820152608401610796565b600581015460018201546040517fe664672300000000000000000000000000000000000000000000000000000000815260048101859052602481019290925273ffffffffffffffffffffffffffffffffffffffff90811660448301527f0000000000000000000000000000000000000000000000000000000000000000169063e664672390606401600060405180830381600087803b158015610d5e57600080fd5b505af1158015610d72573d6000803e3d6000fd5b5050506000838152600260208190526040822080547fffff0000000000000000000000000000000000000000000000000000000000001681556001810180547fffffffffffffffffffffffff00000000000000000000000000000000000000001690559250610de390830182612f23565b50600060038201819055600482018190556005909101819055828152600260205260409081902080547fffffffffffffffffffffffffffffffffffffffffffff00ffffffffffffffffff1669010000000000000000001790555182907f1527ad5e6cfbfe249bfd6f9571cbfee0ce4a12335089fa9c6efeab04fec1f7a390610b689042815260200190565b600081815260026020526040812061054c8161216a565b600054610100900460ff1615808015610ea55750600054600160ff909116105b80610ebf5750303b158015610ebf575060005460ff166001145b610f315760405162461bcd60e51b815260206004820152602e60248201527f496e697469616c697a61626c653a20636f6e747261637420697320616c72656160448201527f647920696e697469616c697a65640000000000000000000000000000000000006064820152608401610796565b600080547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff001660011790558015610f8f57600080547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff166101001790555b610f9882612277565b8015610ffb57600080547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff169055604051600181527f7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb38474024989060200160405180910390a15b5050565b600083116110755760405162461bcd60e51b815260206004820152603660248201527f436f6c6f737365756d3a206368616c6c656e676520666f722067656e6573697360448201527f206f7574707574206973206e6f7420616c6c6f776564000000000000000000006064820152608401610796565b600083815260026020526040902061108c81611668565b156111255760405162461bcd60e51b815260206004820152605360248201527f436f6c6f737365756d3a20746865206368616c6c656e676520666f722067697660448201527f656e206f757470757420696e64657820697320616c726561647920696e20707260648201527f6f6772657373206f7220617070726f7665642e00000000000000000000000000608482015260a401610796565b6040517fa25ae557000000000000000000000000000000000000000000000000000000008152600481018590526000907f000000000000000000000000000000000000000000000000000000000000000073ffffffffffffffffffffffffffffffffffffffff169063a25ae55790602401608060405180830381865afa1580156111b3573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906111d7919061373c565b905080606001516fffffffffffffffffffffffffffffffff1660000361123f5760405162461bcd60e51b815260206004820152601b60248201527f436f6c6f737365756d3a206f7574707574206e6f7420666f756e6400000000006044820152606401610796565b805173ffffffffffffffffffffffffffffffffffffffff1633036112cb5760405162461bcd60e51b815260206004820152603860248201527f436f6c6f737365756d3a2074686520617373657274657220616e64206368616c60448201527f6c656e676572206d75737420626520646966666572656e7400000000000000006064820152608401610796565b6113286001858560008181106112e3576112e36136b6565b905060200201358360200151878780806020026020016040519081016040528093929190818152602001838360200280828437600092019190915250611ecd92505050565b7f000000000000000000000000000000000000000000000000000000000000000073ffffffffffffffffffffffffffffffffffffffff1663b98debbf6040518163ffffffff1660e01b8152600401602060405180830381865afa158015611393573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906113b791906137b4565b6040517fda3893f00000000000000000000000000000000000000000000000000000000081523360048201526024810187905273ffffffffffffffffffffffffffffffffffffffff919091169063da3893f090604401600060405180830381600087803b15801561142757600080fd5b505af115801561143b573d6000803e3d6000fd5b505050506114de82858580806020026020016040519081016040528093929190818152602001838360200280828437600092019190915250505060608501516114b891507f0000000000000000000000000000000000000000000000000000000000000000906fffffffffffffffffffffffffffffffff166137d1565b7f000000000000000000000000000000000000000000000000000000000000000061209f565b8154815173ffffffffffffffffffffffffffffffffffffffff166a0100000000000000000000027fffff0000000000000000000000000000000000000000ffffffffffffffffff009091161760019081178355820180547fffffffffffffffffffffffff00000000000000000000000000000000000000001633179055611564826120c9565b8051604051428152339173ffffffffffffffffffffffffffffffffffffffff169087907fd2f7931a802085b3d0234d4c320ce7ee0041da96678ce2bf5c93e8d3d7e65f529060200160405180910390a45050505050565b6000600160ff831610156116115760405162461bcd60e51b815260206004820152601760248201527f436f6c6f737365756d3a20696e76616c6964207475726e0000000000000000006044820152606401610796565b6001600061161f82856137e8565b60ff168152602001908152602001600020549050919050565b73ffffffffffffffffffffffffffffffffffffffff163b151590565b6000600161166183612073565b1192915050565b6000806116748361216a565b9050600081600781111561168a5761168a613387565b1415801561054c575060038160078111156116a7576116a7613387565b14159392505050565b60006116bb8261216a565b9050600060018260078111156116d3576116d3613387565b14806116f0575060058260078111156116ee576116ee613387565b145b8061170c5750600482600781111561170a5761170a613387565b145b156117325750600182015473ffffffffffffffffffffffffffffffffffffffff166117dc565b600282600781111561174657611746613387565b14806117635750600382600781111561176157611761613387565b145b15611794575081546a0100000000000000000000900473ffffffffffffffffffffffffffffffffffffffff166117dc565b60405162461bcd60e51b815260206004820152601e60248201527f436f6c6f737365756d3a20756e61626c6520746f2062652063616c6c656400006044820152606401610796565b73ffffffffffffffffffffffffffffffffffffffff811633146118415760405162461bcd60e51b815260206004820152601860248201527f436f6c6f737365756d3a206e6f7420796f7572207475726e00000000000000006044820152606401610796565b505050565b600061185f61185a3685900385018561380b565b612407565b9050600061187561185a3685900385018561380b565b905061188085611654565b6119b6578185600201878154811061189a5761189a6136b6565b9060005260206000200154146119185760405162461bcd60e51b815260206004820152602d60248201527f436f6c6f737365756d3a2074686520736f75726365207365676d656e74206d7560448201527f7374206265206d617463686564000000000000000000000000000000000000006064820152608401610796565b80600286016119288860016136e5565b81548110611938576119386136b6565b9060005260206000200154036119b65760405162461bcd60e51b815260206004820152603660248201527f436f6c6f737365756d3a207468652064657374696e6174696f6e207365676d6560448201527f6e74206d757374206e6f74206265206d617463686564000000000000000000006064820152608401610796565b8260600135846080013514611a335760405162461bcd60e51b815260206004820152602960248201527f436f6c6f737365756d3a2074686520626c6f636b2068617368206d757374206260448201527f65206d61746368656400000000000000000000000000000000000000000000006064820152608401610796565b505050505050565b82602001358260e0013514611ab85760405162461bcd60e51b815260206004820152602960248201527f436f6c6f737365756d3a2074686520737461746520726f6f74206d757374206260448201527f65206d61746368656400000000000000000000000000000000000000000000006064820152608401610796565b6000611ad4611ac6846138f9565b611acf84613a43565b61249f565b905080856080013514611b4f5760405162461bcd60e51b815260206004820152602960248201527f436f6c6f737365756d3a2074686520626c6f636b2068617368206d757374206260448201527f65206d61746368656400000000000000000000000000000000000000000000006064820152608401610796565b5050505050565b600060607f0000000000000000000000000000000000000000000000000000000000000000611b89610120850185613bb9565b90501015611bf657611bf37f0000000000000000000000000000000000000000000000000000000000000000611bc3610120860186613bb9565b611bee91507f00000000000000000000000000000000000000000000000000000000000000006137d1565b6124f6565b90505b61085684611c03856138f9565b83612582565b73ffffffffffffffffffffffffffffffffffffffff7f00000000000000000000000000000000000000000000000000000000000000001663b46bd88582611c707f0000000000000000000000000000000000000000000000000000000000000000866136fd565b60405160248101879052604401604080517fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe08184030181529181526020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff167f586b7414000000000000000000000000000000000000000000000000000000001790525160e085901b7fffffffff00000000000000000000000000000000000000000000000000000000168152611d2c93929190600401613c21565b600060405180830381600087803b158015611d4657600080fd5b505af1158015611d5a573d6000803e3d6000fd5b50505050817fc2abee209438b2b732f3df51f48b7cc99f73c9965f06680549f28f36a2dc244782604051610b6891815260200190565b606081600003611dd357505060408051808201909152600181527f3000000000000000000000000000000000000000000000000000000000000000602082015290565b8160005b8115611dfd5780611de781613c5b565b9150611df69050600a83613ca4565b9150611dd7565b60008167ffffffffffffffff811115611e1857611e186133f7565b6040519080825280601f01601f191660200182016040528015611e42576020820181803683370190505b5090505b8415611ec557611e576001836137d1565b9150611e64600a86613cb8565b611e6f9060306136e5565b60f81b818381518110611e8457611e846136b6565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a905350611ebe600a86613ca4565b9450611e46565b949350505050565b805180611ed9866115bb565b14611f4c5760405162461bcd60e51b815260206004820152602260248201527f436f6c6f737365756d3a20696e76616c6964207365676d656e7473206c656e6760448201527f74680000000000000000000000000000000000000000000000000000000000006064820152608401610796565b81600081518110611f5f57611f5f6136b6565b60200260200101518414611fdb5760405162461bcd60e51b815260206004820152602c60248201527f436f6c6f737365756d3a20746865206669727374207365676d656e74206d757360448201527f74206265206d61746368656400000000000000000000000000000000000000006064820152608401610796565b81611fe76001836137d1565b81518110611ff757611ff76136b6565b60200260200101518303611b4f5760405162461bcd60e51b815260206004820152602f60248201527f436f6c6f737365756d3a20746865206c617374207365676d656e74206d75737460448201527f206e6f74206265206d61746368656400000000000000000000000000000000006064820152608401610796565b805460009060ff166001612086826115bb565b61209091906137d1565b836003015461054c9190613ca4565b82516120b49060028601906020860190612f41565b50600484019190915560039092019190915550565b6120d281611654565b61213d576121007f0000000000000000000000000000000000000000000000000000000000000000426136e5565b815467ffffffffffffffff91909116610100027fffffffffffffffffffffffffffffffffffffffffffffff0000000000000000ff90911617815550565b6121007f0000000000000000000000000000000000000000000000000000000000000000426136e5565b50565b80546000906901000000000000000000900460ff161561218c57506007919050565b8154600160ff90911610156121a357506000919050565b6005820154156121b557506006919050565b81546000906121c69060ff166125f6565b8354909150610100900467ffffffffffffffff1642111561224c5780156121f05750600392915050565b825461223590612230907f000000000000000000000000000000000000000000000000000000000000000090610100900467ffffffffffffffff166136e5565b421190565b156122435750600392915050565b50600492915050565b61225583611654565b6122625750600592915050565b8061226e57600261054c565b60019392505050565b600281516122859190613cb8565b156122f85760405162461bcd60e51b815260206004820152603b60248201527f436f6c6f737365756d3a206c656e677468206f66207365676d656e7473206c6560448201527f6e677468732063616e6e6f74206265206f6464206e756d6265722e00000000006064820152608401610796565b600160005b825181101561237157828181518110612318576123186136b6565b60200260200101516001600083815260200190815260200160002081905550600183828151811061234b5761234b6136b6565b602002602001015161235d91906137d1565b61236790836136fd565b91506001016122fd565b507f00000000000000000000000000000000000000000000000000000000000000008114610ffb5760405162461bcd60e51b815260206004820152602360248201527f436f6c6f737365756d3a20696e76616c6964207365676d656e7473206c656e6760448201527f74687300000000000000000000000000000000000000000000000000000000006064820152608401610796565b80516000906124195761085a8261260d565b81516000190161242c5761085a82612669565b60405162461bcd60e51b815260206004820152602a60248201527f48617368696e673a20756e6b6e6f776e206f757470757420726f6f742070726f60448201527f6f662076657273696f6e000000000000000000000000000000000000000000006064820152608401610796565b919050565b6040805160108082526102208201909252600091829190816020015b60608152602001906001900390816124bb5790505090506124dd8484836126ac565b6124e681612973565b8051906020012091505092915050565b606060008267ffffffffffffffff811115612513576125136133f7565b60405190808252806020026020018201604052801561253c578160200160208202803683370190505b50905060005b8381101561257a578482828151811061255d5761255d6136b6565b60209081029190910101528061257281613c5b565b915050612542565b509392505050565b6000838360e0015184610100015185600001518660200151876060015188604001518960a001518a608001518b6101200151518c61012001518c6040516020016125d79c9b9a99989796959493929190613cf1565b6040516020818303038152906040528051906020012090509392505050565b6000612603600283613daa565b60ff161592915050565b6000816000015182602001518360400151846060015160405160200161264c949392919093845260208401929092526040830152606082015260800190565b604051602081830303815290604052805190602001209050919050565b80516020808301516040808501516060808701516080808901518551978801989098529386019490945284015282015260a081019190915260009060c00161264c565b6126da83602001516040516020016126c691815260200190565b6040516020818303038152906040526129b7565b816000815181106126ed576126ed6136b6565b6020026020010181905250816000015181600181518110612710576127106136b6565b6020026020010181905250816020015181600281518110612733576127336136b6565b60200260200101819052506127588360e001516040516020016126c691815260200190565b8160038151811061276b5761276b6136b6565b60200260200101819052506127908360c001516040516020016126c691815260200190565b816004815181106127a3576127a36136b6565b60200260200101819052508160400151816005815181106127c6576127c66136b6565b60200260200101819052508160600151816006815181106127e9576127e96136b6565b602002602001018190525081608001518160078151811061280c5761280c6136b6565b602002602001018190525061282e836060015167ffffffffffffffff16612a26565b81600881518110612841576128416136b6565b6020026020010181905250612863836080015167ffffffffffffffff16612a26565b81600981518110612876576128766136b6565b60200260200101819052508160a0015181600a81518110612899576128996136b6565b60200260200101819052506128bb836040015167ffffffffffffffff16612a26565b81600b815181106128ce576128ce6136b6565b60200260200101819052508160c0015181600c815181106128f1576128f16136b6565b60200260200101819052508160e0015181600d81518110612914576129146136b6565b602002602001018190525081610100015181600e81518110612938576129386136b6565b60200260200101819052506129508360a00151612a26565b81600f81518110612963576129636136b6565b6020026020010181905250505050565b6060600061298083612a39565b905061298e815160c0612b71565b816040516020016129a0929190613dcc565b604051602081830303815290604052915050919050565b606080825160011480156129e557506080836000815181106129db576129db6136b6565b016020015160f81c105b156129f157508161085a565b6129fd83516080612b71565b83604051602001612a0f929190613dcc565b604051602081830303815290604052905092915050565b606061085a612a3483612d67565b6129b7565b60608151600003612a5857505060408051600081526020810190915290565b6000805b8351811015612a9f57838181518110612a7757612a776136b6565b60200260200101515182612a8b91906136e5565b915080612a9781613c5b565b915050612a5c565b60008267ffffffffffffffff811115612aba57612aba6133f7565b6040519080825280601f01601f191660200182016040528015612ae4576020820181803683370190505b50600092509050602081015b8551831015612b68576000868481518110612b0d57612b0d6136b6565b602002602001015190506000602082019050612b2b83828451612ec6565b878581518110612b3d57612b3d6136b6565b60200260200101515183612b5191906136e5565b925050508280612b6090613c5b565b935050612af0565b50949350505050565b6060806038841015612bf05760408051600180825281830190925290602082018180368337019050509050612ba68385613691565b60f81b81600081518110612bbc57612bbc6136b6565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a90535061054c565b600060015b612bff8187613ca4565b15612c255781612c0e81613c5b565b9250612c1e9050610100826136fd565b9050612bf5565b612c308260016136e5565b67ffffffffffffffff811115612c4857612c486133f7565b6040519080825280601f01601f191660200182016040528015612c72576020820181803683370190505b509250612c7f8583613691565b612c8a906037613691565b60f81b83600081518110612ca057612ca06136b6565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a905350600190505b818111612d5e57610100612ce882846137d1565b612cf490610100613edf565b612cfe9088613ca4565b612d089190613cb8565b60f81b838281518110612d1d57612d1d6136b6565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a90535080612d5681613c5b565b915050612cd4565b50509392505050565b6060600082604051602001612d7e91815260200190565b604051602081830303815290604052905060005b6020811015612ded57818181518110612dad57612dad6136b6565b01602001517fff0000000000000000000000000000000000000000000000000000000000000016600003612ded5780612de581613c5b565b915050612d92565b6000612dfa8260206137d1565b67ffffffffffffffff811115612e1257612e126133f7565b6040519080825280601f01601f191660200182016040528015612e3c576020820181803683370190505b50905060005b8151811015612b68578383612e5681613c5b565b945081518110612e6857612e686136b6565b602001015160f81c60f81b828281518110612e8557612e856136b6565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a90535080612ebe81613c5b565b915050612e42565b8282825b60208110612f025781518352612ee16020846136e5565b9250612eee6020836136e5565b9150612efb6020826137d1565b9050612eca565b905182516020929092036101000a6000190180199091169116179052505050565b50805460008255906000526020600020908101906121679190612f8c565b828054828255906000526020600020908101928215612f7c579160200282015b82811115612f7c578251825591602001919060010190612f61565b50612f88929150612f8c565b5090565b5b80821115612f885760008155600101612f8d565b600060208284031215612fb357600080fd5b5035919050565b600081518084526020808501945080840160005b83811015612fea57815187529582019590820190600101612fce565b509495945050505050565b6020815261300960208201835160ff169052565b60006020830151613026604084018267ffffffffffffffff169052565b506040830151801515606084015250606083015173ffffffffffffffffffffffffffffffffffffffff8116608084015250608083015173ffffffffffffffffffffffffffffffffffffffff811660a08401525060a08301516101208060c0850152613095610140850183612fba565b60c086015160e08681019190915286015161010080870191909152909501519301929092525090919050565b600060a082840312156130d357600080fd5b50919050565b600061014082840312156130d357600080fd5b600061012082840312156130d357600080fd5b60008083601f84011261311157600080fd5b50813567ffffffffffffffff81111561312957600080fd5b6020830191508360208260051b850101111561314457600080fd5b9250929050565b60008060008060008060008060008060006102208c8e03121561316d57600080fd5b8b359a5060208c0135995060408c0135985061318c8d60608e016130c1565b975061319c8d6101008e016130c1565b965067ffffffffffffffff806101a08e013511156131b957600080fd5b6131ca8e6101a08f01358f016130d9565b9650806101c08e013511156131de57600080fd5b6131ef8e6101c08f01358f016130ec565b9550806101e08e0135111561320357600080fd5b6132148e6101e08f01358f016130ff565b90955093506102008d013581101561322b57600080fd5b5061323d8d6102008e01358e016130ff565b81935080925050509295989b509295989b9093969950565b73ffffffffffffffffffffffffffffffffffffffff8116811461216757600080fd5b6000806040838503121561328a57600080fd5b82359150602083013561329c81613255565b809150509250929050565b60005b838110156132c25781810151838201526020016132aa565b838111156132d1576000848401525b50505050565b600081518084526132ef8160208601602086016132a7565b601f017fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0169290920160200192915050565b60208152600061054c60208301846132d7565b6000806000806060858703121561334a57600080fd5b8435935060208501359250604085013567ffffffffffffffff81111561336f57600080fd5b61337b878288016130ff565b95989497509550505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602160045260246000fd5b60208101600883106133f1577f4e487b7100000000000000000000000000000000000000000000000000000000600052602160045260246000fd5b91905290565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b604051610140810167ffffffffffffffff8111828210171561344a5761344a6133f7565b60405290565b604051610120810167ffffffffffffffff8111828210171561344a5761344a6133f7565b604051601f82017fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe016810167ffffffffffffffff811182821017156134bb576134bb6133f7565b604052919050565b600067ffffffffffffffff8211156134dd576134dd6133f7565b5060051b60200190565b600060208083850312156134fa57600080fd5b823567ffffffffffffffff81111561351157600080fd5b8301601f8101851361352257600080fd5b8035613535613530826134c3565b613474565b81815260059190911b8201830190838101908783111561355457600080fd5b928401925b8284101561357257833582529284019290840190613559565b979650505050505050565b60008060006040848603121561359257600080fd5b83359250602084013567ffffffffffffffff8111156135b057600080fd5b6135bc868287016130ff565b9497909650939450505050565b6000602082840312156135db57600080fd5b813560ff8116811461054c57600080fd5b600084516135fe8184602089016132a7565b80830190507f2e00000000000000000000000000000000000000000000000000000000000000808252855161363a816001850160208a016132a7565b600192019182015283516136558160028401602088016132a7565b0160020195945050505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b600060ff821660ff84168060ff038211156136ae576136ae613662565b019392505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b600082198211156136f8576136f8613662565b500190565b600081600019048311821515161561371757613717613662565b500290565b80516fffffffffffffffffffffffffffffffff8116811461249a57600080fd5b60006080828403121561374e57600080fd5b6040516080810181811067ffffffffffffffff82111715613771576137716133f7565b604052825161377f81613255565b8152602083810151908201526137976040840161371c565b60408201526137a86060840161371c565b60608201529392505050565b6000602082840312156137c657600080fd5b815161054c81613255565b6000828210156137e3576137e3613662565b500390565b600060ff821660ff84168082101561380257613802613662565b90039392505050565b600060a0828403121561381d57600080fd5b60405160a0810181811067ffffffffffffffff82111715613840576138406133f7565b806040525082358152602083013560208201526040830135604082015260608301356060820152608083013560808201528091505092915050565b803567ffffffffffffffff8116811461249a57600080fd5b600082601f8301126138a457600080fd5b813560206138b4613530836134c3565b82815260059290921b840181019181810190868411156138d357600080fd5b8286015b848110156138ee57803583529183019183016138d7565b509695505050505050565b6000610140823603121561390c57600080fd5b613914613426565b823581526020830135602082015261392e6040840161387b565b604082015261393f6060840161387b565b60608201526139506080840161387b565b608082015260a083013560a082015260c083013560c082015260e083013560e08201526101008084013581830152506101208084013567ffffffffffffffff81111561399b57600080fd5b6139a736828701613893565b918301919091525092915050565b600082601f8301126139c657600080fd5b813567ffffffffffffffff8111156139e0576139e06133f7565b613a1160207fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f84011601613474565b818152846020838601011115613a2657600080fd5b816020850160208301376000918101602001919091529392505050565b60006101208236031215613a5657600080fd5b613a5e613450565b823567ffffffffffffffff80821115613a7657600080fd5b613a82368387016139b5565b83526020850135915080821115613a9857600080fd5b613aa4368387016139b5565b60208401526040850135915080821115613abd57600080fd5b613ac9368387016139b5565b60408401526060850135915080821115613ae257600080fd5b613aee368387016139b5565b60608401526080850135915080821115613b0757600080fd5b613b13368387016139b5565b608084015260a0850135915080821115613b2c57600080fd5b613b38368387016139b5565b60a084015260c0850135915080821115613b5157600080fd5b613b5d368387016139b5565b60c084015260e0850135915080821115613b7657600080fd5b613b82368387016139b5565b60e084015261010091508185013581811115613b9d57600080fd5b613ba9368288016139b5565b8385015250505080915050919050565b60008083357fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe1843603018112613bee57600080fd5b83018035915067ffffffffffffffff821115613c0957600080fd5b6020019150600581901b360382131561314457600080fd5b8381526fffffffffffffffffffffffffffffffff83166020820152606060408201526000613c5260608301846132d7565b95945050505050565b60006000198203613c6e57613c6e613662565b5060010190565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601260045260246000fd5b600082613cb357613cb3613c75565b500490565b600082613cc757613cc7613c75565b500690565b80516000906020808401838315612fea57815187529582019590820190600101612fce565b8c81528b60208201528a604082015289606082015288608082015260007fffffffffffffffff000000000000000000000000000000000000000000000000808a60c01b1660a0840152808960c01b1660a88401528760b0840152808760c01b1660d0840152507fffff0000000000000000000000000000000000000000000000000000000000008560f01b1660d8830152613d98613d9260da840186613ccc565b84613ccc565b9e9d5050505050505050505050505050565b600060ff831680613dbd57613dbd613c75565b8060ff84160691505092915050565b60008351613dde8184602088016132a7565b835190830190613df28183602088016132a7565b01949350505050565b600181815b80851115613e36578160001904821115613e1c57613e1c613662565b80851615613e2957918102915b93841c9390800290613e00565b509250929050565b600082613e4d5750600161085a565b81613e5a5750600061085a565b8160018114613e705760028114613e7a57613e96565b600191505061085a565b60ff841115613e8b57613e8b613662565b50506001821b61085a565b5060208310610133831016604e8410600b8410161715613eb9575081810a61085a565b613ec38383613dfb565b8060001904821115613ed757613ed7613662565b029392505050565b600061054c8383613e3e56fea164736f6c634300080f000a"

func init() {
	if err := json.Unmarshal([]byte(ColosseumStorageLayoutJSON), ColosseumStorageLayout); err != nil {
		panic(err)
	}

	layouts["Colosseum"] = ColosseumStorageLayout
	deployedBytecodes["Colosseum"] = ColosseumDeployedBin
}
