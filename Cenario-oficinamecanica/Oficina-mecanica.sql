create database oficinamecanica;
use oficinamecanica;

create table cliente(
idCliente int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname varchar(20),
CPF char(11) not null,
Endereco varchar(50),
constraint unique_cpf_client unique (CPF)
);
alter table cliente auto_increment = 1;
create table OrdemServico(
idOrdemServico int auto_increment primary key,
idOSClient int,
OrdemStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
dataEmissao date,
Valor float,
constraint fk_ordemservico_client foreign key (idOSClient) references Cliente(idCliente)
on update cascade
on delete set null
);
create table Veiculo(
idVeiculo int auto_increment primary key,
Marca varchar(20) not null,
Modelo varchar(20) not null,
Cor varchar(20) not null,
AnoDeFabricacao int(4) not null,
TipoAcessorios varchar(20) not null,
idVOrdemServico int,
idVCliente int,
constraint fk_veiculo_ordemservico foreign key (idVOrdemServico) references OrdemServico(idOrdemServico),
constraint fk_veiculo_cliente foreign key(idVCliente) references cliente(idCliente)
);
create table consulta(
Valor float,
idCTabelaReferncia int,
idCOrdemServico int,
idCCliente int,
primary key (idCTabelaReferencia, idCOrdemServico, idCCliente),
constraint fk_consulta_cliente foreign key (idCCliente) references cliente(idCliente),
constraint fk_consulta_ordemservico foreign key (idCOrdemServico) references OrdemServico(idOrdemServico)
);
create table TabelaReferencia(
MaoDeObra varchar(45),
idTabelaReferncia int auto_increment primary key,
idTServico int
);
alter table consulta add constraint fk_consulta_tabelareferencia foreign key(idCTabelaReferncia) references TabelaReferencia(idTabelaReferncia);
create table Servico(
Descrcao varchar(45),
tempo time,
idServico int auto_increment primary key
);
alter table TabelaReferencia add constraint fk_tabelareferencia_servico foreign key (idTServico) references Servico(idServico);
create table Servico_OrdemServico(
idSOServico int,
idSOOrdemServico int,
idSOCliente int,
primary key (idSOServico, idSOOrdemServico, idSOCliente),
constraint fk_sos_servico foreign key (idSOServico) references Servico(idServico),
constraint fk_sos_ordemservico foreign key (idSOOrdemServico) references OrdemServico(idOrdemServico),
constraint fk_sos_cliente foreign key(idSOCliente) references cliente(idCliente)
);
create table Pecas(
tipo varchar(45),
tamanho varchar(45),
modelo varchar(45),
idPecas int auto_increment primary key
);
create table Utiliza(
idUPecas int,
idUOrdemServico int,
idUCliente int,
quantidade int,
primary key (idUPecas, idUOrdemServico, idUCliente),
constraint fk_utiliza_pecas foreign key (idUPecas) references Pecas(idPecas),
constraint fk_utiliza_ordemservico foreign key (idUOrdemServico) references OrdemServico(idOrdemServico),
constraint fk_utiliza_cliente foreign key(idUCliente) references cliente(idCliente)
);
create table Mecanico(
idMecanico int auto_increment primary key,
Nome varchar(20) not null,
Endereco varchar(50) not null,
Especialidade varchar(20) not null,
idMOrdemServico int,
idMCliente int,
constraint fk_mecanico_ordemservico foreign key (idMOrdemServico) references OrdemServico(idOrdemServico),
constraint fk_mecanico_cliente foreign key(idMCliente) references cliente(idCliente)
);
create table Servico_Mecanico(
idSMServico int,
idSMMecanico int,
idSMOrdemServico int,
idSMCliente int,
primary key (idSMServico, idSMOrdemServico, idSMCliente, idSMMecanico),
constraint fk_sm_servico foreign key (idSMServico) references Servico(idServico),
constraint fk_sm_mecanico foreign key (idSMMecanico) references Mecanico(idMecanico),
constraint fk_sm_ordemservico foreign key (idSMOrdemServico) references OrdemServico(idOrdemServico),
constraint fk_sm_cliente foreign key(idSMCliente) references cliente(idCliente)
);