# Ankr + Polygon + Hardhat: Deploy Your First ERC-721 Smart Contract and NFT

If you’re looking to learn how to deploy your first smart contract and mint your first NFT, you’ve come to the right place. This is a tutorial on how to deploy an ERC-721 smart contract with unlimited minting functionality to the Polygon main network using Ankr’s public RPC.

### 🧱 Prerequisites

- [☊ Node.js](https://nodejs.dev/download/)
- [🧵 Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable)
- [🖥 VS Code](https://code.visualstudio.com/Download)
- [🦊 MetaMask](https://metamask.io/download/)

### 🏗 Let’s Get Started

1. Take a look at the ERC-721 page below ⬇️

   [ERC-721](http://erc721.org/)

   - Here are the key points:

     1. “ERC-721 is a free, open standard that describes how to build non-fungible or unique tokens on the Ethereum blockchain.”
     2. “ERC-721 defines a minimum interface a smart contract must implement to allow unique tokens to be managed, owned, and traded. It does not mandate a standard for token metadata or restrict adding supplemental functions.”
     3. Most tokens are fungible, but ERC-721 tokens are all unique. ERC-20 tokens are fungible = every token is the same as every other token

        ![Screen Shot 2022-04-10 at 3.17.17 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2cefbe34-6a6b-4f06-acaa-06740df44dd2/Screen_Shot_2022-04-10_at_3.17.17_PM.png)

2. Take a look at the [Ankr integration with Ethers.js](https://github.com/ethers-io/ethers.js/blob/master/packages/providers/src.ts/ankr-provider.ts#L28)
3. Add Polygon to your MetaMask wallet as a network at [https://ankr.com/protocol/public](https://ankr.com/protocol/public) by clicking the MetaMask button

   ![Screen Shot 2022-04-11 at 2.52.47 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f4276db2-0d79-4d00-b43e-d3e9313ec8a4/Screen_Shot_2022-04-11_at_2.52.47_PM.png)

4. In your terminal, make a new directory called `ankr-polygon-nft`

   ```bash
   mkdir ankr-polygon-nft
   ```

5. Change directories into `ankr-polygon-nft`

   ```bash
   cd ankr-polygon-nft
   ```

6. Initialize the directory with npm

   ```bash
   npm init -y
   ```

7. Add the dependencies using Yarn

   ```bash
   yarn add dotenv hardhat @nomiclabs/hardhat-etherscan @openzeppelin/contracts
   ```

8. Open up VS Code and run `Command + Shift + P`

   1. Type `shell` into the command pallette and hit `enter`, hit `enter` again
   2. Open up VS Code from your terminal

      ```bash
      code .
      ```

9. Initiate Hardhat

   1. What is Hardhat? An Ethereum development environment for testing and deploying smart contracts to the blockchain
   2. Pick `Create a basic sample project` and select `yes` or press `enter` to the default values

   ```bash
   npx hardhat init
   ```

10. Delete `Greeter.sol` in the `Contracts` folder and `sample-script.js` in the `Scripts` folder. You can also delete the `Tests` folder.
11. Create a new file in `Contracts` called `AnkrPolygonNFT.sol`

    1. Add the following code

       ```solidity
       // SPDX-License-Identifier: MIT
       pragma solidity ^0.8.0;

       import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
       import "@openzeppelin/contracts/utils/Counters.sol";
       ```

       1. Line 1 - declares the type of license associated with the contract, in this case, an [MIT license](https://mit-license.org/)
       2. Line 2 - declare the version of solidity to compile this contract
       3. Lines 4-5 - import ERC721 URI storage extension standard and `Counters.sol` which will help set token IDs from [OpenZepplin](https://openzeppelin.com/)

12. Now, we’ll write our contract ⬇️

    ```solidity
    // ...the code above...
    // name your contract and set the storage type (inherited from OpenZeppelin)
    contract AnkrPolygonNFT is ERC721URIStorage {

    // set up our counters
        using Counters for Counters.Counter;
    // use counter to store tokenIds
        Counters.Counter private _tokenIds;

    // pass arguments for name and symbol
        constructor() ERC721("AnkrPolygonNFT", "ANKRPG") {}

    // create mint function with argument for tokenURI which will be a JSON file on IPFS
        function mint(string memory tokenURI) public returns (uint256){

    // use token increment function to count up
            _tokenIds.increment();

    // fetch current tokenId
            uint256 newItemId = _tokenIds.current();

    // safeMint requires address of who is interacting with contract (msg.sender) and tokenId from the line above
            _safeMint(msg.sender, newItemId);

    // set newItemId and tokenURI
            _setTokenURI(newItemId, tokenURI);

    // return newItemId
            return newItemId;
        }
    }
    ```

13. Next, clear your `hardhat.config.js` file and add the following

    ```jsx
    require("dotenv").config();
    require("@nomiclabs/hardhat-waffle");
    require("@nomiclabs/hardhat-etherscan");

    module.exports = {
      solidity: "0.8.4",
    };
    ```

14. You can now specify the network, account and polygonscan key in `module.exports`

    1. Go to [ankr.com/protocol/public](http://ankr.com/protocol/public) and copy the RPC for Polygon: `https://rpc.ankr.com/polygon`

    ```jsx
    // imports

    module.exports = {
      solidity: "0.8.4",
      networks: {
        matic: {
          url: "https://rpc.ankr.com/polygon",
          accounts: [process.env.WALLET_PRIVATE_KEY],
        },
      },
      etherscan: {
        apiKey: process.env.POLYGONSCAN_API_KEY,
      },
    };
    ```

15. Create a `.env` file in your root directory

    1. Copy the private key from your MetaMask wallet with $MATIC in it

       ![Screen Shot 2022-04-11 at 3.03.07 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/42d3f5ba-fced-4e5f-8528-9ec827c3f7cf/Screen_Shot_2022-04-11_at_3.03.07_PM.png)

       ![Screen Shot 2022-04-11 at 3.04.12 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3b0133d5-2a02-427f-b2da-628ff45d7ea9/Screen_Shot_2022-04-11_at_3.04.12_PM.png)

    2. [Register a new account](https://polygonscan.com/register), add a new API key, and copy the key from [polygonscan.com](http://polygonscan.com). This will allow us to verify our contract on polygonscan once it has been deployed.

       ![Screen Shot 2022-04-11 at 2.48.16 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3d504595-33db-47e2-b275-b04552b170fc/Screen_Shot_2022-04-11_at_2.48.16_PM.png)

    3. Paste these keys into your `.env` file

       ```bash
       WALLET_PRIVATE_KEY=[YOUR_PRIVATE_METAMASK_KEY]
       POLYGONSCAN_API_KEY=[YOUR_POLYGONSCAN_API_KEY]
       ```

16. Create a new `Deploy.js` file in the `scripts` directory

    ```jsx
    // open main asynchronous function will handle deployment
    const main = async () => {
      try {
        // use hre object that allows us to pass the name of our contract to getContractFactory
        const nftContractFactory = await hre.ethers.getContractFactory(
          "AnkrPolygonNFT"
        );

        // create variable to allow us to use the deploy function of getContractFactory
        const nftContract = await nftContractFactory.deploy();

        // await deployment of contract
        await nftContract.deployed();

        // log the address of the Contract in our console
        console.log("Contract deployed to:", nftContract.address);
        process.exit(0);

        // catch error, if any, and log in console
      } catch (error) {
        console.log(error);
        process.exit(1);
      }
    };

    main();
    ```

17. Run the following command in your terminal to deploy your smart contract to the Polygon Blockchain, a L2 on Ethereum

    ```bash
    npx hardhat run scripts/Deploy.js --network matic
    ```

    - If the contract was successfully deployed to Polygon’s blockchain, the output should look like this ⬇️

    ```bash
    Downloading compiler 0.8.4
    Compiled 12 Solidity files successfully
    Contract deployed to: 0x66248349aa6Ef98792c61b7C625F992bB5E7Fbd2
    ```

18. Copy the contract address and find it in polygonscan at [polygonscan.com](http://polygonscan.com)

    ![Screen Shot 2022-04-11 at 3.33.23 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/30013d4c-d535-4391-aac9-8c90a20678d7/Screen_Shot_2022-04-11_at_3.33.23_PM.png)

19. Be sure your Polygon Scan API key is in your `.env` file and then run the following command to verify your contract on polygonscan. Be sure to replace the address with your contract address from Step 18. ⬇️

    ```bash
    npx hardhat verify 0x66248349aa6Ef98792c61b7C625F992bB5E7Fbd2 --network matic
    ```

    ```bash
    // your output will look similar to the below
    joshstein@Joshs-MacBook-Pro ankr-polygon-nft % npx hardhat verify 0x66248349aa6Ef98792c61b7C625F992bB5E7Fbd2 --network matic
    Nothing to compile
    Successfully submitted source code for contract
    contracts/AnkrPolygonNFT.sol:AnkrPolygonNFT at 0x66248349aa6Ef98792c61b7C625F992bB5E7Fbd2
    for verification on the block explorer. Waiting for verification result...

    Successfully verified contract AnkrPolygonNFT on Etherscan.
    https://polygonscan.com/address/0x66248349aa6Ef98792c61b7C625F992bB5E7Fbd2#code
    ```

20. Our contract is now verified on polygonscan, along with 11 other contracts from Open Zeppelin included in the compilation

    ![Screen Shot 2022-04-11 at 3.39.01 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/42272105-8fb7-4b44-ae79-fd13e90f48df/Screen_Shot_2022-04-11_at_3.39.01_PM.png)

21. In polygonscan, we are ready to call our function. First, select `Contract ✅`and then `Write Contract`. Locate the `mint` function (this should be #2)

    1. Next, click `🔴 Connect to Web3` to connect your MetaMask wallet

       ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/67a706d4-7a2f-43e2-b4b1-155eb4e0744a/Untitled.png)

    2. If you connect to your wallet, it will now look like this ⬇️

       ![Screen Shot 2022-04-11 at 3.52.57 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/101442c8-b568-4c30-818b-a12af0524ac5/Screen_Shot_2022-04-11_at_3.52.57_PM.png)

22. We will now need to set the Token URI and can use [web3.storage](http://web3.storage) to store our image and data. This will be in the form of a URL to a [JSON](https://www.json.org/json-en.html) file. I’ve gone ahead and made an image with the tools we’ve used on this tutorial. You can use whatever you’d like!

    1. You can learn more about how to structure your JSON file from [OpenSea’s metadata standards](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbk1WNkZjdlFiYmxxdFRlMUFKejNmb24wVzdpd3xBQ3Jtc0ttOThUUHgtTHVQWk9OalFCZDFtUTVLRGZMTmVsZmRpb3pZYXptbFdrVTlOS1dFTW1fSmhjN2FYNWdxckRLTW1peWlUQXB6WThKN2daSnZhTnNfSWdZLTVMdkpoUWJxZDdQOXdINVFzbWdMdms0RjVUNA&q=https%3A%2F%2Fdocs.opensea.io%2Fdocs%2Fmetadata-standards)

    ```json
    {
      "name": "Ankr x Polygon ERC-721 Smart Contract",
      "description": "Ankr x Polygon ERC-721 Smart Contract",
      "image": "https://ipfs.io/ipfs/bafybeidtawmsmymozum2ndgjsnzf4pgct3rt4p5x6ywcrkiun7sogcsoi4/Ankr-Polygon.svg",
      "attributes": [
        {
          "trait_type": "Developer",
          "value": "Josh CS"
        },
        {
          "trait_type": "Website",
          "value": "https://ankr.com"
        }
      ]
    }
    ```

23. After uploading to [web3.storage](http://web3.storage), paste the URL to your JSON file and select `Mint` and then `Confirm` the MetaMask transaction

![Screen Shot 2022-04-11 at 4.58.08 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/db8acbc4-eec8-442b-a708-bddb0f07f45f/Screen_Shot_2022-04-11_at_4.58.08_PM.png)

24. Check out your OpenSea gallery to see your [NFT](https://opensea.io/assets/matic/0x66248349aa6ef98792c61b7c625f992bb5e7fbd2/1)!
