CREATE DATABASE ecommerce;

USE ecommerce;

-- Tabela Produto
CREATE TABLE Produto (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL,
    Quantidade_em_estoque INT NOT NULL,
    ID_Fornecedor INT,
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    ID_Estoque INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT NOT NULL,
    ID_Produto INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CPF_CNPJ VARCHAR(20) NOT NULL,
    Endereco VARCHAR(255) NOT NULL
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Data DATE NOT NULL,
    Endereco_entrega VARCHAR(255) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(20) NOT NULL
);

-- Tabela Vendas
CREATE TABLE Vendas (
    ID_Venda INT AUTO_INCREMENT PRIMARY KEY,
    Valor_total DECIMAL(10, 2) NOT NULL,
    Data_venda DATE NOT NULL,
    ID_Pedido INT,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabela Pedido_Produto (Relacionamento N:N entre Pedido e Produto)
CREATE TABLE Pedido_Produto (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Venda_Produto (Relacionamento N:N entre Vendas e Produto)
CREATE TABLE Venda_Produto (
    ID_Venda INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Venda, ID_Produto),
    FOREIGN KEY (ID_Venda) REFERENCES Vendas(ID_Venda),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);