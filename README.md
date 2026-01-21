<div align="center">
  <h1>SGC-Web: Sistema de Gestión Comercial</h1>
  <p><i>Plataforma empresarial de alto rendimiento para el control de inventarios y gestión de ventas.</i></p>
</div>

---

**SGC-Web** es una solución integral diseñada para optimizar los procesos operativos de comercios y empresas. Desarrollada sobre el ecosistema de **ASP.NET**, la plataforma ofrece una experiencia robusta, segura y escalable, permitiendo la administración centralizada de stock, productos y transacciones comerciales desde cualquier dispositivo.

![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.8.1-blue)
![C#](https://img.shields.io/badge/C%23-7.3-green)
![ASP.NET WebForms](https://img.shields.io/badge/Framework-ASP.NET%20WebForms-lightblue)
![SQL Server](https://img.shields.io/badge/SQL%20Server-2016+-red)
![Bootstrap 5](https://img.shields.io/badge/UI-Bootstrap%205-purple)
![Maintenance](https://img.shields.io/badge/Maintained-Yes-brightgreen)

---

## ✨ Características Destacadas

- **Arquitectura de 3 Capas Profesional**: Separación estricta de responsabilidades entre la Capa de Presentación, Lógica de Negocio y Acceso a Datos.
- **Interfaz "Premium Unified"**: Diseño consistente basado en una Master Page, utilizando Bootstrap 5 para garantizar una experiencia 100% responsiva.
- **Seguridad de Grado Empresarial**: Implementación de **Forms Authentication** y protección contra SQL Injection mediante consultas parametrizadas.
- **Gestión de Estados Eficiente**: Aprovechamiento de `Session` para el carrito de compras y `ViewState` para la persistencia de datos en el cliente.
- **Persistencia Robusta**: Lógica de datos delegada en Stored Procedures y Triggers SQL para asegurar integridad y rendimiento.

---

## 🔐 Control de Acceso y Roles

El sistema implementa una matriz de permisos granular para asegurar la integridad de la operación:

| Funcionalidad | Vendedor | Administrador |
| :--- | :---: | :---: |
| Generación de Ventas | ✅ | ✅ |
| Consulta de Stock y Precios | ✅ | ✅ |
| Alta y Modificación de Artículos | ❌ | ✅ |
| Gestión de Marcas y Categorías | ❌ | ✅ |
| Ajustes de Inventario | ❌ | ✅ |
| Reportes Estadísticos y Auditoría | ❌ | ✅ |

---

## 🛠️ Módulos del Sistema

### 📦 Gestión de Catálogo y Stock
- **Control de Inventario**: Módulo especializado para ajustes manuales de stock con validaciones de disponibilidad.
- **Filtros Inteligentes**: Buscador dinámico por descripción, marca, categoría o rangos de precios.
- **Baja Lógica**: Sistema de estados para desactivar entidades sin romper la integridad referencial histórica.

### 🛒 Sistema de Ventas (Point of Sale)
- **Carrito de Compras Dinámico**: Gestión fluída de ítems en sesión con persistencia durante la navegación.
- **Transacciones Atómicas**: Registro seguro de venta y detalle utilizando `SqlTransaction` para garantizar que el descuento de stock y el registro ocurran simultáneamente.
- **Notificaciones**: Feedback visual inmediato ante falta de stock o confirmaciones de venta exitosas.

### 📊 Inteligencia de Negocio
- **Reportes de Inventario**: Vista detallada de existencias cargada mediante vistas SQL optimizadas (`vw_ArticulosCompletos`).
- **Dashboard Estadístico**: Análisis de participación por marcas y categorías para la toma de decisiones.

---

## 🏗️ Estructura del Proyecto

```
Gestion-Comercial-Web/
├── Dominio/                  # Capa de Entidades (Clases POCO)
│   ├── Articulo.cs
│   ├── Categoria.cs
│   ├── Marca.cs
│   └── Venta.cs
├── Negocio/                  # Capa de Lógica de Negocio y Acceso a Datos
│   ├── AccesoDatos.cs        # Gestión de conexión, transacciones y Dispose
│   ├── ArticuloNegocio.cs    # Lógica específica de productos
│   ├── VentaNegocio.cs       # Procesamiento y lógica de ventas
│   └── Mappers/              # Conversión de SqlDataReader a Objetos
├── Pages/                    # Capa de Presentación (WebForms)
│   ├── Admin/                # Gestión de Marcas y Categorías
│   ├── Articulos/            # Listados y gestión de productos
│   ├── Reportes/             # Módulo de estadísticas
│   ├── Stock/                # Gestión de inventario
│   └── Ventas/               # Interfaz de facturación y carrito
├── Content/                  # Estilos (Bootstrap 5, Site.css personalizado)
├── Scripts/                  # Lógica de cliente (JavaScript/jQuery)
├── Site.Master               # Plantilla base y Layout responsivo
├── Login.aspx                # Acceso securizado al sistema
└── Web.config                # Configuración de BD y Autenticación
```

---

## � Detalles de Implementación (Tech Stack)

- **Backend (C#)**: Uso de patrones de diseño para el mapeo de datos y gestión de recursos eficientes.
- **Persistencia (SQL Server)**: El 100% de la lógica reside en Stored Procedures. Los **Triggers** automatizan el control de stock tras cada venta.
- **Frontend**: Uso integral de **Master Pages** para consistencia visual y **Bootstrap 5** para la adaptabilidad.
- **Manejo de Errores**: Sistema unificado de notificaciones y manejo global de excepciones.

---

## �️ Roadmap / Próximas Mejoras

- [ ] Exportación de reportes a Excel y PDF enriquecidos.
- [ ] Implementación de gráficos estadísticos dinámicos (Charts.js).
- [ ] Gestión de perfiles de usuario y auditoría de cambios.
- [ ] Envío automático de comprobantes de venta por Email.

---

## ⚙️ Instalación

1. **Clonar**: `git clone https://github.com/f-Rra/Gestion-Comercial-Web.git`
2. **Base de Datos**: Ejecutar los scripts SQL incluidos para el esquema y procedimientos.
3. **Conexión**: Configurar el `Web.config` con los datos de tu servidor SQL local.
4. **Ejecutar**: Abrir en Visual Studio 2022 y ejecutar con F5 (IIS Express).

---

## �️ Herramientas y Tecnologías

### Desarrollo y Entorno
- **IDE**: Visual Studio 2022 Community.
- **Base de Datos**: SQL Server Management Studio (SSMS).
- **Control de Versiones**: Git & GitHub.
- **Frameworks**: .NET Framework 4.8.1, ASP.NET WebForms.
- **UI/UX**: Bootstrap 5, Font Awesome, CSS3, JavaScript/jQuery.

### Nota sobre el uso de IA
Para el desarrollo de este proyecto, se contó con la asistencia de herramientas de **IA Generativa** (GitHub Copilot / Claude), específicamente aplicada en:
- **Diseño Front-end**: Asistencia en la maquetación y estilizado de interfaces para lograr una estética moderna y responsiva.
- **Refactorización**: Sugerencias para la optimización de código y mejores prácticas de arquitectura.
- **Documentación**: Colaboración en la redacción técnica y estructuración del presente README.

> **Importante**: Toda la lógica de negocio, arquitectura del sistema, diseño de base de datos y funcionalidades principales fueron conceptualizadas y desarrolladas íntegramente por el autor.

---

## �👨‍💻 Autor

**Herrera Facundo**
- Estudiante de Tecnicatura Universitaria en Programación (UTN-FRGP)
- LinkedIn: [Facundo Herrera](https://www.linkedin.com/in/facundo-herrera-38448722a/)
- GitHub: [@f-Rra](https://github.com/f-Rra)
