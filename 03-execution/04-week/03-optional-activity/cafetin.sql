/****************************************************************************************************
* Create a database named `coffee-shop` to store all the data related to the coffee shop operations.*
*                                                                                                   *
* Use SMBD postgreSQL to create the database and ensure that it is properly                         *
* set up for use in subsequent exercises.                                                           *
*                                                                                                   *
* Use docker to run a PostgreSQL container, is required activity. Make sure to follow the           *
* instructions provided in the course materials to set up the container correctly.                 *
*****************************************************************************************************/


DROP DATABASE IF EXISTS cafetin;
CREATE DATABASE cafetin;

\c cafetin


-- ==================== MODULE 1: SECURITY ====================

-- User Table
CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL REFERENCES person(id),
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Role Table
CREATE TABLE role (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Module Table
CREATE TABLE module (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- View Table
CREATE TABLE view (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    url VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- User Role Table
CREATE TABLE user_role (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES "user"(id),
    role_id UUID NOT NULL REFERENCES role(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true,
    UNIQUE(user_id, role_id)
);

-- Role Module Table
CREATE TABLE role_module (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id UUID NOT NULL REFERENCES role(id),
    module_id UUID NOT NULL REFERENCES module(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true,
    UNIQUE(role_id, module_id)
);

-- Module View Table
CREATE TABLE module_view (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    module_id UUID NOT NULL REFERENCES module(id),
    view_id UUID NOT NULL REFERENCES view(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true,
    UNIQUE(module_id, view_id)
);

-- ==================== MODULE 2: PARAMETER ====================

-- Type Document Table
CREATE TABLE type_document (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(10) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Person Table
CREATE TABLE person (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    document_type_id UUID NOT NULL REFERENCES type_document(id),
    document_number VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- File Table
CREATE TABLE file (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    path VARCHAR(500) NOT NULL,
    file_type VARCHAR(50),
    size BIGINT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- ==================== MODULE 3: INVENTORY ====================

-- Category Table
CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Supplier Table
CREATE TABLE supplier (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL UNIQUE,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    country VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Product Table
CREATE TABLE product (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL,
    category_id UUID NOT NULL REFERENCES category(id),
    supplier_id UUID REFERENCES supplier(id),
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    cost DECIMAL(10, 2),
    sku VARCHAR(50) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Inventory Table
CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES product(id),
    quantity_available INT NOT NULL DEFAULT 0,
    quantity_reserved INT DEFAULT 0,
    reorder_level INT,
    last_restock_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- ==================== MODULE 4: SALES ====================

-- Customer Table
CREATE TABLE customer (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL REFERENCES person(id),
    loyalty_points INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Method Payment Table
CREATE TABLE method_payment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Order Table
CREATE TABLE "order" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customer(id),
    order_date TIMESTAMPTZ DEFAULT NOW(),
    total_amount DECIMAL(10, 2),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Order Item Table
CREATE TABLE order_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES "order"(id),
    product_id UUID NOT NULL REFERENCES product(id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- ==================== MODULE 5: BILLING ====================

-- Invoice Table
CREATE TABLE invoice (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES "order"(id),
    invoice_number VARCHAR(50) NOT NULL UNIQUE,
    invoice_date TIMESTAMPTZ DEFAULT NOW(),
    due_date TIMESTAMPTZ,
    total_amount DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Invoice Item Table
CREATE TABLE invoice_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID NOT NULL REFERENCES invoice(id),
    product_id UUID NOT NULL REFERENCES product(id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);

-- Payment Table
CREATE TABLE payment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID NOT NULL REFERENCES invoice(id),
    method_payment_id UUID NOT NULL REFERENCES method_payment(id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMPTZ DEFAULT NOW(),
    reference_number VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT true
);
-- ==================== SAMPLE DATA (10 registros coherentes) ====================

-- tipos de documento
INSERT INTO type_document(name, code) VALUES
('Cedula de Ciudadanía','CC'),
('Tarjeta de Identidad','TI');

-- personas
INSERT INTO person(first_name,last_name,document_type_id,document_number,email,phone) VALUES
('Juan','Perez',(SELECT id FROM type_document WHERE code='CC'),'10001','juan.perez@example.com','3001234567'),
('Maria','Lopez',(SELECT id FROM type_document WHERE code='TI'),'20002','maria.lopez@example.com','3007654321');

-- categorias
INSERT INTO category(name,description) VALUES
('Bebidas','Bebidas calientes y fruas'),
('Comidas','Alimentos y snacks');

-- proveedor
INSERT INTO supplier(name,contact_person,email,phone,address,city,country) VALUES
('Proveedor Cafeteria','Carlos GGmez','carlos@supplier.com','3001112222','Cll 10 #20-30','Bogot','Colombia');

-- diez productos coherentes
INSERT INTO product(name,category_id,supplier_id,description,price,cost,sku) VALUES
('Cafe Americano',(SELECT id FROM category WHERE name='Bebidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Caf filtrado',3.50,1.00,'CAF001'),
('Espresso',(SELECT id FROM category WHERE name='Bebidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Doble shot de espresso',2.50,0.80,'CAF002'),
('Latte',(SELECT id FROM category WHERE name='Bebidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Caf con leche',4.00,1.20,'CAF003'),
('Capuccino',(SELECT id FROM category WHERE name='Bebidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Caf espumoso',4.20,1.30,'CAF004'),
('Muffin de arandanos',(SELECT id FROM category WHERE name='Comidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Panadera',2.80,1.00,'PAS001'),
('Torta de chocolate',(SELECT id FROM category WHERE name='Comidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Repostera',3.50,1.50,'PAS002'),
('Sandwich mixto',(SELECT id FROM category WHERE name='Comidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Jamn y queso',5.00,2.00,'COM001'),
('Agua mineral',(SELECT id FROM category WHERE name='Bebidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'500ml',1.00,0.20,'BEV001'),
('Jugo de naranja',(SELECT id FROM category WHERE name='Bebidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'100% natural',2.00,0.80,'BEV002'),
('Galletas de avena',(SELECT id FROM category WHERE name='Comidas'),(SELECT id FROM supplier WHERE name='Proveedor Cafeteria'),'Paquete de 5 unidades',1.50,0.50,'PAS003');

-- metodos de pago
INSERT INTO method_payment(name,description) VALUES
('Efectivo','Pago en efectivo'),
('Tarjeta','Pago con tarjeta de credito/debito');

-- un cliente y una orden de ejemplo
INSERT INTO customer(person_id,loyalty_points) VALUES
((SELECT id FROM person WHERE email='juan.perez@example.com'),10);

INSERT INTO  order(customer_id,total_amount,notes) VALUES
((SELECT id FROM customer WHERE loyalty_points=10),15.00,'Orden de ejemplo');

INSERT INTO order_item(order_id,product_id,quantity,unit_price,subtotal) VALUES
((SELECT id FROM order WHERE notes='Orden de ejemplo'),(SELECT id FROM product WHERE sku='CAF001'),1,3.50,3.50),
((SELECT id FROM order WHERE notes='Orden de ejemplo'),(SELECT id FROM product WHERE sku='PAS001'),2,2.80,5.60);

-- factura y pago para la orden
INSERT INTO invoice(order_id,invoice_number,total_amount,tax_amount) VALUES
((SELECT id FROM order WHERE notes='Orden de ejemplo'),'INV0001',9.10,0.60);

INSERT INTO invoice_item(invoice_id,product_id,quantity,unit_price,subtotal) VALUES
((SELECT id FROM invoice WHERE invoice_number='INV0001'),(SELECT id FROM product WHERE sku='CAF001'),1,3.50,3.50),
((SELECT id FROM invoice WHERE invoice_number='INV0001'),(SELECT id FROM product WHERE sku='PAS001'),2,2.80,5.60);

INSERT INTO payment(invoice_id,method_payment_id,amount,reference_number) VALUES
((SELECT id FROM invoice WHERE invoice_number='INV0001'),(SELECT id FROM method_payment WHERE name='Efectivo'),9.10,'PAY123');

-- Aumentar tipo_document a 10
INSERT INTO type_document(name, code) VALUES
('Pasaporte','PP'),
('Registro Civil','RC'),
('Cedula de Extranjeria','CE'),
('Documento Militar','DM'),
('NIT','NIT'),
('Tarjeta Profesional','TP'),
('Otro','OT'),
('Identificacion Especial','IE');

-- agregar personas para llegar a 10
INSERT INTO person(first_name,last_name,document_type_id,document_number,email,phone)
SELECT 
    'Nombre'||g, 'Apellido'||g,
    (SELECT id FROM type_document ORDER BY created_at LIMIT 1 OFFSET g),
    'N' || LPAD(g::text,5,'0'),
    'user'||g||'@example.com',
    '31000000'||g
FROM generate_series(3,10) g;

-- completar categor�as
INSERT INTO category(name,description) VALUES
('Tes','Bebidas calientes a base de te'),
('Bebidas Frias','Refrescos y jugos frios'),
('Salsas','Aderezos y salsas'),
('Extras','Complementos y toppings'),
('Postres','Dulces y postres'),
('Ensaladas','Opciones saludables'),
('Desayuno','Platos matutinos'),
('Promociones','Ofertas especiales');

-- proveedores adicionales
INSERT INTO supplier(name,contact_person,email,phone,address,city,country) VALUES
('Proveedor B','Ana Ruiz','ana@provb.com','3002223333','Cll 20 #40-50','Medellín','Colombia'),
('Proveedor C','Luis Díaz','luis@provc.com','3003334444','Cll 30 #50-60','Cali','Colombia'),
('Proveedor D','Sofía Gómez','sofia@provd.com','3004445555','Cll 40 #60-70','Barranquilla','Colombia'),
('Proveedor E','Miguel Torres','miguel@prove.com','3005556666','Cll 50 #70-80','Cartagena','Colombia'),
('Proveedor F','Laura Pérez','laura@provf.com','3006667777','Cll 60 #80-90','Pereira','Colombia'),
('Proveedor G','Carlos Rojas','carlosr@provg.com','3007778888','Cll 70 #90-100','Bucaramanga','Colombia'),
('Proveedor H','Mariana Niño','mariana@provh.com','3008889999','Cll 80 #100-110','Manizales','Colombia'),
('Proveedor I','Diego León','diego@provi.com','3009990000','Cll 90 #110-120','Cúcuta','Colombia'),
('Proveedor J','Isabela Ruiz','isabela@provj.com','3001010101','Cll 100 #120-130','Neiva','Colombia');

-- m�todos de pago adicionales
INSERT INTO method_payment(name,description) VALUES
('Transferencia','Pago por transferencia bancaria'),
('PSE','Pago electronico'),
('Vale','Voucher'),
('Crédito','Pago a crédito'),
('Débito','Pago con débito'),
('Cheque','Pago con cheque'),
('Pago móvil','Wallet móvil'),
('Otro','Método alternativo');

-- clientes adicionales
INSERT INTO customer(person_id,loyalty_points)
SELECT id,0 FROM person ORDER BY created_at OFFSET 1 LIMIT 9;

-- �rdenes adicionales con �tems simples
INSERT INTO "order"(customer_id,total_amount,notes)
SELECT id,10.00,'Orden extra ' || ROW_NUMBER() OVER() FROM customer ORDER BY created_at OFFSET 0 LIMIT 9;

INSERT INTO order_item(order_id,product_id,quantity,unit_price,subtotal)
SELECT o.id,p.id,1,p.price,p.price
FROM order o
CROSS JOIN LATERAL (SELECT id,price FROM product ORDER BY created_at LIMIT 1 OFFSET ((ROW_NUMBER() OVER (ORDER BY o.id)-1) % 10)) p
LIMIT 9;

-- facturas y pagos adicionales
INSERT INTO invoice(order_id,invoice_number,total_amount,tax_amount)
SELECT id,'INV' || LPAD((ROW_NUMBER() OVER())::text,4,'0'),total_amount,0.10*total_amount
FROM "order" ORDER BY created_at OFFSET 1 LIMIT 9;

INSERT INTO invoice_item(invoice_id,product_id,quantity,unit_price,subtotal)
SELECT i.id,p.id,1,p.price,p.price
FROM invoice i
CROSS JOIN LATERAL (SELECT id,price FROM product ORDER BY created_at LIMIT 1 OFFSET ((ROW_NUMBER() OVER (ORDER BY i.id)-1) % 10)) p
LIMIT 9;

INSERT INTO payment(invoice_id,method_payment_id,amount,reference_number)
SELECT i.id,(SELECT id FROM method_payment ORDER BY created_at LIMIT 1 OFFSET ((ROW_NUMBER() OVER (ORDER BY i.id)-1) % 10)),
       i.total_amount,'PAY' || LPAD((ROW_NUMBER() OVER())::text,3,'0')
FROM invoice i ORDER BY created_at OFFSET 1 LIMIT 9;

-- inventario para 10 productos
INSERT INTO inventory(product_id,quantity_available,quantity_reserved,reorder_level)
SELECT id,100,0,10 FROM product ORDER BY created_at LIMIT 10;

-- archivos dummy
INSERT INTO file(name,path,file_type,size)
SELECT 'file' || g || '.txt','/files/file' || g || '.txt','text/plain',1024 FROM generate_series(1,10) g;

-- tablas de seguridad: roles, m�dulos, vistas, usuarios
INSERT INTO role(name,description) VALUES
('Admin','Administrador'),
('Empleado','Empleado'),
('Cliente','Cliente'),
('Proveedor','Proveedor'),
('Contador','Contabilidad'),
('Gerente','Gerencia'),
('Invitado','Invitado'),
('Soporte','Soporte'),
('Ventas','Ventas'),
('Marketing','Marketing');

INSERT INTO module(name,description) VALUES
('Seguridad','Gestion de seguridad'),
('Inventario','Gestion de inventario'),
('Ventas','MModulo de ventas'),
('Facturacion','Gestion de facturas'),
('Reportes','Generacion de reportes'),
('Configuracion','Ajustes'),
('Usuarios','Gestion de usuarios'),
('Productos','Administracion de productos'),
('Clientes','Gestion de clientes'),
('Proveedores','Gestion de proveedores');

INSERT INTO view(name,description,url) VALUES
('Dashboard','Vista principal','/dashboard'),
('Productos','Listado de productos','/products'),
('Clientes','Listado de clientes','/clients'),
('Ordenes','Listado de ordenes','/orders'),
('Facturas','Listado de facturas','/invoices'),
('Reportes','Vista de reportes','/reports'),
('Usuarios','Vista de usuarios','/users'),
('Roles','Vista de roles','/roles'),
('Configuracion','Vista de configuracion','/settings'),
('Ayuda','Pagina de ayuda','/help');

INSERT INTO "user"(person_id,username,password) 
SELECT p.id,'user' || ROW_NUMBER() OVER(), 'pass' || ROW_NUMBER() OVER()
FROM person p ORDER BY created_at LIMIT 10;

-- relaciones 10 registros cada una
INSERT INTO user_role(user_id,role_id)
SELECT u.id,r.id
FROM (SELECT id,ROW_NUMBER() OVER() rn FROM user ORDER BY created_at LIMIT 10) u
JOIN (SELECT id,ROW_NUMBER() OVER() rn FROM role ORDER BY created_at LIMIT 10) r ON u.rn = r.rn;

INSERT INTO role_module(role_id,module_id)
SELECT r.id,m.id
FROM (SELECT id,ROW_NUMBER() OVER() rn FROM role ORDER BY created_at LIMIT 10) r
JOIN (SELECT id,ROW_NUMBER() OVER() rn FROM module ORDER BY created_at LIMIT 10) m ON r.rn = m.rn;

INSERT INTO module_view(module_id,view_id)
SELECT m.id,v.id
FROM (SELECT id,ROW_NUMBER() OVER() rn FROM module ORDER BY created_at LIMIT 10) m
JOIN (SELECT id,ROW_NUMBER() OVER() rn FROM view ORDER BY created_at LIMIT 10) v ON m.rn = v.rn;

SELECT * FROM category;
SELECT * FROM customer;
SELECT * FROM file;
SELECT * FROM inventory;
SELECT * FROM invoice;
SELECT * FROM method_payment;