
# DIO - Desafio Banco de Dados Oficina

## Resumo

Neste desafio do curso  Potência Tech powered by iFood - Ciência de Dados da DIO, foi construido um Banco de Dados no MySql, simulando um banco de dados de uma oficina.

## Guia dos arquivos

- "tabelas.sql" é o srcipt de criação das tabelas;
- "dados.sql" é o script de inserção de dados fictícios nas tabelas, e foram feitas consultas as tabelas, relacionadas a perguntas específicas;
- "diagrama_oficina.png" é uma foto do esquema de relacionamento das tabelas, junto com o arquivo do esquema feito no workbench sql.

## Descrição
Para esse banco de dados foram criadas 7 tabelas. Sendo elas: clientes, veiculos, mecanicos, equipes, fornecedores, orcamento e ordem_servico. 

Nesse Banco de Dados da oficina, é cadastrado **clientes** e seus respectivos **veículos**, os **mecanicos**, as **equipes** que serão composta de 1 a 3 mecanicos para trabalharem em um veículo específico, os **fornecedores** de pecas para a oficina, o **orçamento** que terá os valores relacionado as peças, mão de obra e valor total do reparo, e por fim, a **ordem de serviço** que será composta pela data em que foi feito o serviço e a forma de pagamento efetuada pelo cliente.

Ao final do arquivo "dados.sql", foram feitas consultas respondendo a perguntas que seriam interessantes para o negócio da oficina. 

## Tabelas

- ### clientes

    Os clientes são cadastrados com idclientes, primeiro nome, ultimo nome, CPF/CNPJ, numero do documento, telefone, email e endereco.

- ### veiculos

    Os veiculos são cadastrados com idveiculos, marca, modelo, ano e placa.

- ### mecanicos

    Os mecanicos são cadastrados com idmecanicos, nome, cpf, telefone, endereco, anos_experiencia e salario.

- ### equipes

    Equipes são cadastradas com idequipes, times(A, B, C) e quantidades(de mecanicos).

- ### fornecedores

    Fonecedores são cadastrados com idfornecedor, nome_fantasia, cnpj e contato.

- ### orcamento

    Orçamento é cadastrado com idorcamento, mao_obra(valor da mao de obra), valor_pecas (valor total das pecas necessarias para o reparo), valor_total (valor somado da mao de obra e do valor das pecas).

- ### ordem_servico

    Ordem de serviço é cadastrado com idordem_servico, data_servico e tipo_pag(a forma de pagamento).
