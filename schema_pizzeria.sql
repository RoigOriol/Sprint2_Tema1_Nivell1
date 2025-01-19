CREATE TABLE Clients (
  id_client INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50),
  cognoms VARCHAR(100),
  adreça VARCHAR(100),
  codi_postal VARCHAR(10),
  localitat VARCHAR(50),
  província VARCHAR(50),
  telefon VARCHAR(15)
);

CREATE TABLE Botigues (
  id_botiga INT PRIMARY KEY AUTO_INCREMENT,
  adreça VARCHAR(100),
  codi_postal VARCHAR(10),
  localitat VARCHAR(50),
  provincia VARCHAR(50)
);

CREATE TABLE Empleats (
  id_empleat INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50),
  cognoms VARCHAR(100),
  nif VARCHAR(15),
  telefon VARCHAR(15),
  rol ENUM('cuiner', 'repartidor'),
  id_botiga INT,
  FOREIGN KEY (id_botiga) REFERENCES Botigues(id_botiga)
);

CREATE TABLE Productes (
  id_producte INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50),
  descripcio TEXT,
  imatge VARCHAR(255),
  preu DECIMAL(10,2)
);

CREATE TABLE Categories (
  id_categoria INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50)
);

CREATE TABLE Pizzes (
  id_producte INT PRIMARY KEY,
  id_categoria INT,
  FOREIGN KEY (id_producte) REFERENCES Productes(id_producte),
  FOREIGN KEY (id_categoria) REFERENCES Categories(id_categoria)
);

CREATE TABLE Comandes (
  id_comanda INT PRIMARY KEY AUTO_INCREMENT,
  data_hora DATETIME,
  tipus ENUM('domicili', 'recollida'),
  quantitat_productes INT,
  preu_total DECIMAL(10,2),
  id_client INT,
  id_botiga INT,
  id_repartidor INT,
  FOREIGN KEY (id_client) REFERENCES Clients(id_client),
  FOREIGN KEY (id_botiga) REFERENCES Botigues(id_botiga),
  FOREIGN KEY (id_repartidor) REFERENCES Empleats(id_empleat)
);