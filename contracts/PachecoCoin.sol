// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title PachecoCoin
 * @dev ERC20 token contract with custom logic for distributing tokens
 * Se otorgara pachecoCoins por la compra de productos ferreteros de nuestra tienda DISTRIBUIDORA TRINOS E.I.R.L.
 */

//Heredamos funcionalidades del contrato base ERC20
contract PachecoCoin is ERC20 {

    //SE DEFINE LA VARIABLE "owner" QUE ALMACENARA LA DIRECCION PUBLICA DE LA WALLET DEL PROPIETARIO "DISTRIBUIDORA TRINOS E.I.R.L."
    address public owner;

    // Definimos la conversión: 1 PachecoCoin por cada 20 soles.
    //SE DEFINE UN VALOR DE TIPO "uint256" (un entero sin signo de 256 bits)
    uint256 public constant SOLES_PER_PACHECOCOIN = 20;

    // Evento para registrar cuando se otorgan PachecoCoins
    // SE CREA UN EVENTO QUE SERVIRA PARA OTORGAR LAS CANTIDAD DE "pachecoCoins"=1 CORRESPONDIENTE POR LA COMPRA DE "amountInSoles"=20 SOLES
    //LAS CUALES IRAN A LA WALLET DEL CLIENTE "customer"
    event PachecoCoinsGranted(address indexed customer, uint256 amountInSoles, uint256 pachecoCoins);

    // Constructor inicializando el nombre y símbolo del token
    //SE DEFINE EL NOMBRE DEL TOKEN QUE CREAREMOS "PachecoCoin"
    //SE DEFINE EL SIMBOLO DEL TOKEN QUECREAREMOS "PCH"
    //SE DEFINE LA CANTIDAD DE TOKENS QUE SE CREARAN 1000 TOKENS
    constructor() ERC20("PachecoCoin", "PCH") {
        owner = msg.sender; // El creador del contrato es el dueño
        {
            //CREA LOS TOKENS INICIALES Y LOS ASIGNA A LA DIRECCION DE LA WALLET DEL DUEÑO DEL CONTRATO
        _mint(msg.sender, 1000 * 10 ** decimals());
        }
    }

    // Modificador para asegurarse de que solo el dueño puede otorgar PachecoCoins
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can grant PachecoCoins");
        _;
    }

    /**
     * @dev Otorga PachecoCoins a un cliente según el monto gastado en soles.
     * @param customer La dirección del cliente que recibirá los tokens.
     * @param amountInSoles El monto en soles gastado por el cliente.
     */
    //ESTA FUNCION OTORGARA LOS TOKENS CORRESPONDIENTES AL CLIENTE POR LA COMPRA DE PRODUCTOS
    //20 S/. DE COMPRA = 1 "PachecoCoin"
    function grantPachecoCoins(address customer, uint256 amountInSoles) external onlyOwner {
        require(customer != address(0), "Invalid customer address");

        // Calcular cuántos PachecoCoins se otorgarán
        uint256 pachecoCoins = amountInSoles / SOLES_PER_PACHECOCOIN;
        require(pachecoCoins > 0, "Amount too low to grant any PachecoCoins");

        // Otorgar los PachecoCoins al cliente (mint tokens)
        _mint(customer, pachecoCoins * (10 ** decimals()));

        // Emitir evento para registro
        emit PachecoCoinsGranted(customer, amountInSoles, pachecoCoins);
    }

    /**
     * @dev El dueño del contrato puede cambiar el dueño a otra dirección.
     * @param newOwner La nueva dirección del dueño.
     */
    //ESTA FUNCION PERMITE AL DUEÑO ACTUAL DEL CONTRATO TRANFERIRLA A UN NUEVO DUEÑO
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        owner = newOwner;
    }

    /** @dev CONSULTA DEL BALANCE DEL DUEÑO DEL CONTRATO
    */
    function balanceOfOwner() public view returns (uint256) {
        return balanceOf(owner);
    }
}
