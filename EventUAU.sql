use master
go
DROP DATABASE EventUAU
go
CREATE DATABASE EventUAU
GO
USE EventUAU
GO
CREATE TABLE tblFuncionario(
	idFunc INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(50),
	senha VARCHAR(20),
	permissao VARCHAR(20),
	dataadmissao DATE,
	funcao VARCHAR(20),
	salariobase VARCHAR(10),
	nascimento DATE,
	genero VARCHAR(11),
	telresid CHAR(14),
	telcel CHAR(15),
	cpf CHAR(15) unique,
	rg CHAR(13) unique,
	logradouro VARCHAR(50),
	num INT,
	compl VARCHAR(30),
	cep CHAR(10),
	bairro VARCHAR(30),
	cidade VARCHAR(50),
	estado CHAR(2),
	ctps CHAR(30),
	ativo CHAR(3),
	Log_Func VARCHAR(20)
	)
GO
CREATE TABLE tblFornecedor(
	idForn INT IDENTITY(1,1) PRIMARY KEY,
	nomeempresa VARCHAR(30),
	nomeforn VARCHAR(30),
	cnpj CHAR(20) unique,
	tel CHAR(20),
	email VARCHAR(50) unique,
	logradouro VARCHAR(50),
	num INT,
	compl VARCHAR(30),
	cep VARCHAR(20),
	bairro VARCHAR(30),
	cidade VARCHAR(50),
	estado CHAR(2),
	senha VARCHAR(20),
	ativo CHAR(3),
	tipo VARCHAR(10),
	idFunc INT FOREIGN KEY REFERENCES tblFuncionario(idFunc),
	)
GO
CREATE TABLE tblUsuario(
	idUsuario INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(30),
	email VARCHAR(50) unique,
	cpf CHAR(20),
	rg CHAR(20),
	tel CHAR(20),
	senha VARCHAR(20),
	logradouro VARCHAR(50),
	num INT,
	compl VARCHAR(30),
	cep VARCHAR(20),
	bairro VARCHAR(30),
	cidade VARCHAR(50),
	estado CHAR(2),
	)
GO
CREATE TABLE tblEvento(
	idEvento INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(30),	
	dataevento VARCHAR(12),
	horario VARCHAR(5),
	logradouro VARCHAR(50),
	num INT,
	compl VARCHAR(30),
	cep VARCHAR(20),
	cidade VARCHAR(50),
	estado CHAR(2),
	bairro VARCHAR(30),
	ativo CHAR (3),
	idForn INT FOREIGN KEY REFERENCES tblFornecedor(idForn),
	idUsuario INT FOREIGN KEY REFERENCES tblUsuario(idUsuario),
	)
GO
CREATE TABLE tblForn_Evento(
	idForn_Evento INT IDENTITY(1,1) PRIMARY KEY,
	idForn INT FOREIGN KEY REFERENCES tblFornecedor(idForn),
	idEvento INT FOREIGN KEY REFERENCES tblEvento(idEvento),
	)
GO
CREATE TABLE tblCategProd(
	idCategProd INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(20),
	descricao VARCHAR(50),
	)
GO
CREATE TABLE tblProduto(
	idProd INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(30),
	idCategProd INT FOREIGN KEY REFERENCES tblCategProd(idCategProd),
	)
GO
CREATE TABLE tblCategServ(
	idCategServ INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(20),
	descricao VARCHAR(50),
	)
GO
CREATE TABLE tblServico(
	idServ INT IDENTITY (1,1) PRIMARY KEY,
	nome VARCHAR(30),
	idCategServ INT FOREIGN KEY REFERENCES tblCategServ(idCategServ),
	)
GO
CREATE TABLE tblDetalheProd(
	idDetProd INT IDENTITY(1,1) PRIMARY KEY,
	valor VARCHAR(10),
	descricao VARCHAR(50), 
	idForn INT FOREIGN KEY REFERENCES tblFornecedor(idForn),
	idProd INT FOREIGN KEY REFERENCES tblProduto(idProd),
	)
