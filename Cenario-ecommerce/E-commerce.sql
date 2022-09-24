-- criação de banco de dados para o cenário de e-commerce

create database ecommerce;
use ecommerce;

create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname varchar(20),
CPF char(11) not null,
Address varchar(50),
constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment = 1;
create table Product(
idProduct int auto_increment primary key,
Pname varchar(20) not null,
classification_kid bool default false,
category enum('Eletrônico', 'Roupa', 'Brinquedos', 'Alimentos', 'Móveis', 'Livros') not null,
avaliation float default 0,
size varchar(10)
);
create table Payment(
idPClient int ,
id_payment int,
tipePayment enum ('Boleto', 'Cartão', 'Pix'),
limitAvailable float,
primary key (idPClient, id_payment),
constraint fk_payment_client foreign key (idPClient) references clients(idClient)
);
create table Orders(
idOrders int auto_increment primary key,
idOrdersClient int,
ordersStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
ordersDescription varchar(255),
sendValue float default 10,
paymentCash bool default false,
constraint fk_orders_client foreign key (idOrdersClient) references clients(idClient)
on update cascade
on delete set null
);
create table productStorage(
idStorage int auto_increment primary key,
storangeLocation varchar(255),
quantity int default 0
);
create table Suplier(
idSuplier int auto_increment primary key,
socialName varchar(255) not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_Suplier unique(CNPJ)
);
create table Seller(
idSeller int auto_increment primary key,
socialName varchar(255) not null,
abstractName varchar(255),
CNPJ char(15),
CPF char(11),
location varchar(255) not null,
contact char(11) not null,
constraint unique_cnpj_Seller unique(CNPJ),
constraint unique_cpf_Seller unique(CPF)
);
create table productSeller(
idPSeller int,
idPProduct int,
prodQuantity int default 1,
primary key (idPSeller, idPProduct),
constraint fk_product_seller foreign key (idPSeller) references Seller(idSeller),
constraint fk_product_product foreign key (idPProduct) references Product(idProduct)
);
create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
primary key (idPOproduct, idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references Product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrders)
);
create table storageLocation(
idLstorage int,
idPLproduct int,
location varchar (255)not null,
primary key (idLstorage, idPLproduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idStorage),
constraint fk_storage_location_product foreign key (idPLproduct) references Product(idProduct)
);
create table productSuplier(
idPsSuplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSuplier, idPsProduct),
constraint fk_productsuplier_suplier foreign key (idPsSuplier) references Suplier(idSuplier),
constraint fk_productsuplier_product foreign key (idPsProduct) references Product (idProduct)
);
use information_schema;
show tables;
select * from REFERENTIAL_CONSTRAINTS where constraint_schema = 'ecommerce';