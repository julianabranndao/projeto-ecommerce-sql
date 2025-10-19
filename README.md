# 🛒 Projeto de Banco de Dados – E-commerce (MySQL)

## 📘 Descrição Geral

Este projeto implementa o **modelo lógico de um sistema de E-commerce**, construído com base em boas práticas de modelagem relacional e normalização.  
O objetivo é simular um ambiente real de vendas online, permitindo o gerenciamento de **clientes (PF/PJ)**, **produtos**, **fornecedores**, **vendedores**, **pedidos**, **pagamentos** e **entregas**.  

Além da criação do esquema físico no MySQL, o projeto inclui **inserção de dados genéricos de teste** e **consultas SQL complexas** para análise e validação do modelo.

---

## 📊 Modelagem EER

O **diagrama EER** foi desenvolvido no MySQL Workbench representando a estrutura lógica final do sistema.

📷 Inclui:
- Clientes PF/PJ com distinção de atributos  
- Pagamentos múltiplos por cliente  
- Pedidos e entregas com rastreamento  
- Controle de estoque por localização  
- Relacionamentos entre produtos, fornecedores e vendedores  

🧠 O diagrama está salvo e exportado em PDF e PNG como referência visual do modelo lógico.

📄 Arquivos: [`Diagrama EER PDF`](docs/EER_Diagram_Ecommerce.pdf)
             [`Diagrama EER PNG`](docs/EER_Diagram_Ecommerce.png)

---

## 🧩 Criação do Banco e Estrutura Base

Nesta etapa foi definido o esquema lógico e implementadas todas as tabelas com suas respectivas **chaves primárias, estrangeiras e constraints**.

📄 Arquivo: [`sql/create_schema.sql`](./sql/create_schema.sql)

### 🧱 Estrutura Geral:
- `clients`, `client_pf`, `client_pj` → Especialização de clientes pessoa física e jurídica  
- `client_payment` → Múltiplas formas de pagamento por cliente  
- `product` → Catálogo de produtos com classificação por categoria e faixa etária  
- `supplier`, `seller` → Entidades de fornecedores e vendedores  
- `product_supplier`, `product_seller` → Relacionamentos entre produtos e seus parceiros  
- `product_storage` → Controle de estoque físico por localidade  
- `orders`, `order_item`, `delivery` → Pedidos, itens e informações logísticas de entrega  

### ⚙️ Regras Implementadas:
- **Integridade referencial total**, com uso de `ON UPDATE CASCADE` e `ON DELETE CASCADE/RESTRICT`  
- **ENUMs padronizados** para status e categorias  
- **CHECK constraints** para garantir valores válidos (ex: `unitPrice >= 0`)  
- **Relacionamentos N:N** modelados via tabelas intermediárias  

---

## 💾 Inserção de Dados

Nesta etapa, foi realizada a **população do banco de dados** com dados genéricos de teste, abrangendo todas as tabelas do modelo.

📄 Arquivo: [`sql/inserts_data_ecommerce.sql`](./sql/inserts_data_ecommerce.sql)

### 🔍 Estrutura e Conteúdo:
- **Clientes (clients)**: inserção de 6 clientes, sendo 3 PF e 3 PJ  
- **Pagamentos (client_payment)**: múltiplas formas de pagamento associadas a clientes distintos  
- **Produtos (product)**: catálogo variado com diferentes categorias  
- **Fornecedores e Vendedores**: pessoas e empresas vinculadas a produtos  
- **Estoque (product_storage)**: controle de quantidade e local de armazenamento  
- **Pedidos e Itens (orders, order_item)**: simulação de compras reais  
- **Entrega (delivery)**: status logístico com código de rastreio e transportadora  

### ⚙️ Estrutura Transacional:
```sql
START TRANSACTION;
-- blocos de inserção
COMMIT;
🔒 As operações são executadas de forma atômica e segura, garantindo integridade total dos dados.

---

## 🧠 Etapa 4 – Queries Solicitadas

Foram desenvolvidas consultas SQL para análise e validação do banco de dados, aplicando conceitos de **JOINs**, **agrupamentos**, **filtros**, **expressões condicionais** e **funções agregadas**.

📄 Arquivo: [`sql/queries_solicitadas.sql`](./sql/queries_solicitadas.sql)

### 🔍 Consultas Implementadas:
1. **Quantos pedidos foram feitos por cliente** (`GROUP BY`, `ORDER BY`)  
2. **Relação de produtos, fornecedores e estoques** (`INNER JOIN`, `LEFT JOIN`)  
3. **Vendedores que também são fornecedores** (`JOIN`, `WHERE`)  
4. **Relação nomes de fornecedores × produtos**  
5. **Classificação de estoque com `CASE WHEN`**  
6. **Valor total de pedidos por cliente** (`SUM`, `HAVING`)  
7. **Status logístico de entregas e rastreio de pedidos**  
8. **Comissão de vendedores por produto vendido** (`JOIN`, `ORDER BY`)  
9. **Vendedores com mais de dois produtos vendidos** (`GROUP BY`, `HAVING`)  
10. **Clientes e status de pagamento** (`JOIN`, `WHERE`, `GROUP BY`)

### 🧩 Conceitos Aplicados:
- Uso de **INNER e LEFT JOINs** para cruzar informações entre tabelas  
- Criação de **atributos derivados** (`ROUND`, `CASE`)  
- Filtros em grupos com **HAVING**  
- Ordenação e filtragem de dados com **ORDER BY**, **WHERE**, **DISTINCT**

## 🧾 Estrutura do Repositório

/projeto-ecommerce-sql
│
├── sql/
│ ├── create_schema.sql
│ ├── inserts_data_ecommerce.sql
│ ├── queries_solicitadas.sql
│
├── EER_Model.pdf
└── README.md

🧠 Autor
Juliana Brandão
💼 Analista de Dados 📧 contato: (https://www.linkedin.com/in/julianabrandaosv/)