GO
CREATE TABLE tblDetalheServ(
	idDetServ INT IDENTITY(1,1) PRIMARY KEY,
	valor VARCHAR(10),  
	descricao VARCHAR(50),
	idForn INT FOREIGN KEY REFERENCES tblFornecedor(idForn),
	idServ INT FOREIGN KEY REFERENCES tblServico(idServ),
	)
GO
CREATE TABLE tblPedido(
	idPedido INT IDENTITY(1,1) PRIMARY KEY,
	valortotal VARCHAR(10),
	datapedido DATE,
	idEvento INT FOREIGN KEY REFERENCES tblEvento(idEvento),
	idUsuario INT FOREIGN KEY REFERENCES tblUsuario(idUsuario),
	)
GO
CREATE TABLE tblPedidoProd(
	idPedProd INT IDENTITY(1,1) PRIMARY KEY,
	idPedido INT FOREIGN KEY REFERENCES tblPedido(idPedido),
	idProd INT FOREIGN KEY REFERENCES tblProduto(idProd),
	idForn INT FOREIGN KEY REFERENCES tblFornecedor(idForn), -- Tive que adicionar se não, não daria para pegar o valor do produto
	)
go
create table tblPedidoServ(
	idPedServ int identity(1,1) primary key,
	idPedido int foreign key references tblPedido(idPedido),
	idServ int foreign key references tblServico(idServ),
	idForn INT FOREIGN KEY REFERENCES tblFornecedor(idForn), -- Tive que adicionar se não, não daria para pegar o valor do serviço
	)
go
create table tblConvidados(
	idConvidados int identity(1,1) primary key,
	nomelista varchar(50),
	nomeconvidado varchar(50),
	emailconvidado varchar(50),
	telconvidado char(15),
	idEvento int foreign key references tblEvento(idEvento),
	)
go
create table tblFornUsuario(
	idFornUsuario int identity(1,1) primary key,
	nome varchar(50),
	tel varchar(11),
	email varchar(50),
	logradouro varchar(50),
	num int,
	compl varchar(30),
	cep varchar(15),
	cidade varchar(50),
	estado char(2),
	descricao varchar(100),
	idEvento int foreign key references tblEvento(idEvento),
	)

go
insert into tblFuncionario (nome,senha,Log_Func) values ('Mateus Machado','eventuau','evmateusm')
go
insert into tblFornecedor (nomeempresa,nomeforn,cnpj,tel,email,logradouro,num,compl,cep,bairro,cidade,senha,ativo, estado, tipo, idFunc) values 
('EventUei','UhuulForn','111.111.111/1111-11','1111-1111','UhuulForn@email.com','Rua Uhuul',10,'UhuulPredio','11111-111','UhuulBairro','São Paulo','11111','Sim','SP','Serviço', 1),
('EventUou','YeahForn','222.222.222/2222-22','2222-2222','YeahForn@email.com','Rua Yeah',20,'YeahPredio','22222-222','YeahBairro','São Paulo','22222','Sim','SP','Serviço', 1),
('EventUar','LoLForn','333.333.333/3333-33','3333-3333','LoLForn@email.com','Rua LoL',30,'LoLPredio','33333-333','LoLBairro','São Paulo','33333','Sim','SP','Serviço',1),
('EventUuu','YepForn','444.444.444/4444-44','4444-4444','YepForn@email.com','Rua Yep',30,'YepPredio','44444-444','YepBairro','São Paulo','44444','Sim','SP','Serviço',1),
('EventUas','UauForn','555.555.555/5555-55','5555-5555','UauForn@email.com','Rua Uau',30,'UauPredio','55555-555','UauBairro','São Paulo','55555','Sim','SP','Serviço',1)
go
insert into tblCategServ (nome,descricao) values
('Buffet','Buffet de gala para seu evento!'),
('Salão de festas','Salões para seu evento'),
('Brinquedos','Brinquedos para seu evento!'),
('Barman','Barman fino para seu evento!'),
('Garçons','Gargons finos para seu evento!')

