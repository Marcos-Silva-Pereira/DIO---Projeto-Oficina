-- inserção de dados e queries
use oficina;

-- clientes
-- idcliente, primero_nome, ultimo_nome, tipo_documento('CPF', 'CNPJ'), numero_documento, telefone, email, endereco
insert into clientes (primero_nome, ultimo_nome, tipo_documento, numero_documento, telefone, email, endereco) 
				values ('Andre', 'Souza', 'CPF', '12345678912', '1112345678', 'andre@gmail.com', 'rua um - cidade alta'),
						('Bruno', 'Lima', default, '12345678913', '4812345690', 'bruno@gmail.com', 'rua dois - cidade baixa'),
                        ('Carlos', 'Augusto', 'CPF', '12345678914', '3612345687', 'carlos@gmail.com', 'rua tres - cidade alta');

-- ordem_servico
-- idordem_servico, data_servico, tipo_pag('pix', 'cartao', 'debito', 'dinheiro')
insert into ordem_servico (data_servico, tipo_pag) 
				values ('15/07/2023', 'pix'),
						('20/07/2023', 'cartao'),
                        ('22/07/2023', default),
                        ('23/07/2023', 'pix'),
                        ('08/08/2023', 'debito'),
                        ('17/08/2023', 'dinheiro'),
                        ('21/08/2023', default);

-- veiculos
-- idveiculo, idVcliente(idcliente), marca, modelo, ano, placa
insert into veiculos (idVcliente, marca, modelo, ano, placa) 
				values (1, 'bmw', 'x3', '2023', 'abc1234'),
						(2, 'fiat', 'palio', '2019', 'xyz4321'),
                        (3, 'honda', 'civic', '2021', 'def5678'),
                        (1, 'fiat', 'uno', '2000', 'ghi9012');

-- equipes
-- idequipes, times('A', 'B', 'C'), quantidade
insert into equipes (times, quantidade) 
				values ('A', 3),
						('B', 2),
                        ('C', default);

-- fornecedores
-- idfornecedor, nome_fantasia, cnpj, contato
insert into fornecedores (nome_fantasia, cnpj, contato) 
				values ('Auto pecas tiao', '12345678901', '10987654321'),
						('Auto pecas socorro', '32145678901', '11987654322'),
                        ('Auto pecas do centro', '12365478109', '12987654323');

-- orcamento
-- idorcamento, idOordem_servico(idordem_servico), idOveiculos(idveiculo), idOclientes(idcliente), idOequipes(idequipes), idOfornecedores(idfornecedor), mao_obra, valor_pecas, valor_total
insert into orcamento (idOordem_servico, idOveiculos, idOclientes, idOequipes, idOfornecedores, mao_obra, valor_pecas, valor_total) 
				values (1, 1, 1, 1, 1, 150, 85, 235),
						(2, 2, 2, 2, 2, 100, 70, 170),
                        (3, 3, 3, 2, 3, 100, 50, 150),
                        (4, 4, 1, 3, 2, 50, 100, 150),
                        (5, 3, 3, 2, 1, 100, 145, 245),
                        (6, 2, 2, 3, 2, 50, 90, 140),
                        (7, 1, 1, 1, 1, 150, 120, 270);

-- mecanicos
-- idmecanico, idMequipes(idequipes), nome, cpf, telefone, endereco, anos_experiencia, salario
insert into mecanicos (idMequipes, nome, cpf, telefone, endereco, anos_experiencia, salario) 
				values ( 1, 'joao claudio', '12345678901', '1123456789', 'av um - centro', '5', 1500),
						( 2, 'david luis', '32145678901', '1223456789', 'rua dois - centro', '8', 1700),
                        ( 3, 'luis carlos', '41245678901', '1323456789', 'av tres - centro', '15', 2500),
                        ( 1, 'sergio silva', '12345678922', '1423456789', 'rua quatro - centro', '3', 1300),
                        ( 2, 'lucas melo', '12345678333', '1523456789', 'travessa cinco - centro', '10', 1800),
                        ( 1, 'william jose', '32145678109', '1623456789', 'av nove - centro', '11', 2000);

-- --------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAS --
-- 1 Recuperacao simples de todos os fornecedores
select * from fornecedores;

-- 2 Recuperacao de todos os mecanicos da equipe 'A'
select * from mecanicos 
where idMequipes=1;

-- 3 Qual o(s) veiculos de cada cliente ?
select concat(c.primero_nome, ' ', c.ultimo_nome) as cliente, v.marca, v.modelo, v.ano, v.placa
from clientes c join veiculos v on v.idVcliente = c.idcliente
group by cliente, v.marca, v.modelo, v.ano, v.placa;

-- 4 Ordenar mecanicos por salario e que tenham mais de 6 anos de experiencia, do maior para o menor
select nome, anos_experiencia, salario from mecanicos
where anos_experiencia > 6
order by salario desc;

-- 5 Quais os mecanicos que trabalharam em relacao ao carro 'bmw' e quais as suas equipes de trabalho ?
select m.nome as mecanico, e.times as equipe, v.marca as marca, v.modelo as modelo
from mecanicos m join equipes e on m.idMequipes = e.idequipes
join orcamento o on o.idOequipes =  e.idequipes
join veiculos v on o.idOveiculos = v.idveiculo
where marca = 'bmw'
group by mecanico, equipe, marca, modelo;

-- 6 Quais os clientes que pagaram em 'pix' ?
select concat(c.primero_nome, ' ', c.ultimo_nome) as cliente, o.valor_total as valor, os.tipo_pag as Forma_de_pgto, data_servico as data_pgto
from clientes c join orcamento o on o.idOclientes = c.idcliente
join ordem_servico os on o.idOordem_servico = os.idordem_servico
having  Forma_de_pgto = 'pix'
order by data_pgto asc;

-- 7 Qual o valor total que cada cliente pagou ?
select concat(c.primero_nome, ' ', c.ultimo_nome) as cliente, sum(o.valor_total) as valor
from clientes c join orcamento o on o.idOclientes = c.idcliente
group by o.idOclientes, cliente
order by valor desc;

-- 8 Qual o valor total de pecas por fornecedor ?
select f.nome_fantasia as fornecedor, sum(o.valor_pecas) as Valor_pecas
from orcamento o, fornecedores f
where o.idOfornecedores = f.idfornecedor
group by fornecedor;

-- 9 Valor total de mao de obra por equipes de mecanicos
select e.times as equipes, sum(o.mao_obra) as mao_de_obra
from equipes e join orcamento o on o.idOequipes = e.idequipes
group by equipes;