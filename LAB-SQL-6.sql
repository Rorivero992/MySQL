USE SAKILA;
drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6), -- si modifico esta columna y le agrego codigo que permita ingresar nulos, se resuelve el error. 
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

SHOW VARIABLES LIKE 'secure_file_priv'; -- comando para verificar ruta segura para subir archivos. 

SELECT * FROM films_2020
WHERE rental_duration= 3;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\films_2020.csv'
INTO TABLE films_2020
FIELDS TERMINATED BY ',' -- Delimitador de campos en el archivo CSV
ENCLOSED BY '"' -- Carácter de encerramiento de los campos en el archivo CSV
LINES TERMINATED BY '\r\n' -- Delimitador de líneas en el archivo CSV
IGNORE 1 LINES; -- Ignorar la primera línea (cabecera) del archivo CSV

SET SQL_SAFE_UPDATES = 0; -- PARA DESACTIVAR EL MODO SEGURO
UPDATE films_2020 SET
  rental_duration = 3,
  rental_rate = '2.99',
  replacement_cost = '8.99';
 
SET SQL_SAFE_UPDATES = 1; -- PARA ACTIVATR EL MODO SEGURO 
  

