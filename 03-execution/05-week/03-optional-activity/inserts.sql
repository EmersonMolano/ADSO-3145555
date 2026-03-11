--================================= TRUNCATE ==================================
TRUNCATE TABLE category, customer, "file", inventory, invoice, invoice_item, method_payment, "module", module_view, "order", order_item, payment, person, product, "role", role_module, supplier, type_document, "view" CASCADE;

-- ==================== SAMPLE DATA (10 registros simples) ====================

INSERT INTO type_document (name, code) VALUES
('Tipo 1', 'T1'), ('Tipo 2', 'T2'), ('Tipo 3', 'T3'), ('Tipo 4', 'T4'), ('Tipo 5', 'T5'),
('Tipo 6', 'T6'), ('Tipo 7', 'T7'), ('Tipo 8', 'T8'), ('Tipo 9', 'T9'), ('Tipo 10', 'T10');

INSERT INTO person (first_name, last_name, document_type_id, document_number, email, phone) VALUES
('Persona 1', 'Apellido 1', (SELECT id FROM type_document WHERE code='T1'), '10000001', 'p1@email.com', '3000000001'),
('Persona 2', 'Apellido 2', (SELECT id FROM type_document WHERE code='T2'), '10000002', 'p2@email.com', '3000000002'),
('Persona 3', 'Apellido 3', (SELECT id FROM type_document WHERE code='T3'), '10000003', 'p3@email.com', '3000000003'),
('Persona 4', 'Apellido 4', (SELECT id FROM type_document WHERE code='T4'), '10000004', 'p4@email.com', '3000000004'),
('Persona 5', 'Apellido 5', (SELECT id FROM type_document WHERE code='T5'), '10000005', 'p5@email.com', '3000000005'),
('Persona 6', 'Apellido 6', (SELECT id FROM type_document WHERE code='T6'), '10000006', 'p6@email.com', '3000000006'),
('Persona 7', 'Apellido 7', (SELECT id FROM type_document WHERE code='T7'), '10000007', 'p7@email.com', '3000000007'),
('Persona 8', 'Apellido 8', (SELECT id FROM type_document WHERE code='T8'), '10000008', 'p8@email.com', '3000000008'),
('Persona 9', 'Apellido 9', (SELECT id FROM type_document WHERE code='T9'), '10000009', 'p9@email.com', '3000000009'),
('Persona 10', 'Apellido 10', (SELECT id FROM type_document WHERE code='T10'), '10000010', 'p10@email.com', '3000000010');

INSERT INTO category (name, description) VALUES
('Categoria 1', 'Desc 1'), ('Categoria 2', 'Desc 2'), ('Categoria 3', 'Desc 3'), ('Categoria 4', 'Desc 4'), ('Categoria 5', 'Desc 5'),
('Categoria 6', 'Desc 6'), ('Categoria 7', 'Desc 7'), ('Categoria 8', 'Desc 8'), ('Categoria 9', 'Desc 9'), ('Categoria 10', 'Desc 10');

INSERT INTO supplier (name, contact_person, email, phone, address, city, country) VALUES
('Proveedor 1', 'Contacto 1', 'prov1@email.com', '3010000001', 'Dir 1', 'Ciudad 1', 'Pais 1'),
('Proveedor 2', 'Contacto 2', 'prov2@email.com', '3010000002', 'Dir 2', 'Ciudad 2', 'Pais 2'),
('Proveedor 3', 'Contacto 3', 'prov3@email.com', '3010000003', 'Dir 3', 'Ciudad 3', 'Pais 3'),
('Proveedor 4', 'Contacto 4', 'prov4@email.com', '3010000004', 'Dir 4', 'Ciudad 4', 'Pais 4'),
('Proveedor 5', 'Contacto 5', 'prov5@email.com', '3010000005', 'Dir 5', 'Ciudad 5', 'Pais 5'),
('Proveedor 6', 'Contacto 6', 'prov6@email.com', '3010000006', 'Dir 6', 'Ciudad 6', 'Pais 6'),
('Proveedor 7', 'Contacto 7', 'prov7@email.com', '3010000007', 'Dir 7', 'Ciudad 7', 'Pais 7'),
('Proveedor 8', 'Contacto 8', 'prov8@email.com', '3010000008', 'Dir 8', 'Ciudad 8', 'Pais 8'),
('Proveedor 9', 'Contacto 9', 'prov9@email.com', '3010000009', 'Dir 9', 'Ciudad 9', 'Pais 9'),
('Proveedor 10', 'Contacto 10', 'prov10@email.com', '3010000010', 'Dir 10', 'Ciudad 10', 'Pais 10');

