-- Inserção de Dados
-- Projeto: Banco de Dados E-commerce
-- Autor: Juliana Brandão
-- Descrição: Inserção de dados genéricos de teste em todas as tabelas do esquema lógico.

START TRANSACTION;

-- Inclusão da base de Clientes

INSERT INTO clients (name, email, phone, clientType)
VALUES
  ('Maria Silva', 'maria.silva@email.com', '11990000001', 'PF'),
  ('João Pereira', 'joao.pereira@email.com', '21990000002', 'PF'),
  ('Ana Souza', 'ana.souza@email.com', '31990000003', 'PF'),
  ('Tech Imports LTDA', 'contato@techimports.com', '1130000001', 'PJ'),
  ('Casa Nova Distribuidora', 'vendas@casanova.com', '1120000002', 'PJ'),
  ('Alfa Logística S.A.', 'financeiro@alfalog.com', '1140000003', 'PJ');
  
-- Clientes PF

INSERT INTO client_pf (
  idClient, cpf, birthDate, addressZip, addressStreet, addressNumber, addressComp
)
VALUES
  (1, '12345678901', '1990-04-15', '04500000', 'Rua das Flores', '100', 'Ap 12'),
  (2, '98765432100', '1988-07-22', '04800000', 'Av. Paulista', '2000', NULL),
  (3, '65498732100', '1995-12-10', '04050000', 'Rua Azevedo', '500', 'Casa');

-- Clientes PJ

INSERT INTO client_pj (
  idClient, cnpj, stateRegistration, addressZip, addressStreet, addressNumber, addressComp
)
VALUES
  (4, '11111111000111', 'ISENTO', '04100000', 'Rua das Laranjeiras', '50', 'Sala 2'),
  (5, '22222222000122', '123456789', '04200000', 'Av. Central', '1200', NULL),
  (6, '33333333000133', 'ISENTO', '04300000', 'Rua Dom Pedro', '999', 'Bloco 1');
  
-- Inclusão da base de Pagamentos

INSERT INTO client_payment (
  idClient, paymentType, paymentStatus, holderName, cardLast4, limitAvailable
)
VALUES
  (1, 'Credito', 'Confirmado', 'Maria Silva', '1234', 2500.00),
  (1, 'Pix', 'Confirmado', 'Maria Silva', NULL, 999999.99),
  (2, 'Debito', 'Confirmado', 'João Pereira', '2222', 1000.00),
  (3, 'Credito', 'Em_Aprovacao', 'Ana Souza', '3333', 1500.00),
  (4, 'Boleto', 'Confirmado', 'Tech Imports', NULL, 0.00),
  (5, 'Pix', 'Em_Aprovacao', 'Casa Nova', NULL, 999999.99),
  (6, 'Boleto', 'Confirmado', 'Alfa Logística', NULL, 0.00);
  
-- Inclusão da base de Fornecedores

INSERT INTO supplier (socialName, cnpj, contact)
VALUES
  ('Global Supply Ltda', '44444444000144', '11911112222'),
  ('Mega Distribuidora', '55555555000155', '11922223333');
  
-- Inclusão da base de Vendedores

INSERT INTO seller (socialName, abtName, cnpj, cpf, location, contact)
VALUES
  ('Vendas Prime Ltda', 'Prime', '66666666000166', NULL, 'São Paulo', '11933334444'),
  ('João Vendas ME', NULL, NULL, '45678912301', 'Rio de Janeiro', '21944445555'),
  ('Comercial Center LTDA', 'Center', '77777777000177', NULL, 'Belo Horizonte', '31955556666');
  
-- Inclusão da base de Produtos

INSERT INTO product (
  pname, classification_kids, category, rating, size, unitPrice
)
VALUES
  ('Mouse Gamer', FALSE, 'Eletronicos', 4.8, 'Único', 120.00),
  ('Notebook 15"', FALSE, 'Eletronicos', 4.6, '15pol', 3599.90),
  ('Camiseta M', FALSE, 'Vestuario', 4.4, 'M', 59.90),
  ('Sofá Retrátil 2L', FALSE, 'Casa_e_Decoracao', 4.5, '2x1.6m', 1899.00),
  ('Boneca Lulu', TRUE, 'Papelaria', 4.7, 'P', 39.90),
  ('Livro Infantil', TRUE, 'Livros', 4.2, '27cm', 41.90);
  
-- Inclusão da base Relação Fornecedor x Produto

INSERT INTO product_supplier (idSupplier, idProduct, supplyQty)
VALUES
  (1, 1, 500),
  (1, 2, 200),
  (1, 3, 150),
  (2, 4, 80),
  (2, 5, 300),
  (2, 6, 100);
  
-- Inclusão da base Relação Vendedor x Produto

INSERT INTO product_seller (idSeller, idProduct, stockQty)
VALUES
  (1, 1, 50),
  (1, 2, 10),
  (2, 3, 25),
  (2, 5, 30),
  (3, 4, 15),
  (3, 6, 20);

-- Inclusão da base de Estoque

INSERT INTO product_storage (idProduct, storageLocation, quantity)
VALUES
  (1, 'CD-SP-01', 30),
  (2, 'CD-SP-01', 15),
  (3, 'CD-RJ-01', 25),
  (4, 'CD-SP-02', 10),
  (5, 'CD-MG-01', 50),
  (6, 'CD-MG-01', 40);

-- Inclusão da base de Pedidos

INSERT INTO orders (idClient, orderDescription, freightValue, orderStatus)
VALUES
  (1, 'Compra via App', 20.00, 'Aprovado'),
  (2, 'Compra via Site', 25.00, 'Aprovado'),
  (3, 'Pedido via Telefone', 15.00, 'Enviado'),
  (4, 'Pedido Corporativo', 120.00, 'Em_Processamento'),
  (5, 'Compra com Pix', 10.00, 'Aprovado'),
  (6, 'Pedido Industrial', 200.00, 'Em_Processamento');

-- Inclusão da base Relação Produto x Pedido

INSERT INTO order_item (idOrder, idProduct, quantity, itemStatus)
VALUES
  (1, 1, 1, 'Disponivel'),
  (1, 3, 2, 'Disponivel'),
  (2, 4, 1, 'Disponivel'),
  (2, 2, 1, 'Disponivel'),
  (3, 5, 3, 'Disponivel'),
  (4, 2, 2, 'Em_Producao'),
  (5, 6, 1, 'Disponivel'),
  (6, 4, 1, 'Disponivel');

-- Inclusão da base de Relação Entrega x Pedido

INSERT INTO delivery (
  idOrder, status, trackingCode, carrier, shippedAt, deliveredAt
)
VALUES
  (1, 'Entregue', 'BR123ABC456', 'Correios', NOW(), NOW()),
  (2, 'Em_Transporte', 'BR789XYZ000', 'TotalExpress', NOW(), NULL),
  (3, 'Entregue', 'BR111AAA999', 'Correios', NOW(), NOW()),
  (4, 'Criado', 'BR222BBB888', 'Jadlog', NULL, NULL),
  (5, 'Em_Transporte', 'BR333CCC777', 'Correios', NOW(), NULL),
  (6, 'Criado', 'BR444DDD666', 'Loggi', NULL, NULL);

COMMIT;
