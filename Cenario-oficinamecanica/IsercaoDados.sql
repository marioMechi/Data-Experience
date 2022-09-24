use oficinamecanica;

insert into Cliente(Fname, Minit, Lname, CPF, Endereco)
values('Maria', 'M', 'Silva', 12346789123, 'rua silva prata 29, Carangola - Cidade das flores'),
	  ('Matheus', 'O', 'Pimentel', 98764321123, 'rua alameda 259, Centro - Cidade das flores'),
      ('Ricardo', 'F', 'Silva', 43216789123, 'av. alameda vinha 1009, Centro - Cidade das flores'),
      ('Julia', 'S', 'França', 54327890121, 'rua laranjeira 861, Centro - Cidade das flores'),
      ('Roberta', 'G', 'Assis', 87654321121, 'avenida de koller 19, Centro - Cidade das flores'),
      ('Isabela', 'M', 'Cruz', 98762345123, 'rua alameda flores 28, Centro - Cidade das flores');

insert into  Veiculo(Marca, Modelo, Cor, AnoDeFabricacao, TipoAcessorios,idVCliente)
values('Volkswagem', 'Gol', 'Azul', 2019, 'GTI-4portas-turbo',1),
	  ('Fiat', 'Pulse', 'Vermelho', 2021, 'Vulcano',2),
      ('Renault', 'Duster', 'Caramelo', 2022, '1.3 Turbo',3),
      ('Volkswagem', 'T-Cross', 'Parta', 2021, '2.0 - banco de couro',4),
      ('Fiat', 'Toro', 'Preto', 2016, 'Endurance',5),
      ('BMW', 'X-35', 'Branca', 2019, 'Supercharged',6);
      
insert into OrdemServico(idOSClient, OrdemStatus, dataEmissao, Valor)
values(1, default, 2022-05-07, 2000),
	  (2, default, 2022-04-18, 3000),
      (3,'Confirmado', 2022-04-15, 18000),
      (4, default, 2022-06-12, 5000),
      (5, 'Confirmado', 2022-08-12, 9000),
      (6, 'Cancelado', 2022-02-11, 30000);

insert into Servico(Descrcao, tempo)
values('Trocas de pneus', 6) ,
	  ('Revisão', 12),
      ('Correia dentada', 48),
      ('Pintura',7),
      ('Troca Para choque', 12),
      ('Troca de amortecedores e revisão',48);
	
insert into TabelaReferencia(MaoDeObra, idTServico)
values(2, 7),
	  (4,8),
      (3,9),
      (1,10),
      (4,11),
      (2,12);
     
insert into consulta(Valor, idCTabelaReferncia, idCOrdemServico, idCCliente)
values(2000,13,1,1),
	  (3000,14,2,2),
      (18000,15,3,3),
      (5000,16,4,4),
      (9000,17,5,5),
      (30000,18,6,6);
      
insert into Pecas(tipo, tamanho, modelo)
values('Amortecedor', '600 mm', 'BN2'),
	  ('Parafuso', '50 mm', 'Motor'),
      ('Pneu', 'Aro 17', 'Volkswagem'),
      ('Pastilha de freio', '90 mm', 'Abs');

insert into Utiliza(quantidade, idUPecas, idUOrdemServico, idUCliente)
values(2, 1, 6, 6),
	  (15,2,5,5),
      (4,3,5,4),
      (4,4,4,4);
      
insert into Mecanico(Nome, Endereco, Especialidade)
values('Joao', 'Belo Horizonte', 'Manutenção'),
	  ('Carlos', 'Rio de Janeiro', 'Pintura'),
      ('Leonardo', 'São Paulo', 'Revisão'),
      ('Vitor','Belo Horizonte', 'Pintura'),
      ('Marcos','São Paulo','Manutenção'),
      ('Lucas', 'Rio de Janeiro','Revisão');

insert into Servico_OrdemServico(idSOServico,idSOOrdemServico,idSOCliente)
values(7,1,1),
	  (8,2,2),
      (9,3,3),
      (10,4,4),
      (11,5,5),
      (12,6,6);
      
-- cliente e seus carros
select concat(Fname,' ',Lname) as Nome_cliente, Modelo, Marca from (cliente s join veiculo p on s.idCliente = p.idVCliente);
-- carros e serviços
select Marca, Modelo,Descrcao  from (Servico_OrdemServico s join veiculo v on s.idSOOrdemServico = v.idVOrdemServico
					inner join Servico e on s.idSOServico = e.idServico);
-- serviço com valor acima de 15000
select Descrcao, valor from (Servico_OrdemServico s join Servico o on idSOServico = idServico
					inner join consulta c on s.idSOCliente = c.idCCliente)
having valor > 15000;
