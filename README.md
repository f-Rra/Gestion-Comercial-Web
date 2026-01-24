<div align="center">
  <img src="header.png" alt="SGC-Web Header">
</div>

---

Evolución web del Sistema de Gestión Comercial original, con interfaz moderna y lógica de negocio robusta.

---

![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.8.1-blue)
![C#](https://img.shields.io/badge/C%23-7.3-green)
![ASP.NET WebForms](https://img.shields.io/badge/Framework-ASP.NET%20WebForms-lightblue)
![SQL Server](https://img.shields.io/badge/SQL%20Server-2016+-red)
![Bootstrap 5](https://img.shields.io/badge/UI-Bootstrap%205-purple)

## Descripción

**SGC-Web** es la evolución web del Sistema de Gestión Comercial original desarrollado en Windows Forms. Este proyecto representa una **migración arquitectónica completa** hacia tecnología web, reutilizando las capas de Dominio y Negocio del sistema original, mientras se desarrolla una nueva capa de presentación web moderna y responsiva.

La plataforma permite administrar inventarios, procesar ventas y generar reportes operativos desde cualquier dispositivo con navegador web, manteniendo la misma integridad transaccional y seguridad del sistema original.

---

## Características Principales

### Migración Tecnológica
- **Reutilización de código**: Capas de Dominio y Negocio del sistema WinForms original
- **Nueva capa de presentación**: Desarrollo desde cero con ASP.NET WebForms
- **Misma base de datos**: Aprovechamiento de procedimientos almacenados, triggers y lógica SQL existente
- **Adaptación de estado**: Migración de gestión de estado desktop a Session/ViewState web

### Arquitectura
- **Patrón de 3 capas**: Separación clara entre Presentación, Negocio y Acceso a Datos
- **Master Pages**: Diseño consistente en toda la aplicación
- **Gestión de recursos**: Implementación de `IDisposable` para conexiones y comandos SQL
- **Mappers**: Conversión eficiente de `SqlDataReader` a objetos de dominio

### Seguridad y Autenticación
- **Forms Authentication**: Sistema de login con roles diferenciados (Admin/Vendedor)
- **Protección SQL Injection**: Consultas parametrizadas en toda la aplicación
- **Autorización por rol**: Restricción de acceso a módulos según permisos
- **Validaciones en múltiples capas**: Cliente, servidor y base de datos

### Gestión de Datos
- **Stored Procedures**: 100% de operaciones CRUD delegadas a la base de datos
- **Triggers automáticos**: Control de stock en tiempo real tras cada venta
- **Transacciones atómicas**: Uso de `SqlTransaction` para garantizar consistencia
- **Integridad referencial**: Baja lógica para preservar historial de operaciones

### Interfaz de Usuario
- **Diseño responsivo**: Bootstrap 5 para adaptación móvil y desktop
- **Experiencia fluida**: Navegación optimizada y feedback visual inmediato
- **Accesibilidad**: Controles intuitivos y mensajes de error descriptivos
- **Iconografía moderna**: Integración de Font Awesome

---

## Módulos del Sistema

### Gestión de Catálogo
- Listado completo de artículos con imágenes
- Filtros dinámicos por descripción, marca, categoría y precio
- Operaciones ABML completas (Alta, Baja, Modificación, Lectura)
- Vista detallada de productos con información técnica

### Gestión de Marcas y Categorías
- Administración de clasificadores de productos
- Sistema de validaciones para evitar duplicados
- Baja lógica para mantener integridad histórica
- Interfaz simplificada para alta velocidad de operación

### Control de Stock
- Ajustes manuales de inventario con validaciones
- Historial de movimientos de stock
- Alertas de stock bajo
- Reportes de existencias por categoría/marca

### Sistema de Ventas
- Carrito de compras persistente en sesión
- Actualización dinámica de cantidades
- Validación de stock en tiempo real
- Confirmación de venta con descuento automático de inventario
- Generación de comprobantes

### Reportes y Estadísticas
- Dashboard con métricas operativas
- Análisis de participación por marca y categoría
- Reportes de inventario valorizado
- Exportación de datos para análisis externo

---

## Estructura del Proyecto

```
Gestion-Comercial-Web/
├── Dominio/                    # Entidades de negocio (POCO)
│   ├── Articulo.cs
│   ├── Categoria.cs
│   ├── Marca.cs
│   ├── Usuario.cs
│   └── Venta.cs
│
├── Negocio/                    # Lógica de negocio y acceso a datos
│   ├── AccesoDatos.cs             # Gestión centralizada de BD
│   ├── ArticuloNegocio.cs
│   ├── CategoriaNegocio.cs
│   ├── MarcaNegocio.cs
│   ├── UsuarioNegocio.cs
│   ├── VentaNegocio.cs
│   └── Mappers/                # Conversión DataReader → Objetos
│       ├── ArticuloMapper.cs
│       └── VentaMapper.cs
│
├── Pages/                      # Capa de presentación web
│   ├── Admin/                  # Módulo administrativo
│   │   ├── Categorias.aspx
│   │   └── Marcas.aspx
│   ├── Articulos/              # Gestión de productos
│   │   ├── Lista.aspx
│   │   ├── Detalle.aspx
│   │   └── FormularioArticulo.aspx
│   ├── Stock/                  # Control de inventario
│   │   └── GestionStock.aspx
│   ├── Ventas/                 # Proceso de venta
│   │   ├── Carrito.aspx
│   │   └── ConfirmacionVenta.aspx
│   └── Reportes/               # Estadísticas
│       └── Dashboard.aspx
│
├── Content/                    # Recursos estáticos
│   ├── bootstrap.min.css
│   ├── Site.css                   # Estilos personalizados
│   └── images/
│
├── Scripts/                    # JavaScript/jQuery
│   ├── bootstrap.bundle.min.js
│   └── site.js
│
├── Site.Master                    # Plantilla maestra
├── Site.Master.cs
├── Login.aspx                     # Página de autenticación
├── Default.aspx                   # Página de inicio
└── Web.config                     # Configuración de la aplicación
```

---

## Tecnologías Utilizadas

### Backend
- **.NET Framework 4.8.1** - Plataforma de desarrollo
- **C# 7.3** - Lenguaje de programación
- **ASP.NET WebForms** - Framework web
- **ADO.NET** - Acceso a datos

### Frontend
- **Bootstrap 5** - Framework CSS responsivo
- **JavaScript/jQuery** - Interactividad del cliente
- **Font Awesome** - Iconografía
- **CSS3** - Estilos personalizados

### Base de Datos
- **SQL Server 2016+** - Motor de base de datos
- **Stored Procedures** - Lógica de datos encapsulada
- **Triggers** - Automatización de procesos
- **Views** - Vistas optimizadas para reportes

### Herramientas de Desarrollo
- **Visual Studio 2022** - IDE principal
- **SQL Server Management Studio (SSMS)** - Administración de BD
- **Git & GitHub** - Control de versiones
- **IIS Express** - Servidor de desarrollo

---

## Decisiones de Diseño

### Migración de Windows Forms a Web

**Capas reutilizadas del sistema original:**
- ✅ Entidades de dominio (sin modificaciones)
- ✅ Lógica de negocio (adaptaciones menores para web)
- ✅ Stored Procedures y Triggers SQL
- ✅ Estructura de base de datos

**Desarrollos nuevos para la versión web:**
- 🆕 Capa de presentación completa en ASP.NET WebForms
- 🆕 Gestión de estado con Session y ViewState
- 🆕 Interfaz responsiva con Bootstrap 5
- 🆕 Sistema de navegación web con Master Pages
- 🆕 Validaciones del lado del cliente con JavaScript

---

## Asistencia de IA en el Desarrollo

Este proyecto fue desarrollado con asistencia de herramientas de **IA Generativa** (GitHub Copilot y Claude AI), aplicadas específicamente en:

- Diseño Frontend: Maquetación responsiva y selección de paleta de colores moderna
- Refactorización: Sugerencias de optimización y mejores prácticas de código
- Debugging: Identificación de problemas y propuestas de solución
- Documentación: Estructuración y redacción técnica de este README

> **Nota**: La lógica de negocio, arquitectura y decisiones de diseño fueron desarrolladas íntegramente por el autor, utilizando IA como herramienta de soporte y aceleración del desarrollo.

---

## Autor

**Facundo Herrera**
- Estudiante de Tecnicatura Universitaria en Programación
- Universidad Tecnológica Nacional - Facultad Regional General Pacheco (UTN-FRGP)
- Email: Facundo.herrera@alumnos.frgp.utn.edu.ar

---