INSERT INTO product (name, category_id, supplier_id, description, price, cost, sku) VALUES
('Producto 1', (SELECT id FROM category WHERE name='Categoria 1'), (SELECT id FROM supplier WHERE name='Proveedor 1'), 'Desc 1', 10.00, 5.00, 'SKU001'),
('Producto 2', (SELECT id FROM category WHERE name='Categoria 2'), (SELECT id FROM supplier WHERE name='Proveedor 2'), 'Desc 2', 20.00, 10.00, 'SKU002'),
('Producto 3', (SELECT id FROM category WHERE name='Categoria 3'), (SELECT id FROM supplier WHERE name='Proveedor 3'), 'Desc 3', 30.00, 15.00, 'SKU003'),
('Producto 4', (SELECT id FROM category WHERE name='Categoria 4'), (SELECT id FROM supplier WHERE name='Proveedor 4'), 'Desc 4', 40.00, 20.00, 'SKU004'),
('Producto 5', (SELECT id FROM category WHERE name='Categoria 5'), (SELECT id FROM supplier WHERE name='Proveedor 5'), 'Desc 5', 50.00, 25.00, 'SKU005'),
('Producto 6', (SELECT id FROM category WHERE name='Categoria 6'), (SELECT id FROM supplier WHERE name='Proveedor 6'), 'Desc 6', 60.00, 30.00, 'SKU006'),
('Producto 7', (SELECT id FROM category WHERE name='Categoria 7'), (SELECT id FROM supplier WHERE name='Proveedor 7'), 'Desc 7', 70.00, 35.00, 'SKU007'),
('Producto 8', (SELECT id FROM category WHERE name='Categoria 8'), (SELECT id FROM supplier WHERE name='Proveedor 8'), 'Desc 8', 80.00, 40.00, 'SKU008'),
('Producto 9', (SELECT id FROM category WHERE name='Categoria 9'), (SELECT id FROM supplier WHERE name='Proveedor 9'), 'Desc 9', 90.00, 45.00, 'SKU009'),
('Producto 10', (SELECT id FROM category WHERE name='Categoria 10'), (SELECT id FROM supplier WHERE name='Proveedor 10'), 'Desc 10', 100.00, 50.00, 'SKU010');

INSERT INTO inventory (product_id, quantity_available, quantity_reserved, reorder_level) VALUES
((SELECT id FROM product WHERE sku='SKU001'), 100, 0, 10),
((SELECT id FROM product WHERE sku='SKU002'), 200, 0, 20),
((SELECT id FROM product WHERE sku='SKU003'), 300, 0, 30),
((SELECT id FROM product WHERE sku='SKU004'), 400, 0, 40),
((SELECT id FROM product WHERE sku='SKU005'), 500, 0, 50),
((SELECT id FROM product WHERE sku='SKU006'), 600, 0, 60),
((SELECT id FROM product WHERE sku='SKU007'), 700, 0, 70),
((SELECT id FROM product WHERE sku='SKU008'), 800, 0, 80),
((SELECT id FROM product WHERE sku='SKU009'), 900, 0, 90),
((SELECT id FROM product WHERE sku='SKU010'), 1000, 0, 100);

INSERT INTO customer (person_id, loyalty_points) VALUES
((SELECT id FROM person WHERE document_number='10000001'), 10),
((SELECT id FROM person WHERE document_number='10000002'), 20),
((SELECT id FROM person WHERE document_number='10000003'), 30),
((SELECT id FROM person WHERE document_number='10000004'), 40),
((SELECT id FROM person WHERE document_number='10000005'), 50),
((SELECT id FROM person WHERE document_number='10000006'), 60),
((SELECT id FROM person WHERE document_number='10000007'), 70),
((SELECT id FROM person WHERE document_number='10000008'), 80),
((SELECT id FROM person WHERE document_number='10000009'), 90),
((SELECT id FROM person WHERE document_number='10000010'), 100);

