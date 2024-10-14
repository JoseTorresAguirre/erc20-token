const PachecoCoin = artifacts.require("PachecoCoin");

module.exports = function (deployer) {
  // Cambia 'YOUR_OWNER_ADDRESS' por la dirección que deseas establecer como propietario
  const ownerAddress = "0xC06FA96C87a2DfF9f3398Db8B52AB81dDb853E91"; // Reemplaza esto con la dirección real
  deployer.deploy(PachecoCoin, ownerAddress);
};
