CREATE DATABASE ecommerce;

USE ecommerce;

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(20) NOT NULL
);

-- Tabela Cliente (Agora com suporte a PJ e PF)
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Tipo_Cliente ENUM('PF', 'PJ') NOT NULL, -- Tipo de cliente: PF ou PJ
    CPF VARCHAR(14),  -- Para PF
    CNPJ VARCHAR(20), -- Para PJ
    Endereco VARCHAR(255) NOT NULL,
    CONSTRAINT chk_cpf_cnpj CHECK (
        (Tipo_Cliente = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR
        (Tipo_Cliente = 'PJ' AND CPF IS NULL AND CNPJ IS NOT NULL)
    )
);

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

-- Tabela Pagamento (Forma de pagamento do cliente)
CREATE TABLE Pagamento (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    Tipo_Pagamento ENUM('Cartão de Crédito', 'Boleto', 'Transferência', 'Pix', 'Débito') NOT NULL,
    Detalhes VARCHAR(255),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Data DATE NOT NULL,
    Endereco_entrega VARCHAR(255) NOT NULL,
    Status VARCHAR(50) NOT NULL,  -- Status do pedido (ex: "Em Processamento", "Enviado", "Cancelado")
    ID_Cliente INT,
    Status_Entrega ENUM('Pendente', 'Em Transporte', 'Entregue', 'Cancelado') NOT NULL,
    Codigo_Rastreio VARCHAR(100),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
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