INSERT INTO method_payment (name, description) VALUES
('Metodo 1', 'Desc 1'), ('Metodo 2', 'Desc 2'), ('Metodo 3', 'Desc 3'), ('Metodo 4', 'Desc 4'), ('Metodo 5', 'Desc 5'),
('Metodo 6', 'Desc 6'), ('Metodo 7', 'Desc 7'), ('Metodo 8', 'Desc 8'), ('Metodo 9', 'Desc 9'), ('Metodo 10', 'Desc 10');

INSERT INTO "order" (customer_id, total_amount, notes) VALUES
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000001')), 100.00, 'Nota 1'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000002')), 200.00, 'Nota 2'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000003')), 300.00, 'Nota 3'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000004')), 400.00, 'Nota 4'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000005')), 500.00, 'Nota 5'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000006')), 600.00, 'Nota 6'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000007')), 700.00, 'Nota 7'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000008')), 800.00, 'Nota 8'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000009')), 900.00, 'Nota 9'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10000010')), 1000.00, 'Nota 10');

INSERT INTO order_item (order_id, product_id, quantity, unit_price, subtotal) VALUES
((SELECT id FROM "order" WHERE notes='Nota 1'), (SELECT id FROM product WHERE sku='SKU001'), 1, 10.00, 10.00),
((SELECT id FROM "order" WHERE notes='Nota 2'), (SELECT id FROM product WHERE sku='SKU002'), 2, 20.00, 40.00),
((SELECT id FROM "order" WHERE notes='Nota 3'), (SELECT id FROM product WHERE sku='SKU003'), 3, 30.00, 90.00),
((SELECT id FROM "order" WHERE notes='Nota 4'), (SELECT id FROM product WHERE sku='SKU004'), 4, 40.00, 160.00),
((SELECT id FROM "order" WHERE notes='Nota 5'), (SELECT id FROM product WHERE sku='SKU005'), 5, 50.00, 250.00),
((SELECT id FROM "order" WHERE notes='Nota 6'), (SELECT id FROM product WHERE sku='SKU006'), 6, 60.00, 360.00),
((SELECT id FROM "order" WHERE notes='Nota 7'), (SELECT id FROM product WHERE sku='SKU007'), 7, 70.00, 490.00),
((SELECT id FROM "order" WHERE notes='Nota 8'), (SELECT id FROM product WHERE sku='SKU008'), 8, 80.00, 640.00),
((SELECT id FROM "order" WHERE notes='Nota 9'), (SELECT id FROM product WHERE sku='SKU009'), 9, 90.00, 810.00),
((SELECT id FROM "order" WHERE notes='Nota 10'), (SELECT id FROM product WHERE sku='SKU010'), 10, 100.00, 1000.00);

INSERT INTO invoice (order_id, invoice_number, total_amount, tax_amount) VALUES
((SELECT id FROM "order" WHERE notes='Nota 1'), 'INV001', 100.00, 10.00),
((SELECT id FROM "order" WHERE notes='Nota 2'), 'INV002', 200.00, 20.00),
((SELECT id FROM "order" WHERE notes='Nota 3'), 'INV003', 300.00, 30.00),
((SELECT id FROM "order" WHERE notes='Nota 4'), 'INV004', 400.00, 40.00),
((SELECT id FROM "order" WHERE notes='Nota 5'), 'INV005', 500.00, 50.00),
((SELECT id FROM "order" WHERE notes='Nota 6'), 'INV006', 600.00, 60.00),
((SELECT id FROM "order" WHERE notes='Nota 7'), 'INV007', 700.00, 70.00),
((SELECT id FROM "order" WHERE notes='Nota 8'), 'INV008', 800.00, 80.00),
((SELECT id FROM "order" WHERE notes='Nota 9'), 'INV009', 900.00, 90.00),
((SELECT id FROM "order" WHERE notes='Nota 10'), 'INV010', 1000.00, 100.00);

