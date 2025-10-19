# 🛒 Projeto E-commerce – Banco de Dados Relacional (MySQL)

## 📘 Descrição
Este projeto foi desenvolvido como parte do desafio de modelagem de banco de dados da DIO.  
O objetivo é replicar e aprimorar a modelagem lógica de um cenário de **E-commerce**,  
implementando a estrutura SQL completa e o **modelo EER**.

---

## 🧱 Estrutura do Projeto

**Tabelas principais:**
- Clientes (com distinção entre **PF** e **PJ**)
- Pagamentos múltiplos por cliente
- Pedidos e itens de pedido
- Entrega com código de rastreio e status
- Produtos, estoque, fornecedores e vendedores

**Relacionamentos:**
- 1:1 → Clientes x PF/PJ  
- 1:N → Clientes x Pedidos  
- 1:N → Clientes x Pagamentos  
- 1:N → Pedidos x Itens  
- 1:1 → Pedidos x Entrega  
- N:N → Produtos x Vendedores / Produtos x Fornecedores  

---

## 🧩 Estrutura de Pastas

projeto-ecommerce-sql/
├── docs/
│ └── EER_Diagrama_Ecommerce.pdf
  └── EER_Diagrama_Ecommerce.png
├── sql/
│ ├── esquema_logico.sql
│ └── inserts_teste.sql
└── README.md

---

## 💾 Ferramentas Utilizadas
- **MySQL 8.0**
- **MySQL Workbench** (para diagrama EER)
- **Git / GitHub**

---

## 🧠 Autor
**Juliana Brandão**  
💼 Analista de Dados 
📧 contato: (https://www.linkedin.com/in/julianabrandaosv/)