go
insert into tblServico (nome, idCategServ) values 
('Buffet',1),
('Salão de festas',2),
('Brinquedos',3),
('Barman',4),
('Garçons',5)
go
insert into tblDetalheServ (valor, descricao,idForn,idServ) values 
('','Nosso Buffet é Uei!',1,1),
('','Nosso Buffet é Uou!',2,1),
('','Nosso Buffet é Uar!',3,1),
(110,'Nosso Salão é Uei!',1,2),
(160,'Nosso Salão é Uuu!',4,2),
(100,'Nosso Salão é Uas!',5,2),
('','Nossos Brinquedos Uei são incríveis',1,3),
('','Nossos Brinquedos Uuu são incríveis',4,3),
('','Nossos Brinquedos Uas são incríveis',5,3),
(70,'Nosso Barman é Uei!',1,4),
(50,'Nosso Barman é Uou!',2,4),
(90,'Nosso Barman é Uar!',3,4),
(100,'Nosso Barman é Uuu!',4,4),
(2000,'Nossos Garçons são Uei!',1,5),
(2500,'Nossos Garçons são Uou!',2,5)

go
insert into tblCategProd (nome, descricao) values
('Alimentação', 'Produtos alimentícios em geral'),
('Diversão','Produtos para a diversão de todos'),
('Aluguel','Locais para alugar')
go
insert into tblProduto (nome, idCategProd) values
('Kibe',1),
('Esfiha',1),
('Brigadeiro',1),
('Coxinha',1),
('Pula-Pula',2),
('Piscina de bolinhas',2),
('Ringue de boxe',2)
go
insert into tblDetalheProd(valor, descricao, idForn, idProd) values 
(200,'Nosso Kibe é Uei, 100un!',1,1),
(300,'Nosso Kibe é Uou, 100un!',2,1),
(400,'Nosso Kibe é Uar, 100un!',3,1),
(210,'Nossa Esfiha é Uei, 100un!',1,2),
(310,'Nossa Esfiha é Uou, 100un!',2,2),
(410,'Nossa Esfiha é Uar, 100un!',3,2),
(220,'Nosso Brigadeiro é Uei, 100un!',1,3),
(320,'Nosso Brigadeiro é Uou, 100un!',2,3),
(230,'Nossa Coxinha é Uei, 100un!',1,4),
(1000,'Pule bem alto com o o pula-pula Uei, 1un!',1,5),
(1200,'Pule bem alto com o o pula-pula Uuu, 1un!',4,5),
(1300,'Pule bem alto com o o pula-pula Uas, 1un!',5,5),
(900,'Mergulhe nas bolinhas com a piscina Uei, 1un!',1,6),
(800,'Mergulhe nas bolinhas com a piscina Uuu, 1un!',4,5),
(3000,'Quebre seu nariz no nosso Ringue de Boxe Uei, 1un!',1,7)
go
insert into tblUsuario (nome,email,senha) values ('admin','admin@email.com',123456)
go
select * from tblUsuario
go
select idForn,nomeempresa from tblFornecedor where idForn in (select idForn from tblPedidoServ)
go
select * from tblServico
go
select * from tblProduto where idProd in (select idProd from tblDetalheProd where idForn=1 and idCategProd=1)
go 
select * from tblDetalheServ where idForn in (select idForn from tblForn_Evento where idForn in (select idForn from tblPedidoServ)) and idServ in (select idServ from tblPedidoServ where idServ=1)
go
select count(*) from tblFornecedor where idForn in (select idForn from tblDetalheServ)
go
select * from tblDetalheProd where idForn in (select idForn from tblForn_Evento) and idProd in (select idProd from tblPedidoProd)
go 
select * from tblProduto where idProd in (select idProd from tblDetalheProd where idForn=1 and idCategProd=2)
go
select * from tblPedidoProd 
go
select * from tblPedidoServ
go
select * from tblPedido where idEvento in (select idEvento from tblEvento where idEvento=1)
go
select * from tblEvento
go
select * from tblForn_Evento
go
select * from tblServico where idServ in (select idServ from tblPedidoServ where idServ=2 and idPedido in (select idPedido from tblPedido where idPedido=1)) 

select * from tblEvento where idEvento in (select idEvento from tblPedido) and idUsuario=1