INSERT INTO invoice_item (invoice_id, product_id, quantity, unit_price, subtotal) VALUES
((SELECT id FROM invoice WHERE invoice_number='INV001'), (SELECT id FROM product WHERE sku='SKU001'), 1, 10.00, 10.00),
((SELECT id FROM invoice WHERE invoice_number='INV002'), (SELECT id FROM product WHERE sku='SKU002'), 2, 20.00, 40.00),
((SELECT id FROM invoice WHERE invoice_number='INV003'), (SELECT id FROM product WHERE sku='SKU003'), 3, 30.00, 90.00),
((SELECT id FROM invoice WHERE invoice_number='INV004'), (SELECT id FROM product WHERE sku='SKU004'), 4, 40.00, 160.00),
((SELECT id FROM invoice WHERE invoice_number='INV005'), (SELECT id FROM product WHERE sku='SKU005'), 5, 50.00, 250.00),
((SELECT id FROM invoice WHERE invoice_number='INV006'), (SELECT id FROM product WHERE sku='SKU006'), 6, 60.00, 360.00),
((SELECT id FROM invoice WHERE invoice_number='INV007'), (SELECT id FROM product WHERE sku='SKU007'), 7, 70.00, 490.00),
((SELECT id FROM invoice WHERE invoice_number='INV008'), (SELECT id FROM product WHERE sku='SKU008'), 8, 80.00, 640.00),
((SELECT id FROM invoice WHERE invoice_number='INV009'), (SELECT id FROM product WHERE sku='SKU009'), 9, 90.00, 810.00),
((SELECT id FROM invoice WHERE invoice_number='INV010'), (SELECT id FROM product WHERE sku='SKU010'), 10, 100.00, 1000.00);

INSERT INTO payment (invoice_id, method_payment_id, amount, reference_number) VALUES
((SELECT id FROM invoice WHERE invoice_number='INV001'), (SELECT id FROM method_payment WHERE name='Metodo 1'), 100.00, 'REF001'),
((SELECT id FROM invoice WHERE invoice_number='INV002'), (SELECT id FROM method_payment WHERE name='Metodo 2'), 200.00, 'REF002'),
((SELECT id FROM invoice WHERE invoice_number='INV003'), (SELECT id FROM method_payment WHERE name='Metodo 3'), 300.00, 'REF003'),
((SELECT id FROM invoice WHERE invoice_number='INV004'), (SELECT id FROM method_payment WHERE name='Metodo 4'), 400.00, 'REF004'),
((SELECT id FROM invoice WHERE invoice_number='INV005'), (SELECT id FROM method_payment WHERE name='Metodo 5'), 500.00, 'REF005'),
((SELECT id FROM invoice WHERE invoice_number='INV006'), (SELECT id FROM method_payment WHERE name='Metodo 6'), 600.00, 'REF006'),
((SELECT id FROM invoice WHERE invoice_number='INV007'), (SELECT id FROM method_payment WHERE name='Metodo 7'), 700.00, 'REF007'),
((SELECT id FROM invoice WHERE invoice_number='INV008'), (SELECT id FROM method_payment WHERE name='Metodo 8'), 800.00, 'REF008'),
((SELECT id FROM invoice WHERE invoice_number='INV009'), (SELECT id FROM method_payment WHERE name='Metodo 9'), 900.00, 'REF009'),
((SELECT id FROM invoice WHERE invoice_number='INV010'), (SELECT id FROM method_payment WHERE name='Metodo 10'), 1000.00, 'REF010');

INSERT INTO role (name, description) VALUES
('Rol 1', 'Desc 1'), ('Rol 2', 'Desc 2'), ('Rol 3', 'Desc 3'), ('Rol 4', 'Desc 4'), ('Rol 5', 'Desc 5'),
('Rol 6', 'Desc 6'), ('Rol 7', 'Desc 7'), ('Rol 8', 'Desc 8'), ('Rol 9', 'Desc 9'), ('Rol 10', 'Desc 10');

