const {ether} = require("hardhat");
(async () => {
    const contractArtifact = ethers.getContractFactory("TccToken");
    const deployed = await (await contractArtifact).deploy()

    const contractAddress = await deployed.getAddress();
    console.log(`Contract deployed on ${contractAddress} successfully`)
})();