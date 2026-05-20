# Estructura MVC - Backend de Horarios

## Descripción
Modelol-View-Controller clásico. El modelo contiene las entidades logicas de negocio, la Vista son las respuestas JSON (o vistas HTML si aplica), y el Controlador maneja peticiones HTTP.

## Ventajas
- Senciollo y ampliamente conocido
- Rápido de implementar
- Bueno para APIs REST simples o prototipos

## Desventajas 
- Escalabilidad limitada
- Mezcla de esponsabilidades en controladores grandes
- No ideal para backend complejo con múltiples dominios

## Estructura de Carpetas

```text
Proyecto/
│
├── Model/
│   ├── Security/
│   └── Inventory/
│
├── View/
│   └── (Interfaces o respuesta JSON)
│
└── Controller/
    ├── Security/
    └── Inventory/