INSERT INTO module (name, description) VALUES
('Modulo 1', 'Desc 1'), ('Modulo 2', 'Desc 2'), ('Modulo 3', 'Desc 3'), ('Modulo 4', 'Desc 4'), ('Modulo 5', 'Desc 5'),
('Modulo 6', 'Desc 6'), ('Modulo 7', 'Desc 7'), ('Modulo 8', 'Desc 8'), ('Modulo 9', 'Desc 9'), ('Modulo 10', 'Desc 10');

INSERT INTO view (name, description, url) VALUES
('Vista 1', 'Desc 1', '/v1'), ('Vista 2', 'Desc 2', '/v2'), ('Vista 3', 'Desc 3', '/v3'), ('Vista 4', 'Desc 4', '/v4'), ('Vista 5', 'Desc 5', '/v5'),
('Vista 6', 'Desc 6', '/v6'), ('Vista 7', 'Desc 7', '/v7'), ('Vista 8', 'Desc 8', '/v8'), ('Vista 9', 'Desc 9', '/v9'), ('Vista 10', 'Desc 10', '/v10');

INSERT INTO role_module (role_id, module_id) VALUES
((SELECT id FROM role WHERE name='Rol 1'), (SELECT id FROM module WHERE name='Modulo 1')),
((SELECT id FROM role WHERE name='Rol 2'), (SELECT id FROM module WHERE name='Modulo 2')),
((SELECT id FROM role WHERE name='Rol 3'), (SELECT id FROM module WHERE name='Modulo 3')),
((SELECT id FROM role WHERE name='Rol 4'), (SELECT id FROM module WHERE name='Modulo 4')),
((SELECT id FROM role WHERE name='Rol 5'), (SELECT id FROM module WHERE name='Modulo 5')),
((SELECT id FROM role WHERE name='Rol 6'), (SELECT id FROM module WHERE name='Modulo 6')),
((SELECT id FROM role WHERE name='Rol 7'), (SELECT id FROM module WHERE name='Modulo 7')),
((SELECT id FROM role WHERE name='Rol 8'), (SELECT id FROM module WHERE name='Modulo 8')),
((SELECT id FROM role WHERE name='Rol 9'), (SELECT id FROM module WHERE name='Modulo 9')),
((SELECT id FROM role WHERE name='Rol 10'), (SELECT id FROM module WHERE name='Modulo 10'));

INSERT INTO module_view (module_id, view_id) VALUES
((SELECT id FROM module WHERE name='Modulo 1'), (SELECT id FROM view WHERE name='Vista 1')),
((SELECT id FROM module WHERE name='Modulo 2'), (SELECT id FROM view WHERE name='Vista 2')),
((SELECT id FROM module WHERE name='Modulo 3'), (SELECT id FROM view WHERE name='Vista 3')),
((SELECT id FROM module WHERE name='Modulo 4'), (SELECT id FROM view WHERE name='Vista 4')),
((SELECT id FROM module WHERE name='Modulo 5'), (SELECT id FROM view WHERE name='Vista 5')),
((SELECT id FROM module WHERE name='Modulo 6'), (SELECT id FROM view WHERE name='Vista 6')),
((SELECT id FROM module WHERE name='Modulo 7'), (SELECT id FROM view WHERE name='Vista 7')),
((SELECT id FROM module WHERE name='Modulo 8'), (SELECT id FROM view WHERE name='Vista 8')),
((SELECT id FROM module WHERE name='Modulo 9'), (SELECT id FROM view WHERE name='Vista 9')),
((SELECT id FROM module WHERE name='Modulo 10'), (SELECT id FROM view WHERE name='Vista 10'));

INSERT INTO file (name, path, file_type, size) VALUES
('Archivo 1', '/path1', 'type1', 100),
('Archivo 2', '/path2', 'type2', 200),
('Archivo 3', '/path3', 'type3', 300),
('Archivo 4', '/path4', 'type4', 400),
('Archivo 5', '/path5', 'type5', 500),
('Archivo 6', '/path6', 'type6', 600),
('Archivo 7', '/path7', 'type7', 700),
('Archivo 8', '/path8', 'type8', 800),
('Archivo 9', '/path9', 'type9', 900),
('Archivo 10', '/path10', 'type10', 1000);
