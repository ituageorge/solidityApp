import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from 'dotenv'

dotenv.config()
const {SEPOLIA_ENDPOINT, PRIVATE_KEY} = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks:{
    sepolia: {
      chainId: 11155111,
      url: SEPOLIA_ENDPOINT,
      accounts: [`${PRIVATE_KEY}`]
    }
  }
};

export default config;
