CREATE TABLE `proveidor` (
  `id` int PRIMARY KEY,
  `nom` varchar(255),
  `adreça` varchar(255),
  `telefon` varchar(15),
  `fax` varchar(15),
  `nif` varchar(20)
);

CREATE TABLE `ullera` (
  `id` int PRIMARY KEY,
  `marca` varchar(100),
  `graduacio_vidre_dret` float,
  `graduacio_vidre_esquerre` float,
  `tipus_muntura` enum("pasta", "metàl·lica"),
  `color_muntura` varchar(50),
  `preu` float,
  `proveidor_id` int
);

CREATE TABLE `client` (
  `id` int PRIMARY KEY,
  `nom` varchar(255),
  `adreça` varchar(255),
  `telefon` varchar(15),
  `email` varchar(255),
  `data_registre` date,
  `recomanat_per` int
);

CREATE TABLE `empleat` (
  `id` int PRIMARY KEY,
  `nom` varchar(255),
  `cognoms` varchar(255)
);

CREATE TABLE `venda` (
  `id` int PRIMARY KEY,
  `ullera_id` int,
  `client_id` int,
  `empleat_id` int,
  `data_venda` date
);

ALTER TABLE `ullera` ADD FOREIGN KEY (`proveidor_id`) REFERENCES `proveidor` (`id`);

ALTER TABLE `client` ADD FOREIGN KEY (`recomanat_per`) REFERENCES `client` (`id`);

ALTER TABLE `venda` ADD FOREIGN KEY (`ullera_id`) REFERENCES `ullera` (`id`);

ALTER TABLE `venda` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

ALTER TABLE `venda` ADD FOREIGN KEY (`empleat_id`) REFERENCES `empleat` (`id`);
