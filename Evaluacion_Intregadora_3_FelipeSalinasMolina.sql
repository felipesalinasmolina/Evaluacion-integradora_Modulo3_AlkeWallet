-- Link GitHub
-- https://github.com/felipesalinasmolina/Evaluacion-integradora_Modulo3_AlkeWallet

CREATE SCHEMA `alkemy_wallet` ;
   
   -- Creacion de tabla usuarios
   
 CREATE TABLE `alkemy_wallet`.`users` (
  `id_users` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `balance` INT NOT NULL,
  PRIMARY KEY (`id_users`));
  
     -- Creacion de tabla monedas
  
  CREATE TABLE `alkemy_wallet`.`currency` (
  `id_currency` INT NOT NULL AUTO_INCREMENT,
  `currency_name` VARCHAR(45) NOT NULL,
  `currency_symbol` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_currency`));

      -- Creacion de tabla transacciones 
  
CREATE TABLE `alkemy_wallet`.`transactions` (
  `id_transactions` INT NOT NULL AUTO_INCREMENT,
  `sender_user_id` INT NULL,
  `receiver_user_id` INT NULL,
  `amount` INT NULL,
  `transactions_date` DATETIME NULL,
  `id_currency` INT NULL,
  PRIMARY KEY (`id_transactions`),
  INDEX `fk_transaction_idx` (`sender_user_id` ASC) VISIBLE,
  INDEX `fk_transaction_1_idx` (`receiver_user_id` ASC) VISIBLE,
  INDEX `fk_transaction_3_idx` (`id_currency` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_1`
    FOREIGN KEY (`sender_user_id`)
    REFERENCES `alkemy_wallet`.`users` (`id_users`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_2`
    FOREIGN KEY (`receiver_user_id`)
    REFERENCES `alkemy_wallet`.`users` (`id_users`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_3`
    FOREIGN KEY (`id_currency`)
    REFERENCES `alkemy_wallet`.`currency` (`id_currency`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION);
	
	-- Se insertan datos a la tabla usuarios
	
INSERT INTO `alkemy_wallet`.`users` (`name`, `email`, `password`, `balance`) VALUES ('Lionel Messi', 'liomessi@mail.com', '123456', '54494884');
INSERT INTO `alkemy_wallet`.`users` (`name`, `email`, `password`, `balance`) VALUES ('Kilyan Mbappe', 'donatelo@mail.com', '123456', '16489489');
INSERT INTO `alkemy_wallet`.`users` (`name`, `email`, `password`, `balance`) VALUES ('Erling Halaand', 'android@mail.com', '123456', '58498488');
INSERT INTO `alkemy_wallet`.`users` (`name`, `email`, `password`, `balance`) VALUES ('Cristiano Ronaldo', 'cr7@mail.com', '123456', '56118887');

	-- Se insertan datos a la tabla CURRENCY
	
INSERT INTO `alkemy_wallet`.`currency` (`currency_name`, `currency_symbol`) VALUES ('CLP', '$');
INSERT INTO `alkemy_wallet`.`currency` (`currency_name`, `currency_symbol`) VALUES ('EUR', '€');
INSERT INTO `alkemy_wallet`.`currency` (`currency_name`, `currency_symbol`) VALUES ('LIBRA', '€');

	-- Se insertan datos a la tabla transaction

INSERT INTO `alkemy_wallet`.`transactions` (`sender_user_id`, `receiver_user_id`, `amount`, `transactions_date`, `id_currency`) VALUES ('3', '1', '146445', '2004-05-23T14:25:10', '2');
INSERT INTO `alkemy_wallet`.`transactions` (`sender_user_id`, `receiver_user_id`, `amount`, `transactions_date`, `id_currency`) VALUES ('2', '1', '4733987', '2004-05-23T14:25:17', '1');
INSERT INTO `alkemy_wallet`.`transactions` (`sender_user_id`, `receiver_user_id`, `amount`, `transactions_date`, `id_currency`) VALUES ('1', '4', '254984894', '2004-05-23T14:25:10', '3');
INSERT INTO `alkemy_wallet`.`transactions` (`sender_user_id`, `receiver_user_id`, `amount`, `transactions_date`, `id_currency`) VALUES ('4', '3', '49848948', '2004-06-23T14:25:10', '2');


	-- DESARROLLO

		-- Consulta para obtener el nombre de la moneda elegida por un Usuario específico

SELECT currency.currency_name, users.name 
FROM users INNER JOIN transactions
on transactions.sender_user_id = users.id_users
INNER JOIN currency
ON transactions.id_currency= currency.id_currency 
WHERE users.id_users=2; -- En esta línea se debe indicar el id_users del usuario por el cual se va a consultar, para este ejemplo se escogio el usuarion con id 2

		--  Consulta para obtener todas las transacciones registradas

SELECT users.id_users,users.name,users.email,transactions.receiver_user_id,transactions.sender_user_id,
currency.currency_name,currency.currency_symbol,transactions.amount
FROM users
INNER JOIN transactions ON 
users.id_users=transactions.receiver_user_id or users.id_users=transactions.sender_user_id
INNER JOIN currency
ON currency.id_currency=transactions.id_currency; 

		-- Consulta para obtener todas las transacciones realizadas por un usuario específico

SELECT users.id_users,users.name,users.email,transactions.receiver_user_id,transactions.sender_user_id,
currency.currency_name,currency.currency_symbol,transactions.amount
FROM users
INNER JOIN transactions ON 
users.id_users=transactions.receiver_user_id or users.id_users=transactions.sender_user_id
INNER JOIN currency
ON currency.id_currency=transactions.id_currency
WHERE users.id_users=1;-- En esta línea se debe indicar el id_users del usuario por el cual se va a consultar, para este ejemplo se escogio el usuarion con id 1

		-- Sentencia DML para modificar el campo correo electrónico de un usuario específico

UPDATE `alkemy_wallet`.`users` SET `email` = 'lapulga@mail.com' WHERE (`id_users` = '1');-- En este ejemplo se ha decidido cambiar el mail del usuario con id 1

		-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)

DELETE FROM `alkemy_wallet`.`transactions` WHERE (`id_transactions` = '1');-- En este ejemplo se ha decidido eliminar las transsaciones  con id 1