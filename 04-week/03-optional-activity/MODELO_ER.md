# 📊 Modelo Entidad-Relación (ER) - Coffee-Shop Cafetería

## 📋 Resumen General
Base de datos completa para gestionar operaciones de cafetería con **5 módulos principales** y **24 tablas** integradas.

---

## 🔐 MÓDULO 1: SEGURIDAD

### Tablas
| Tabla | Propósito | Campos Clave |
|-------|----------|------|
| **user** | Usuarios del sistema | `id, person_id, username, password` |
| **role** | Roles/perfiles de acceso | `id, name, description` |
| **module** | Módulos funcionales | `id, name, description` |
| **view** | Vistas/pantallas | `id, name, url, description` |
| **user_role** | Asignación usuario-rol (M:N) | `user_id, role_id` |
| **role_module** | Acceso rol-módulo (M:N) | `role_id, module_id` |
| **module_view** | Vistas por módulo (M:N) | `module_id, view_id` |

### Relaciones
```
PERSON → USER → USER_ROLE ← ROLE → ROLE_MODULE ← MODULE → MODULE_VIEW ← VIEW
```

---

## 🏢 MÓDULO 2: PARÁMETROS

### Tablas
| Tabla | Propósito | Campos Clave |
|-------|----------|------|
| **type_document** | Tipos de documento | `id, name, code` |
| **person** | Personas del sistema | `id, first_name, last_name, document_type_id, email, phone` |
| **file** | Gestión de archivos | `id, name, path, file_type, size` |

### Relaciones
```
TYPE_DOCUMENT (1) → (M) PERSON
PERSON (1) → (M) USER
PERSON (1) → (M) CUSTOMER
```

---

## 📦 MÓDULO 3: INVENTARIO

### Tablas
| Tabla | Propósito | Campos Clave |
|-------|----------|------|
| **category** | Categorías de productos | `id, name, description` |
| **supplier** | Proveedores | `id, name, contact_person, email, phone, address, city, country` |
| **product** | Productos | `id, name, category_id, supplier_id, price, cost, sku` |
| **inventory** | Stock de productos | `product_id, quantity_available, quantity_reserved, reorder_level` |

### Relaciones
```
CATEGORY (1) → (M) PRODUCT ← (M) SUPPLIER
PRODUCT (1) → (M) INVENTORY
```

---

## 🛒 MÓDULO 4: VENTAS

### Tablas
| Tabla | Propósito | Campos Clave |
|-------|----------|------|
| **customer** | Clientes | `id, person_id, loyalty_points` |
| **order** | Órdenes de compra | `id, customer_id, order_date, total_amount, notes` |
| **order_item** | Ítems por orden (detalle) | `order_id, product_id, quantity, unit_price, subtotal` |
| **method_payment** | Métodos de pago | `id, name, description` |

### Relaciones
```
CUSTOMER (1) → (M) ORDER → (M) ORDER_ITEM ← (M) PRODUCT
```

---

## 💳 MÓDULO 5: FACTURACIÓN

### Tablas
| Tabla | Propósito | Campos Clave |
|-------|----------|------|
| **invoice** | Facturas | `id, order_id, invoice_number, invoice_date, total_amount, tax_amount` |
| **invoice_item** | Ítems de factura | `invoice_id, product_id, quantity, unit_price, subtotal` |
| **payment** | Pagos registrados | `id, invoice_id, method_payment_id, amount, payment_date, reference_number` |

### Relaciones
```
ORDER (1) → (M) INVOICE → (M) INVOICE_ITEM ← (M) PRODUCT
INVOICE (1) → (M) PAYMENT ← (M) METHOD_PAYMENT
```

---

## 🔗 Matriz de Relaciones

| Tabla A | Relación | Tabla B | Cardinalidad |
|---------|----------|---------|--------------|
| type_document | clasifica | person | 1:M |
| person | es | user | 1:M |
| person | es | customer | 1:M |
| user | asigna | user_role | 1:M |
| role | accede | role_module | 1:M |
| role | asigna | user_role | 1:M |
| module | muestra | module_view | 1:M |
| view | disponible | module_view | 1:M |
| category | agrupa | product | 1:M |
| supplier | suministra | product | 1:M |
| product | tiene | inventory | 1:1 |
| product | incluye | order_item | 1:M |
| product | detalla | invoice_item | 1:M |
| customer | realiza | order | 1:M |
| order | contiene | order_item | 1:M |
| order | genera | invoice | 1:M |
| invoice | contiene | invoice_item | 1:M |
| invoice | registra | payment | 1:M |
| method_payment | procesa | payment | 1:M |

---

## 📊 Estadísticas del Modelo

| Concepto | Cantidad |
|----------|----------|
| **Tablas Totales** | 24 |
| **Tablas de Negocio** | 17 |
| **Tablas de Relación (M:N)** | 3 |
| **Tablas de Parámetro** | 4 |
| **Módulos** | 5 |
| **Relaciones Foráneas** | 19 |
| **Campos Únicos (UK)** | 14 |

---

## 🎯 Flujo de Datos Principal

```
1. SEGURIDAD
   PERSON → USER + CUSTOMER
   USER → USER_ROLE → ROLE → ROLE_MODULE → MODULE → MODULE_VIEW → VIEW

2. INVENTARIO
   CATEGORY + SUPPLIER → PRODUCT → INVENTORY

3. VENTAS
   CUSTOMER → ORDER → ORDER_ITEM → PRODUCT

4. FACTURACIÓN
   ORDER → INVOICE → INVOICE_ITEM + PAYMENT
   PAYMENT → METHOD_PAYMENT
```

---

## 💡 Características Principales

✅ **Control de Acceso Granular**: Roles, módulos y vistas  
✅ **Trazabilidad Completa**: created_at, updated_at, deleted_at, created_by, updated_by, deleted_by  
✅ **Gestión de Inventario**: Stock disponible y reservado  
✅ **Ciclo Completo de Ventas**: Orden → Factura → Pago  
✅ **Soporte Multi-Proveedor**: Cada producto puede tener un proveedor  
✅ **Programa de Lealtad**: Puntos por cliente  
✅ **Auditoría**: Soft delete y tracking de cambios  

---

## 🗄️ Tipos de Datos Utilizados

| Tipo | Uso |
|------|-----|
| **UUID** | Claves primarias (todas las tablas) |
| **VARCHAR** | Textos cortos (nombres, códigos, etc.) |
| **TEXT** | Descripciones largas |
| **DECIMAL(10,2)** | Precios, montos, impuestos |
| **INT** | Cantidades, puntos |
| **BIGINT** | Tamaño de archivos |
| **TIMESTAMPTZ** | Fechas y timestamps con zona horaria |
| **BOOLEAN** | Estado activo/inactivo |

---

## 📝 Nota sobre Datos de Muestra

El archivo `cafetin.sql` incluye **10 registros por tabla** para:
- ✅ 10 tipos de documento
- ✅ 10 personas
- ✅ 10 categorías
- ✅ 10 proveedores
- ✅ 10 productos
- ✅ 10 métodos de pago
- ✅ 10 clientes
- ✅ 10 órdenes
- ✅ 10 facturas
- ✅ 10 pagos
- ✅ 10 roles, módulos y vistas
- ✅ 10 usuarios y sus asignaciones de rol

Estos datos permiten realizar pruebas realistas del sistema sin necesidad de insertar datos manualmente.

---

*Generado: 2026-03-04 | Versión 1.0*
