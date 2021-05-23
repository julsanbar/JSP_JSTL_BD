CREATE DATABASE recetario;

USE recetario;

CREATE TABLE `recetas` (
  `titulo` varchar(100) NOT NULL,
  `harina` varchar(100) DEFAULT NULL,
  `cantidadHarina` double DEFAULT NULL,
  `liquidos` varchar(100) DEFAULT NULL,
  `cantidadLevadura` double DEFAULT NULL,
  `cantidadAzucar` double DEFAULT NULL,
  `cantidadSal` double DEFAULT NULL,
  `preparacion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`titulo`)
);
