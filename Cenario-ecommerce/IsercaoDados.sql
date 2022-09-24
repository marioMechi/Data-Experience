-- inserção de dados e queries
use ecommerce;

insert into Clients(Fname, Minit, Lname, CPF, Address)
values('Maria', 'M', 'Silva', 12346789123, 'rua silva prata 29, Carangola - Cidade das flores'),
	  ('Matheus', 'O', 'Pimentel', 98764321123, 'rua alameda 259, Centro - Cidade das flores'),
      ('Ricardo', 'F', 'Silva', 43216789123, 'av. alameda vinha 1009, Centro - Cidade das flores'),
      ('Julia', 'S', 'França', 54327890121, 'rua laranjeira 861, Centro - Cidade das flores'),
      ('Roberta', 'G', 'Assis', 87654321121, 'avenida de koller 19, Centro - Cidade das flores'),
      ('Isabela', 'M', 'Cruz', 98762345123, 'rua alameda flores 28, Centro - Cidade das flores');
      
insert into Product(Pname, classification_kid, category, avaliation, size)
values('Fone ouvido', false, 'Eletrônico', '4', null),
	  ('Barbie Elsa', true, 'Brinquedos', '3', null),
      ('Bodie Carters', true, 'Roupa', '3', null),
      ('Microfone youtuber', False, 'Eletrônico', '4', null),
      ('Sofá retratil', False, 'Móveis', '3', '3x57x80'),
      ('Farinha de arroz', False, 'Alimentos', '2', null),
      ('Fire Stick Amazon', False, 'Eletrônico', '3', null);

insert into Orders(idOrdersClient, ordersStatus, ordersDescription, sendValue, paymentCash)
values(1, default, 'compra via aplicativo', null,1),
	  (2, default, 'compra via aplicativo', 50,0),
      (3,'Confirmado', null, null, 1),
      (4, default, 'compra via web site', 150,0);

select * from product;      
insert into productOrder(idPOproduct, idPOorder, poQuantity, poStatus)
values(1,1,2,null),
	  (2,1,1,null),
      (3,2,1,null);
      
insert into productStorage(storangeLocation, quantity)
values('Rio de Janeiro', 1000),
	  ('Rio de Janeiro', 500),
      ('São Paulo', 10),
      ('São Paulo', 100),
      ('São Paulo',10),
      ('Brasília', 60);
      
select * from productStorage;
insert into storageLocation(idLstorage, idPLproduct, location)
values(1,2,'RJ'),
	  (1,1,'GO');
      
insert into Suplier(socialName, CNPJ, contact)
values('Almeida e Filhos', 123456789123456, 12345678910),
	  ('Eletrônicos SIlva', 657829876542341, 17865432187),
      ('Eletrônicos Vilma', 178245624319875, 18765439874);
      
insert into productSuplier(idPsSuplier, idPsProduct, quantity)
values(1,1,500),
	  (1,2,400),
      (2,3,633),
      (3,4,5),
      (2,5,10);
      
insert into Seller(socialName, abstractName, CNPJ, CPF, location, contact)
values('Tech Eletronics',null, 187265398645678, null, 'Rio de Janeiro', 19827635498),
	  ('Botique Durgas', null, null, 18735987654, 'Rio de Janeiro', 23141562312),
      ('Kids World', null, 123145211329876, null, 'São Paulo', 11235432768);

insert into productSeller(idPSeller, idPProduct, prodQuantity)
values(1,6,80),
	  (2,7,10);
      
select * from clients c, orders o where idClient = idOrdersClient;

select count(*) from clients;

select concat(Fname,' ', Lname)as client, idOrders as request, ordersStatus as status from clients c, orders o where c.idClient = o.idOrdersClient;

insert into Orders(idOrdersClient, ordersStatus, ordersDescription, sendValue, paymentCash)
values(2,default,'compra via app', null,1);

select * from clients c, orders o where idClient = idOrdersClient
group by idOrders;

select * from clients inner join orders on  idClient = idOrdersClient
					  inner join product on idProduct = idOrders
group by idClient;
-- recuperar qunatos pedidos feitos apelo cliente
select count(*)as Number_of_orders, Fname from clients  c inner join orders o on  c.idClient = o.idOrdersClient
					  inner join productOrder p on p.idPOorder = o.idOrders
group by idClient;
-- recuperação de produto associado
select * from clients c inner join orders o on  c.idClient = o.idOrdersClient
					  inner join productOrder p on p.idPOorder = o.idOrders
group by idClient;
-- vendedores que são fornecedor
insert into Seller(socialName, abstractName, CNPJ, CPF, location, contact)
values('Bebidas do João',null, 123456234208571,null, 'Minas Gerais',3133445921);
insert into Suplier(socialName, CNPJ, contact)
values('Bebidas do João', 123456234208571, 3133445921);
select * from (seller s join suplier p on s.CNPJ = p.CNPJ);
-- relação de produtos e estoques
select * from (product left outer join productStorage on idProduct = idStorage
				inner join suplier on idProduct = idSuplier);
select Pname, quantity from (product left outer join productStorage on idProduct = idStorage)
where quantity >1;
-- relação nomes dos fornecedores e nomes dos produtos
select Pname, socialName from (product left outer join productStorage on idProduct = idStorage
				inner join suplier on idProduct = idSuplier);