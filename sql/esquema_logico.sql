-- Criando Tabelas Bases para Manipulação do BD de Ecommerce

CREATE DATABASE ecommerce
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;
USE ecommerce;

-- Clients (genérico) + especializações PF/PJ (exclusivas)

CREATE TABLE clients (
  idClient INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(20),
  clientType ENUM('PF','PJ') NOT NULL,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE client_pf (
  idClient INT PRIMARY KEY,
  cpf CHAR(11) NOT NULL UNIQUE,
  birthDate DATE NOT NULL,
  addressZip CHAR(8) NOT NULL,
  addressStreet VARCHAR(120) NOT NULL,
  addressNumber VARCHAR(10) NOT NULL,
  addressComp VARCHAR(40),
  CONSTRAINT fk_clientpf_client
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE client_pj (
  idClient INT PRIMARY KEY,
  cnpj CHAR(14) NOT NULL UNIQUE,
  stateRegistration VARCHAR(30),
  addressZip CHAR(8) NOT NULL,
  addressStreet VARCHAR(120) NOT NULL,
  addressNumber VARCHAR(10) NOT NULL,
  addressComp VARCHAR(40),
  CONSTRAINT fk_clientpj_client
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
      ON UPDATE CASCADE ON DELETE CASCADE
);

-- Pagamentos (múltiplos por cliente)

CREATE TABLE client_payment (
  idPayment INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT NOT NULL,
  paymentType ENUM('Credito','Debito','Pix','Boleto','Dois_cartoes') NOT NULL DEFAULT 'Pix',
  paymentStatus ENUM('Em_Aprovacao','Confirmado','Estornado','Cancelado') NOT NULL DEFAULT 'Em_Aprovacao',
  holderName VARCHAR(120),
  cardLast4 CHAR(4),
  limitAvailable DECIMAL(12,2) DEFAULT 0,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_payment_client
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
      ON UPDATE CASCADE ON DELETE CASCADE
);

-- Produtos

CREATE TABLE product (
  idProduct INT AUTO_INCREMENT PRIMARY KEY,
  pname VARCHAR(80) NOT NULL,
  classification_kids BOOLEAN NOT NULL DEFAULT FALSE,
  category ENUM('Casa_e_Decoracao','Vestuario','Eletronicos','Livros','Papelaria') NOT NULL DEFAULT 'Eletronicos',
  rating FLOAT DEFAULT 0,
  size VARCHAR(20),
  unitPrice DECIMAL(12,2) NOT NULL CHECK (unitPrice >= 0)
);

-- Fornecedores e Vendedores

CREATE TABLE supplier (
  idSupplier INT AUTO_INCREMENT PRIMARY KEY,
  socialName VARCHAR(255) NOT NULL,
  cnpj CHAR(14) UNIQUE,
  contact VARCHAR(40),
  UNIQUE KEY uq_supplier_name (socialName)
);

CREATE TABLE seller (
  idSeller INT AUTO_INCREMENT PRIMARY KEY,
  socialName VARCHAR(255) NOT NULL,
  abtName VARCHAR(255),
  cnpj CHAR(14) UNIQUE,
  cpf CHAR(11) UNIQUE,
  location VARCHAR(255),
  contact VARCHAR(40)
);

-- Produto x Fornecedor

CREATE TABLE product_supplier (
  idSupplier INT NOT NULL,
  idProduct INT NOT NULL,
  supplyQty INT DEFAULT 0 CHECK (supplyQty >= 0),
  PRIMARY KEY (idSupplier, idProduct),
  CONSTRAINT fk_ps_supplier FOREIGN KEY (idSupplier) REFERENCES supplier(idSupplier)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ps_product  FOREIGN KEY (idProduct)  REFERENCES product(idProduct)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- Produto x Vendedor (estoque ofertado pelo vendedor)

CREATE TABLE product_seller (
  idSeller INT NOT NULL,
  idProduct INT NOT NULL,
  stockQty INT NOT NULL DEFAULT 0 CHECK (stockQty >= 0),
  PRIMARY KEY (idSeller, idProduct),
  CONSTRAINT fk_pse_seller  FOREIGN KEY (idSeller)  REFERENCES seller(idSeller)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_pse_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- Estoque físico por local

CREATE TABLE product_storage (
  idStorage INT AUTO_INCREMENT PRIMARY KEY,
  idProduct INT NOT NULL,
  storageLocation VARCHAR(120) NOT NULL,
  quantity INT NOT NULL DEFAULT 0 CHECK (quantity >= 0),
  CONSTRAINT fk_storage_product
    FOREIGN KEY (idProduct) REFERENCES product(idProduct)
      ON UPDATE CASCADE ON DELETE CASCADE
);

-- Pedidos, Itens e Entrega (rastreio)

CREATE TABLE orders (
  idOrder INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT NOT NULL,
  orderDescription VARCHAR(255),
  freightValue DECIMAL(12,2) NOT NULL DEFAULT 15.00,
  orderStatus ENUM('Em_Processamento','Aprovado','Cancelado','Enviado') NOT NULL DEFAULT 'Em_Processamento',
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_client FOREIGN KEY (idClient) REFERENCES clients(idClient)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE order_item (
  idOrder INT NOT NULL,
  idProduct INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
  itemStatus ENUM('Disponivel','Em_Producao','Sem_Estoque') DEFAULT 'Disponivel',
  PRIMARY KEY (idOrder, idProduct),
  CONSTRAINT fk_oi_order   FOREIGN KEY (idOrder)  REFERENCES orders(idOrder)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_oi_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Entrega com status e código de rastreio

CREATE TABLE delivery (
  idDelivery INT AUTO_INCREMENT PRIMARY KEY,
  idOrder INT NOT NULL UNIQUE,
  status ENUM('Criado','Em_Transporte','Entregue','Devolvido','Cancelado') NOT NULL DEFAULT 'Criado',
  trackingCode VARCHAR(50) NOT NULL UNIQUE,
  carrier VARCHAR(80),
  shippedAt DATETIME,
  deliveredAt DATETIME,
  CONSTRAINT fk_delivery_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
    ON UPDATE CASCADE ON DELETE CASCADE
);

