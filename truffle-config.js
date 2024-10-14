const path = require("path");
require("dotenv").config({ path: path.resolve(__dirname, ".env") });

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Cambia esto si estás usando otro host
      port: 7545, // Puerto de Ganache
      network_id: "*", // Cualquier ID de red
    },
  },
  // Configuraciones de compilación
  compilers: {
    solc: {
      version: "0.8.20", // Cambia esto a la versión que estés usando
    },
  },
};
