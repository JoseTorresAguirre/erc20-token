const PachecoCoin = artifacts.require("PachecoCoin");

module.exports = async function (deployer) {
  // Despliega el contrato
  await deployer.deploy(
    PachecoCoin,
    "0xC06FA96C87a2DfF9f3398Db8B52AB81dDb853E91"
  );
  const pachecoCoin = await PachecoCoin.deployed();

  // Cambia esto por la dirección del propietario o de la cuenta que quieras consultar
  const ownerAddress = "0xC06FA96C87a2DfF9f3398Db8B52AB81dDb853E91";
  const balance = await pachecoCoin.balanceOf(ownerAddress);

  // Imprimir el balance en la consola
  console.log(`Balance de PachecoCoins: ${balance.toString()}`);
};
