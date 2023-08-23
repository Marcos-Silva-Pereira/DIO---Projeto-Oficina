-- criação do banco de dados para o cenário de oficina
create database oficina;
use oficina;

-- criando a tabela clientes
create table clientes(
	idcliente int auto_increment primary key,
    primero_nome varchar(20),
    ultimo_nome varchar(20),
    tipo_documento enum('CPF', 'CNPJ') default 'CPF' not null,
    numero_documento varchar(15) not null,
    telefone varchar(11),
    email varchar(25),
    endereco varchar(100),
    constraint unique_documento_numero unique (numero_documento) 
);

-- criando a tabela ordem_servico
create table ordem_servico(
	idordem_servico int auto_increment primary key,
    data_servico varchar(10),
    tipo_pag enum('pix', 'cartao', 'debito', 'dinheiro') default 'cartao'
);

-- criando a tabela veiculos
create table veiculos(
	idveiculo int auto_increment primary key,
    idVcliente int,
    marca varchar(15),
    modelo varchar(15),
    ano varchar(4),
    placa varchar(7) not null,
    constraint unique_veiculo_placa unique (placa),
    constraint fk_veiculos_cliente foreign key (idVcliente) references clientes(idcliente)
);

-- criando a tabela equipes
create table equipes (
	idequipes int auto_increment primary key,
    times enum ('A', 'B', 'C') default 'C',
    quantidade int not null default 1
);

-- criando a tabela fornecedores
create table fornecedores(
	idfornecedor int auto_increment primary key,
    idForcamento int,
    nome_fantasia varchar(30),
    cnpj varchar(11) not null,
    contato varchar(11),
    constraint unique_fornecedores_cnpj unique (cnpj)
);

-- criando a tabela orcamento
create table orcamento(
	idorcamento int auto_increment primary key,
    idOordem_servico int,
    idOveiculos int,
    idOclientes int,
    idOequipes int,
    idOfornecedores int,
    mao_obra float,
    valor_pecas float,
    valor_total float not null,
    constraint fk_orcamento_ordemservico foreign key (idOordem_servico) references ordem_servico(idordem_servico),
    constraint fk_orcamento_veiculos foreign key (idOveiculos) references veiculos(idveiculo),
    constraint fk_orcamento_clientes foreign key (idOclientes) references clientes(idcliente),
    constraint fk_orcamento_equipes foreign key (idOequipes) references equipes(idequipes),
    constraint fk_orcamento_fornecedores foreign key (idOfornecedores) references fornecedores(idfornecedor)
);

-- criando a tabela mecanicos
create table mecanicos(
	idmecanico int auto_increment primary key,
    idMequipes int,
    nome varchar(30),
    cpf varchar(11) not null,
    telefone varchar(11),
    endereco varchar(100),
    anos_experiencia varchar(2),
    salario float default 1300 not null,
    constraint unique_mecanicos_cpf unique (cpf),
    constraint fk_mecanicos_equipes foreign key (idMequipes) references equipes(idequipes)
);
