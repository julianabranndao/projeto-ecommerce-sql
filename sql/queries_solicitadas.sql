-- Consultas SQL Complexas
-- Projeto: Banco de Dados E-commerce
-- Autor: Juliana Brandão
USE ecommerce;

-- Quantidade de pedidos feitos por cliente
SELECT 
  c.name AS ClientName,
  c.clientType,
  COUNT(o.idOrder) AS TotalOrders
FROM clients c
LEFT JOIN orders o ON c.idClient = o.idClient
GROUP BY c.idClient
ORDER BY TotalOrders DESC;

-- Relação de produtos, fornecedores e estoques
SELECT 
  p.pname AS Product,
  s.socialName AS Supplier,
  ps.supplyQty AS SuppliedQty,
  st.storageLocation AS Storage,
  st.quantity AS InStock
FROM product p
INNER JOIN product_supplier ps ON p.idProduct = ps.idProduct
INNER JOIN supplier s ON ps.idSupplier = s.idSupplier
LEFT JOIN product_storage st ON p.idProduct = st.idProduct
ORDER BY s.socialName, p.pname;

-- Vendedores que também são fornecedores
SELECT 
  se.socialName AS SellerName,
  su.socialName AS SupplierName
FROM seller se
INNER JOIN supplier su ON se.cnpj = su.cnpj
WHERE se.cnpj IS NOT NULL;

-- Relação nomes de fornecedores × produtos
SELECT 
  su.socialName AS Supplier,
  p.pname AS Product,
  ps.supplyQty AS QuantitySupplied
FROM supplier su
INNER JOIN product_supplier ps ON su.idSupplier = ps.idSupplier
INNER JOIN product p ON ps.idProduct = p.idProduct
ORDER BY su.socialName;

-- Produtos e estoque com classificação via CASE WHEN
SELECT 
  p.pname AS Product,
  st.quantity AS Stock,
  CASE
    WHEN st.quantity = 0 THEN 'Sem Estoque'
    WHEN st.quantity < 10 THEN 'Estoque Baixo'
    WHEN st.quantity BETWEEN 10 AND 50 THEN 'Estoque Regular'
    ELSE 'Estoque Alto'
  END AS StockStatus,
  st.storageLocation AS Location
FROM product_storage st
INNER JOIN product p ON st.idProduct = p.idProduct
ORDER BY Stock DESC;

-- Valor total de pedidos por cliente (usando JOIN + GROUP BY + HAVING)
SELECT 
  c.name AS ClientName,
  COUNT(DISTINCT o.idOrder) AS TotalOrders,
  ROUND(SUM(p.unitPrice * oi.quantity), 2) AS TotalSpent
FROM clients c
INNER JOIN orders o ON c.idClient = o.idClient
INNER JOIN order_item oi ON o.idOrder = oi.idOrder
INNER JOIN product p ON oi.idProduct = p.idProduct
GROUP BY c.name
HAVING TotalSpent > 0
ORDER BY TotalSpent DESC;

-- Entregas e status logístico dos pedidos
SELECT 
  c.name AS ClientName,
  o.idOrder AS OrderID,
  o.orderStatus AS OrderStatus,
  d.status AS DeliveryStatus,
  d.trackingCode,
  d.carrier,
  d.shippedAt,
  d.deliveredAt
FROM clients c
INNER JOIN orders o ON c.idClient = o.idClient
INNER JOIN delivery d ON o.idOrder = d.idOrder
ORDER BY d.status, d.shippedAt;

-- Relatório de comissão de vendedores (JOIN + ORDER BY)
SELECT 
  se.socialName AS Seller,
  p.pname AS Product,
  ps.stockQty AS SoldQty,
  ROUND(p.unitPrice * ps.stockQty, 2) AS GrossRevenue,
  ROUND(p.unitPrice * ps.stockQty * 0.05, 2) AS Commission
FROM seller se
INNER JOIN product_seller ps ON se.idSeller = ps.idSeller
INNER JOIN product p ON ps.idProduct = p.idProduct
ORDER BY Commission DESC;

-- Vendedores com mais de 2 produtos vendidos (HAVING)
SELECT 
  se.socialName AS Seller,
  COUNT(ps.idProduct) AS TotalProducts,
  ROUND(SUM(p.unitPrice * ps.stockQty), 2) AS GrossRevenue
FROM seller se
INNER JOIN product_seller ps ON se.idSeller = ps.idSeller
INNER JOIN product p ON ps.idProduct = p.idProduct
GROUP BY se.socialName
HAVING COUNT(ps.idProduct) > 2
ORDER BY GrossRevenue DESC;

-- Clientes e status de pagamento (JOIN + WHERE + ORDER BY)
SELECT 
  c.name AS ClientName,
  cp.paymentType,
  cp.paymentStatus,
  COUNT(o.idOrder) AS OrdersCount
FROM clients c
INNER JOIN client_payment cp ON c.idClient = cp.idClient
LEFT JOIN orders o ON c.idClient = o.idClient
WHERE cp.paymentStatus <> 'Cancelado'
GROUP BY c.name, cp.paymentType, cp.paymentStatus
ORDER BY c.name;