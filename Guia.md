## 📋 Sistema de Gestión Comercial - WinForms → WebForms

## 📊 Arquitectura del Proyecto Web

### Estructura Final
```
SistemaGestionComercial.Web/
├── Web.config
├── Login.aspx
├── Default.aspx
├── Site.Master
├── Pages/
│   ├── Articulos/
│   ├── Ventas/
│   ├── Stock/
│   ├── Reportes/
│   └── Admin/
├── Helpers/
├── Content/
├── Scripts/
├── Dominio/
└── Negocio/
```

### Mapeo WinForms → WebForms

| WinForms | WebForms | Uso |
|----------|----------|-----|
| `Form` | `.aspx` | Página web |
| `Button` | `<asp:Button>` | Eventos en servidor |
| `TextBox` | `<asp:TextBox>` | Campos de entrada |
| `DataGridView` | `<asp:GridView>` | Grillas de datos |
| `ComboBox` | `<asp:DropDownList>` | Listas desplegables |
| `MessageBox.Show()` | JavaScript alert / Label | Mensajes |
| Variables de clase | `Session["key"]` | Estado entre páginas |
| `this.Close()` | `Response.Redirect()` | Navegación |

---

## 🎯 DÍA 1: Configuración Inicial del Proyecto

**Objetivo:** Crear proyecto web, configurar base, copiar capas (SIN CÓDIGO)

### ✅ Commit 1.1: Crear proyecto ASP.NET WebForms

**Tareas:**
1. Abrir Visual Studio 2022
2. Crear nuevo proyecto "ASP.NET Web Application (.NET Framework)"
   - Nombre: `SistemaGestionComercial.Web`
   - Framework: .NET Framework 4.8.1
   - Plantilla: Web Forms
3. Eliminar archivos de ejemplo: `About.aspx`, `Contact.aspx`
4. Commit inicial

**Archivos afectados:**
- Proyecto nuevo creado
- Estructura base de WebForms

**Commit message:**
```
feat: inicializar proyecto ASP.NET WebForms
- Crear proyecto con plantilla Web Forms
- Framework .NET 4.8.1
- Eliminar páginas de ejemplo
```

---

### ✅ Commit 1.2: Instalar dependencias NuGet

**Tareas:**
1. Instalar paquetes vía NuGet:
   - Bootstrap (para UI responsive)
   - jQuery (para interactividad)
   - FontAwesome (iconos)
   - iTextSharp (exportar PDF - opcional para después)

**Archivos afectados:**
- `packages.config`
- Carpetas `Content/`, `Scripts/`

**Commit message:**
```
build: instalar dependencias Bootstrap, jQuery y FontAwesome
- Bootstrap 5.x para diseño responsive
- jQuery para manipulación DOM
- FontAwesome para iconos
```

---

### ✅ Commit 1.3: Configurar Web.config

**Tareas:**
1. Agregar connection string a la base de datos
2. Configurar autenticación por formularios
3. Denegar acceso anónimo por defecto
4. Permitir acceso anónimo solo a `Login.aspx`
5. Configurar sesión (timeout 60 min)

**Archivos afectados:**
- `Web.config`

**Elementos a configurar:**
- `<connectionStrings>` con tu servidor SQL
- `<authentication mode="Forms">`
- `<authorization><deny users="?" /></authorization>`
- `<location path="Login.aspx">` con `<allow users="*" />`
- `<sessionState timeout="60" />`

**Commit message:**
```
config: configurar Web.config con autenticación y BD
- Connection string a SISTEMA_GESTION_COMERCIAL
- Autenticación Forms con redirect a Login
- Denegar acceso anónimo por defecto
- Timeout de sesión 60 minutos
```

---

### ✅ Commit 1.4: Crear estructura de carpetas

**Tareas:**
1. Crear carpetas en el proyecto:
   - `Pages/Articulos/`
   - `Pages/Ventas/`
   - `Pages/Stock/`
   - `Pages/Reportes/`
   - `Pages/Admin/`
   - `Helpers/`
   - `Content/Images/`
   - `Dominio/`
   - `Negocio/`

**Archivos afectados:**
- Estructura de carpetas

**Commit message:**
```
structure: crear estructura de carpetas del proyecto
- Carpetas Pages por módulo
- Carpeta Helpers para utilidades
- Carpetas para capas Dominio y Negocio
```

---

### ✅ Commit 1.5: Copiar y adaptar capa Dominio

**Tareas:**
1. Copiar todas las clases de `Dominio/` del proyecto WinForms
   - `Articulo.cs`
   - `Categoria.cs`
   - `Marca.cs`
   - `Usuario.cs`
   - `Venta.cs`
2. No requieren modificaciones (reutilización directa)

**Archivos afectados:**
- `Dominio/Articulo.cs`
- `Dominio/Categoria.cs`
- `Dominio/Marca.cs`
- `Dominio/Usuario.cs`
- `Dominio/Venta.cs`

**Commit message:**
```
feat: migrar capa de Dominio desde WinForms
- Copiar clases de entidades sin modificaciones
- Articulo, Categoria, Marca, Usuario, Venta
- Reutilización completa de lógica de negocio
```

---

## 🎯 DÍA 2: Preparación Final (SIN CÓDIGO)

**Objetivo:** Completar preparación de archivos estáticos y recursos

### ✅ Commit 2.1: Ya completado - Copiar y adaptar capa Negocio

**Tareas:**
1. Copiar clases de `Negocio/` del proyecto WinForms
2. **Modificar `AccesoDatos.cs`:**
   - Cambiar string de conexión hardcodeada por:
   - `ConfigurationManager.ConnectionStrings["GestionComercialDB"].ConnectionString`
   - Agregar `using System.Configuration;`
3. Agregar referencia a `System.Configuration`
4. Verificar que compile correctamente

**Archivos afectados:**
- `Negocio/AccesoDatos.cs` (modificado)
- `Negocio/ArticuloNegocio.cs`
- `Negocio/CategoriaNegocio.cs`
- `Negocio/MarcaNegocio.cs`
- `Negocio/VentaNegocio.cs`
- `Negocio/UsuarioNegocio.cs`
- `Negocio/ReporteNegocio.cs`

**Commit message:**
```
feat: migrar capa de Negocio y adaptar AccesoDatos
- Copiar clases de negocio desde WinForms
- Adaptar AccesoDatos para leer connection string desde Web.config
- Agregar referencia a System.Configuration
```

---

### ✅ Commit 2.2: Agregar recursos de imágenes del sistema

**Tareas:**
1. Copiar imágenes desde proyecto WinForms `app/Resources/` a `Content/Images/`
2. Imágenes a copiar:
   - `not-available.png` (placeholder para artículos sin foto)
   - `login.png` (para página de login)
   - `logo.png` (logo del sistema)
   - `logo_principal.png` (logo principal/header)
   - `logo_datos.png` (si se usa en alguna sección)
   - `logo_detalles.png` (si se usa en detalles)
3. En Visual Studio:
   - Click derecho en `Content/Images/`
   - Add → Existing Item...
   - Seleccionar las imágenes mencionadas
   - Click Add

**Archivos afectados:**
- `Content/Images/not-available.png` (nuevo)
- `Content/Images/login.png` (nuevo)
- `Content/Images/logo.png` (nuevo)
- `Content/Images/logo_principal.png` (nuevo)
- `Content/Images/logo_datos.png` (nuevo)
- `Content/Images/logo_detalles.png` (nuevo)

**Commit message:**
```
assets: agregar recursos de imágenes del sistema
- Imagen placeholder (not-available.png) para artículos sin foto
- Logos del sistema (logo.png, logo_principal.png)
- Imágenes para login y secciones específicas
- Recursos visuales migrados desde proyecto WinForms
```

---

### ✅ Commit 2.3: Crear estilos CSS base

**Tareas:**
1. Modificar o crear `Content/Site.css` con estilos base:
   - Estilos generales para body (padding, background)
   - Estilos para navbar (sombra, colores)
   - Cards con box-shadow
   - Tables con thead coloreado
   - Botones con border-radius
   - Footer sticky al fondo
   - Clases de utilidad personalizadas
   - Animaciones básicas (slideIn para alerts)

**Archivos afectados:**
- `Content/Site.css` (modificado/nuevo)

**Elementos CSS a incluir:**
- `.navbar { box-shadow: 0 2px 4px rgba(0,0,0,0.1); }`
- `.card { box-shadow: 0 2px 4px rgba(0,0,0,0.1); }`
- `.table thead { background-color: #007bff; color: white; }`
- `.footer { margin-top: 50px; padding: 20px 0; }`
- Animación @keyframes slideIn

**Commit message:**
```
style: crear estilos CSS personalizados base
- Estilos globales del sitio
- Personalización de componentes Bootstrap
- Animaciones y efectos visuales
- Footer y utilidades CSS
```

---

### ✅ Commit 2.4: Preparar páginas auxiliares básicas

**Tareas:**
1. Crear `AccesoDenegado.aspx` (página simple, sin Master):
   - Mensaje "Acceso Denegado"
   - Link para volver al inicio
   - Sin funcionalidad, solo HTML
   
2. Crear `Error.aspx` (página simple, sin Master):
   - Mensaje de error genérico
   - Link para volver al inicio
   - Sin funcionalidad, solo HTML

**Archivos afectados:**
- `AccesoDenegado.aspx` (nuevo)
- `Error.aspx` (nuevo)

**Contenido básico:**
- Solo estructura HTML con Bootstrap
- Sin code-behind por ahora
- Mensaje amigable al usuario
- Botón de regreso

**Commit message:**
```
feat: crear páginas auxiliares de error y acceso denegado
- Página de acceso denegado para usuarios sin permisos
- Página de error genérico
- Solo estructura HTML, sin lógica aún
```

---

## 🎯 DÍA 3: Master Page y Login (PROGRAMACIÓN)

**Objetivo:** Implementar layout principal y autenticación con código

### ✅ Commit 3.1: Crear SessionManager helper (CÓDIGO)

**Tareas:**
1. Crear `Helpers/SessionManager.cs`
2. Clase estática con propiedades:
   - `UsuarioActual` (get/set) - maneja Session["UsuarioActual"]
   - `EstaLogueado` (get) - verifica si hay usuario
   - `EsAdministrador` (get) - verifica rol
   - `Carrito` (get/set) - lista de ItemCarrito
   - `TotalCarrito` (get) - suma de subtotales
3. Métodos:
   - `ValidarSesion()` - redirige a Login si no está logueado
   - `ValidarAdministrador()` - redirige si no es admin
   - `CerrarSesion()` - limpia sesión
   - `AgregarAlCarrito()`, `EliminarDelCarrito()`, `LimpiarCarrito()`
4. Crear clase auxiliar `ItemCarrito` con:
   - Propiedades: Articulo, Cantidad
   - Propiedad calculada: Subtotal

**Archivos afectados:**
- `Helpers/SessionManager.cs` (nuevo)

**Commit message:**
```
feat: crear SessionManager para manejo de estado
- Gestión centralizada de sesión de usuario
- Control de autenticación y roles
- Métodos de validación y cierre de sesión
- Gestión de ca3: Implementar lógica de Site.Master (C#)
- Clase ItemCarrito para items del carrito
```

---

### ✅ Commit 3.2: Diseñar Site.Master (HTML/Bootstrap)

**Tareas:**
1. Modificar `Site.Master`:
   - Agregar referencias Bootstrap y jQuery en `<head>`
   - Crear navbar con:
     - Brand/Logo del sistema
     - Links a módulos (Artículos, Ventas, Stock, Reportes)
     - Menú Admin (visible solo para admins)
     - Nombre de usuario logueado
     - Botón cerrar sesión
   - ContentPlaceHolder para contenido principal
   - Footer con copyright

**Archivos afectados:**
- `Site.Master`
4
**Commit message:**
```
feat: diseñar Master Page con navegación Bootstrap
- Navbar responsive con links a módulos
- ContentPlaceHolder para páginas
- Footer con información
- Integración de Bootstrap y jQuery
```

---

### ✅ Commit 3.2: Implementar lógica de Site.Master

**Tareas:**
1. Modificar `Site.Master.cs`:
   - En `Page_Load`: validar sesión con `SessionManager`
   - Mostrar nombre de usuario
   - Mostrar/ocultar menú Admin según rol
   - Evento `btnCerrarSesion_Click`: llamar `SessionManager.CerrarSesion()` y redirigir

**Archivos afectados:**
- `Site.Master.cs`

**Commit message:**
```
feat: implementar lógica del Master Page
- Validación de sesión en todas las páginas
- Control de visibilidad de menú según rol
- Funcionalidad de cerrar sesión
```

---

### ✅ Commit 3.3: Crear interfaz de Login

**Tareas:**
1. Crear `Login.aspx` (sin Master Page):
   - Layout centrado con card Bootstrap
   - Logo/Título del sistema
   - TextBox para usuario
   - TextBox para contraseña (TextMode="Password")
   - CheckBox "Recordarme" (opcional)
   - Botón "Ingresar"
   - RequiredFieldValidators para ambos campos
   - Panel para mostrar errores

**Archivos afectados:**
- `Login.aspx` (nuevo)

**Commit message:**
```
feat: crear interfaz de Login
- Diseño con Bootstrap (card centrado)
- Campos usuario y contraseña
- Validadores ASP.NET
- Panel de mensajes de error
```

---

### ✅ Commit 3.5: Implementar lógica de Login (C#)

**Tareas:**
1. Crear `Login.aspx.cs`:
   - En `Page_Load`: si ya está logueado, redirigir a Default
   - En `btnIngresar_Click`:
     - Validar credenciales con `UsuarioNegocio.ValidarLogin()`
     - Si es válido: guardar en `SessionManager.UsuarioActual`
     - Redirigir según rol: Admin → Default.aspx, Vendedor → Ventas/NuevaVenta.aspx
     - Si no es válido: mostrar error

**Archivos afectados:**
- `Login.aspx.cs` (nuevo)

**Commit message:**
```
feat: implementar autenticación de usuarios
- Validación de credenciales contra BD
- Almacenamiento en sesión con SessionManager
- Redirección según rol de usuario
- Manejo de errores de autenticación
```

---

### ✅ Commit 3.6: Actualizar navbar y estilos del sistema

**Tareas:**
1. Modificar `Site.Master`:
   - **Eliminar todos los menús** de navegación (Artículos, Ventas, Stock, Reportes, Admin)
   - Dejar solo en el navbar:
     - Logo (logo_principal.png) - tamaño 64x64
     - Título "Gestion Comercial" (fs-2)
     - Nombre de usuario con icono (derecha)
     - Botón "Salir" con icono (derecha)
   - Aplicar gradiente con estilo inline:
     ```html
     style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%);"
     ```
   - Todas las fuentes en `text-light`
   - Botón Salir con color accent: `style="background-color: var(--color-accent); border-color: var(--color-accent);"`

2. Modificar `Content/Site.css`:
   - Agregar clase `.default-page` con gradiente claro:
     ```css
     body.default-page {
         background: linear-gradient(135deg, var(--color-light) 0%, #ffffff 50%, var(--color-light) 100%);
         min-height: 100vh;
     }
     ```
   - Agregar clase `.login-page` con gradiente oscuro:
     ```css
     body.login-page {
         background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%);
         min-height: 100vh;
     }
     ```

**Archivos afectados:**
- `Site.Master`
- `Content/Site.css`

**Justificación:** La navegación se hace desde el dashboard (Default.aspx) con cards. El navbar solo tiene identificación y cierre de sesión.

**Commit message:**
```
refactor: simplificar navbar y agregar estilos de páginas
- Navbar minimalista: Logo + Título + Usuario + Salir
- Eliminar menús de navegación (se usan cards en dashboard)
- Aplicar gradiente al navbar usando variables CSS
- Agregar clase login-page con gradiente oscuro
- Agregar clase default-page con gradiente claro
```

---

---

## 🎯 DÍA 4: Dashboard y Módulo Artículos (PROGRAMACIÓN)

**Objetivo:** Implementar dashboard y ABM completo de artículos

### ✅ Commit 4.1: Crear Dashboard (Default.aspx) - Solo para Admin

**Tareas:**
1. Modificar `Default.aspx`:
   - Usar `Site.Master` (hereda navbar automáticamente)
   - Agregar clase `default-page` al ContentPlaceHolder
   - Título de bienvenida: "Bienvenido al Sistema de Gestión Comercial"
   - Subtítulo con nombre del usuario
   - Grid de **cards grandes** con accesos rápidos a módulos (usando Bootstrap grid):
     - 📦 **Artículos** → `Pages/Articulos/ListaArticulos.aspx`
       - Icono: `fa-box`
       - Descripción: "Gestión de productos y stock"
     - 🛒 **Ventas** → `Pages/Ventas/NuevaVenta.aspx`
       - Icono: `fa-shopping-cart`
       - Descripción: "Registrar nuevas ventas"
     - 📊 **Stock** → `Pages/Stock/ControlStock.aspx`
       - Icono: `fa-boxes`
       - Descripción: "Control de inventario"
     - 📈 **Reportes** → `Pages/Reportes/Reportes.aspx`
       - Icono: `fa-chart-bar`
       - Descripción: "Informes y estadísticas"
     - ⚙️ **Admin** → `Pages/Admin/Usuarios.aspx`
       - Icono: `fa-cog`
       - Descripción: "Administración de usuarios"
   - Cada card con:
     - Icono FontAwesome grande (3-4x)
     - Título del módulo
     - Descripción breve
     - Hover effect (shadow y cambio de color)
     - Link a la página correspondiente
   - Usar Bootstrap grid: `row` con `col-md-6 col-lg-4`

2. Crear `Default.aspx.cs`:
   - En `Page_Load`: 
     - Validar que solo Admin acceda con `SessionManager.ValidarAdministrador()`
     - Si es vendedor, redirigir automáticamente a `Pages/Ventas/NuevaVenta.aspx`
     - Mostrar nombre del usuario logueado

**Archivos afectados:**
- `Default.aspx`
- `Default.aspx.cs`

**Nota:** Esta página es SOLO para Admin. El vendedor nunca la ve, va directo a Ventas después del login.

**Commit message:**
```
feat: crear dashboard con cards de navegación para Admin
- Dashboard con 5 cards grandes (Artículos, Ventas, Stock, Reportes, Admin)
- Iconos FontAwesome y hover effects
- Validación de acceso solo para administradores
- Redirección automática de vendedor a Ventas
- Diseño responsive con Bootstrap grid
```

---

### ✅ Commit 4.2: Mejorar footer y ajustes de diseño

**Tareas:**
1. Actualizar footer en `Default.aspx`:
   - Eliminar logo del footer
   - Cambiar color del copyright a `var(--color-primary-dark)`
   - Agregar iconos de GitHub y LinkedIn con FontAwesome
   - Aplicar color primario a los iconos
   - Diseño responsive con flexbox de Bootstrap

2. Modificar `Login.aspx`:
   - Eliminar footer del login para diseño más limpio

3. Ajustar `Default.aspx.cs`:
   - Comentar temporalmente redirección a `NuevaVenta.aspx` (página pendiente)

**Archivos afectados:**
- `Default.aspx`
- `Login.aspx`
- `Default.aspx.cs`

**Commit message:**
```
style: actualizar footer con iconos de redes sociales
- Eliminar logo del footer en Default.aspx
- Cambiar color del copyright a var(--color-primary-dark)
- Agregar iconos de GitHub y LinkedIn con color primario
- Eliminar footer de Login.aspx para diseño más limpio
- Comentar redirección temporal a NuevaVenta.aspx (página pendiente)
```

---

### ✅ Commit 4.3: Lista de artículos - Interfaz

**Tareas:**
1. Diseñar layout con jumbotron y panel principal (filtros + GridView) más panel lateral (imagen + detalles)
2. Implementar filtros de búsqueda (Campo, Criterio, Filtro) con controles ASP.NET
3. Agregar GridView con 7 columnas y botones de acción (Editar, Eliminar, Agregar)
4. Aplicar colores del proyecto y diseño responsive con Bootstrap
5. Crear event handlers en code-behind para toda la funcionalidad
6. Actualizar Default.aspx con jumbotron unificado
7. Ajustes de diseño: reducir tamaño de filtros (col-md-2), ensanchar botones (px-4)
8. Agregar líneas separadoras con efecto blur entre secciones
9. Reducir y centrar paneles (col-lg-7 + col-lg-3, altura 450px)
10. Ajustar footer para correcta visualización

**Archivos afectados:**
- `Pages/Articulos/ListaArticulos.aspx` (nuevo - interfaz completa)
- `Pages/Articulos/ListaArticulos.aspx.cs` (nuevo - event handlers vacíos con TODO)
- `Default.aspx` (modificado - jumbotron en lugar de encabezado simple)

**Commit message:**
```
feat(articulos): crear interfaz de gestión de artículos

- Diseñar layout con jumbotron (línea decorativa debajo del título)
- Implementar panel principal (filtros + GridView) y panel lateral (imagen + detalles)
- Filtros de búsqueda compactos (Campo, Criterio, Filtro) en col-md-2
- GridView con 7 columnas y altura fija (280px con scroll)
- Panel izquierdo col-lg-7 y derecho col-lg-3, centrados, altura 450px
- Líneas separadoras con efecto blur (opacity 0.3, filter blur 0.5px)
- Botones de acción ensanchados con px-4
- Aplicar colores del proyecto y diseño responsive
- Event handlers en code-behind vacíos (TODO)
- Actualizar Default.aspx con jumbotron unificado
- Footer alineado correctamente
```

---

### ✅ Commit 4.4: Refinamiento de interfaz de artículos

**Tareas:**
1. Ajustar tamaño de filtros de col-md-4 a col-md-2 (más compactos)
2. Ensanchar botones de acción con padding horizontal (px-4)
3. Reducir margen entre labels y inputs (mb-1)
4. Desplazar filtros hacia la derecha (ms-3)
5. Agregar líneas decorativas con efecto blur:
   - Debajo del h1 en jumbotron (solo ancho del título)
   - Arriba y abajo del GridView
6. Reducir y centrar paneles:
   - Panel izquierdo: col-lg-9 → col-lg-7
   - Altura de paneles: 520px → 450px
   - GridView: 330px → 280px
   - Agregar justify-content-center al row
7. Ajustar footer para correcta alineación

**Archivos afectados:**
- `Pages/Articulos/ListaArticulos.aspx` (modificado)

**Commit message:**
```
refactor(articulos): refinar interfaz de lista de artículos

- Reducir tamaño de filtros (col-md-4 → col-md-2)
- Ensanchar botones con px-4
- Agregar líneas decorativas con blur entre secciones
- Reducir y centrar paneles (col-lg-7 + col-lg-3, altura 450px)
- GridView con altura 280px
- Ajustar espaciado y márgenes
- Corregir alineación del footer
```

---

## 🎯 DÍA 5: Interfaces de Módulos (DISEÑO)

**Objetivo:** Diseñar todas las interfaces restantes antes de implementar backend

### Commit 5.1: Formulario de artículo - Interfaz

**Tareas:**
1. Crear `DetallesArticulos.aspx` (formulario de artículo) usando `Site.Master` y layout con jumbotron y dos paneles (formulario + vista previa).
2. Corregir encoding a UTF-8 para mostrar tildes y caracteres especiales correctamente.
3. Modificar el layout usando Bootstrap grid y clases de color del proyecto.
4. Cambiar el header para aclarar que es solo vista, no edición.
5. Ajustar labels y estilos para consistencia visual y mejor legibilidad.
6. Eliminar la lógica de autenticación para permitir acceso público a la página.
7. No implementar validaciones ASP.NET ni event handlers en el code-behind (solo vista, sin lógica de ABM).

**Archivos afectados:**
- `Pages/Articulos/FormArticulo.aspx` (nuevo)
- `Pages/Articulos/FormArticulo.aspx.cs` (nuevo - event handlers vacíos con TODO)

**Commit message:**
```
feat: crear interfaz para detalles de artículos
- Layout con jumbotron y dos paneles (formulario + vista previa)
- Corrección de encoding UTF-8 para tildes y caracteres especiales
- Ajuste de estilos y colores usando Bootstrap y clases
- Eliminación de validaciones ASP.NET y event handlers (solo vista, sin lógica de ABM)
- Eliminación de barreras de autenticación para acceso público
```

---

### Commit 5.2: Nueva venta - Interfaz completa

**Tareas:**
1. Crear `Pages/Ventas/NuevaVenta.aspx`:
   - Usar `Site.Master`
   - Jumbotron con título "Nueva Venta"
   - ScriptManager (para UpdatePanel)
   - Layout de 2 columnas:
     - **Columna izquierda (8)**: Selección de artículos
       - TextBox búsqueda con AutoPostBack
       - Repeater con artículos disponibles:
         - Card por cada artículo con imagen, nombre, código, precio, stock
         - Botón "Agregar al Carrito" (habilitado si stock > 0)
     - **Columna derecha (4)**: Carrito de compras
       - Card "Carrito de Compras"
       - UpdatePanel con GridView:
         - Artículo, Precio, Cantidad (editable), Subtotal
         - Botón Quitar (×)
       - Div "carrito vacío" (visible cuando no hay items)
       - Label para Total con formato moneda
       - Botón "Finalizar Venta" (habilitado si hay items)
       - Botón "Limpiar Carrito"
   - Modal de confirmación de venta (Bootstrap)
   - Diseño responsive
   - Event handlers vacíos en code-behind

**Archivos afectados:**
- `Pages/Ventas/NuevaVenta.aspx` (nuevo)
- `Pages/Ventas/NuevaVenta.aspx.cs` (nuevo - event handlers vacíos con TODO)

**Commit message:**
```
feat(ventas): crear interfaz completa del sistema de ventas
- Layout de dos columnas (selección + carrito)
- Búsqueda en tiempo real con AutoPostBack
- Repeater para productos con cards
- UpdatePanel para actualizaciones parciales del carrito
- GridView con edición inline de cantidades
- Modal de confirmación Bootstrap
- Event handlers vacíos preparados para lógica
```

---

### Commit 5.3: Gestión de stock - Interfaz

**Tareas:**
1. Crear `Pages/Stock/GestionStock.aspx`:
   - Usar `Site.Master`
   - Jumbotron con título "Gestión de Stock"
   - Botones: "Entrada de Stock", "Salida de Stock"
   - Card con GridView de artículos:
     - Código, Nombre, Categoría, Stock (con badge según cantidad)
     - Botón "Ajustar" por fila
   - Modal para ajuste rápido (Bootstrap):
     - HiddenField con ID del artículo
     - Labels para mostrar artículo y stock actual
     - DropDownList tipo operación (Entrada/Salida)
     - TextBox cantidad con validadores
     - TextBox motivo (opcional)
     - Botones Guardar/Cancelar
   - Badges coloreados según nivel de stock (bajo/medio/alto)
   - Diseño responsive
   - Event handlers vacíos en code-behind

**Archivos afectados:**
- `Pages/Stock/GestionStock.aspx` (nuevo)
- `Pages/Stock/GestionStock.aspx.cs` (nuevo - event handlers vacíos con TODO)

**Commit message:**
```
feat(stock): crear interfaz de gestión de stock
- Jumbotron con título y descripción
- Vista de inventario con indicadores visuales
- Modal para ajustes rápidos de stock
- Badges coloreados según nivel de stock
- Validadores para entrada de datos
- Event handlers vacíos preparados para lógica
```

---

### Commit 5.4: Reportes - Interfaz

**Tareas:**
1. Crear `Pages/Reportes/ReporteInventario.aspx`:
   - Usar `Site.Master`
   - Jumbotron con título "Reporte de Inventario"
   - Card con filtros:
     - DropDownList categoría
     - DropDownList marca
     - Botón "Filtrar"
   - GridView con columnas:
     - Código, Artículo, Categoría, Marca, Stock, Precio, Valor Total
   - Panel de totales en la parte inferior:
     - Labels para: Total Artículos, Valor Total Inventario
   - Botones: "Exportar PDF", "Exportar Excel"
   - Diseño responsive
   - Event handlers vacíos en code-behind

**Archivos afectados:**
- `Pages/Reportes/ReporteInventario.aspx` (nuevo)
- `Pages/Reportes/ReporteInventario.aspx.cs` (nuevo - event handlers vacíos con TODO)

**Commit message:**
```
feat(reportes): crear interfaz de reporte de inventario
- Jumbotron con título del reporte
- Filtros por categoría y marca
- GridView con totales calculados
- Panel de resumen con totales
- Botones de exportación (PDF/Excel)
- Event handlers vacíos preparados para lógica
```

---

### Commit 5.5: Admin — Interfaz unificada de Categorías y Marcas

**Tareas:**
1. Crear UNA sola página `Pages/Admin/Catalogos.aspx` (o `CategoriasMarcas.aspx`):
   - Usar `Site.Master`.
   - Jumbotron con título "Gestión de Categorías y Marcas".
   - Layout con dos contenedores lado a lado (sin selector): `row g-4` con `col-12 col-lg-6` para cada módulo.
   - Contenedor izquierdo — Categorías:
     - Barra superior con buscador `input-group input-group-sm` y botón "Nueva".
     - Card principal con `table-responsive` y `GridView`/tabla `table table-sm table-striped table-hover` (ID, Descripción y acciones por fila: Editar/Eliminar con botones outline `btn-sm`).
   - Contenedor derecho — Marcas:
     - Barra superior con buscador `input-group input-group-sm` y botón "Nueva".
     - Card principal con `table-responsive` y `GridView`/tabla `table table-sm table-striped table-hover` (ID, Descripción y acciones por fila: Editar/Eliminar con botones outline `btn-sm`).
   - Un único Modal de ABM (Bootstrap) reutilizable para ambas entidades:
     - HiddenField para ID (modificación)
     - Campo Descripción con validación requerida
     - Botones Guardar/Cancelar
   - Diseño responsive y consistente con el resto del sistema (jumbotron y footer unificados).
   - Event handlers vacíos en code-behind (Nuevo, Editar, Eliminar, Guardar, Cancelar) para ambos contenedores.

**Archivos afectados:**
- `Pages/Admin/Catalogos.aspx` (nuevo)
- `Pages/Admin/Catalogos.aspx.cs` (nuevo - event handlers vacíos con TODO)

**Commit message:**
```
feat(admin): crear interfaz unificada de categorías y marcas
- Una sola página con dos contenedores lado a lado (categorías y marcas)
- Grid con operaciones CRUD y acciones por fila
- Modal Bootstrap único para ABM
- Validadores y diseño responsive consistentes
- Event handlers vacíos preparados para lógica
```

---

## 🎯 DÍA 6-8: Backend y Lógica (PROGRAMACIÓN)

**Objetivo:** Implementar toda la lógica de negocio en los event handlers

### Commit 6.1: Lista de artículos - Lógica

**Tareas:**
1. Implementar `Pages/Articulos/ListaArticulos.aspx.cs`:
   - `Page_Load`: validar sesión y cargar artículos
   - `CargarArticulos()`: listar con filtros aplicados
   - `btnBuscar_Click`: aplicar filtros de búsqueda
   - `btnEditar_Click`: redirect a FormArticulo con ID
   - `btnEliminar_Click`: eliminar con confirmación
   - `btnAgregar_Click`: redirect a FormArticulo para nuevo
   - `btnDetalles_Click`: mostrar detalles del artículo seleccionado
   - `dgvArticulos_SelectedIndexChanged`: cargar imagen y datos del artículo seleccionado

**Archivos afectados:**
- `Pages/Articulos/ListaArticulos.aspx.cs` (modificado - implementar lógica)

**Commit message:**
```
feat(articulos): implementar lógica de lista de artículos
- Carga de datos desde BD con ArticuloNegocio
- Filtros dinámicos por campo, criterio y búsqueda
- Eliminación con confirmación JavaScript
- Navegación a formulario para edición/alta
- Selección de artículo con actualización de imagen
```

---

### Commit 6.2: Formulario de artículo - Lógica

**Tareas:**
1. Implementar `Pages/Articulos/FormArticulo.aspx.cs`:
   - Propiedad `EsModificacion`: verificar si hay `id` en QueryString
   - `Page_Load`: cargar desplegables, si es modificación cargar datos
   - `CargarDesplegables()`: llenar categorías y marcas
   - `CargarArticulo()`: obtener por ID y llenar controles
   - `btnGuardar_Click`:
     - Crear objeto Articulo con datos del form
     - Si es modificación: llamar `ArticuloNegocio.Modificar()`, sino `Agregar()`
     - Validar datos
     - Redirect a ListaArticulos.aspx
   - `btnCancelar_Click`: redirect a ListaArticulos.aspx
   - `txtImagenUrl_TextChanged`: actualizar vista previa (AutoPostBack)

**Archivos afectados:**
- `Pages/Articulos/FormArticulo.aspx.cs` (modificado - implementar lógica)

**Commit message:**
```
feat(articulos): implementar lógica de alta/modificación
- Detección automática de modo (Alta/Modificación)
- Carga de datos para edición desde BD
- Guardado con ArticuloNegocio
- Validaciones server-side
- Vista previa dinámica de imagen
- Redirección post-guardado
```

---

### Commit 6.3: Nueva venta - Lógica

**Tareas:**
1. Implementar `Pages/Ventas/NuevaVenta.aspx.cs`:
   - `Page_Load`: cargar artículos disponibles y actualizar carrito
   - `CargarArticulos()`: listar con filtro de búsqueda y stock > 0
   - `txtBuscar_TextChanged`: recargar artículos filtrados (AutoPostBack)
   - `rptArticulos_ItemCommand`: agregar al carrito con `SessionManager.AgregarAlCarrito()`
   - `ActualizarCarrito()`: actualizar GridView del carrito y label total
   - `gvCarrito_RowDataBound`: configurar controles en cada fila
   - `txtCantidad_TextChanged`: actualizar cantidad en carrito (AutoPostBack)
   - `gvCarrito_RowCommand`: quitar item del carrito
   - `btnLimpiar_Click`: limpiar carrito completo con `SessionManager.LimpiarCarrito()`
   - `btnFinalizarVenta_Click`: 
     - Registrar venta en BD con `VentaNegocio`
     - Actualizar stock automáticamente (trigger en BD)
     - Limpiar carrito
     - Mostrar mensaje de éxito
   - `btnNuevaVenta_Click`: reload página (desde modal)

**Archivos afectados:**
- `Pages/Ventas/NuevaVenta.aspx.cs` (modificado - implementar lógica)

**Commit message:**
```
feat(ventas): implementar lógica completa del sistema de ventas
- Gestión de carrito con SessionManager
- Agregar/quitar/modificar items dinámicamente
- Búsqueda en tiempo real de productos
- Registro de venta en BD con VentaNegocio
- Actualización automática de stock (trigger)
- Validación de stock disponible
- Cálculo automático de totales
```

---

### Commit 6.4: Gestión de stock - Lógica

**Tareas:**
1. Implementar `Pages/Stock/GestionStock.aspx.cs`:
   - `Page_Load`: validar rol admin con `SessionManager.ValidarAdministrador()` y cargar stock
   - `CargarStock()`: listar todos los artículos con `ArticuloNegocio`
   - `ObtenerClaseStock()`: devolver clase CSS según nivel de stock (badge)
   - `gvStock_RowDataBound`: aplicar colores a badges según stock
   - `btnAjustar_Click`: 
     - Obtener ID del artículo (CommandArgument)
     - Cargar datos en modal (JavaScript)
     - Mostrar modal
   - `btnGuardarAjuste_Click`:
     - Obtener datos del modal
     - Validar operación (Entrada/Salida)
     - Actualizar stock en BD con `ArticuloNegocio.AjustarStock()`
     - Registrar motivo del ajuste (opcional)
     - Recargar grid
     - Cerrar modal con JavaScript
   - `btnCancelar_Click`: cerrar modal

**Archivos afectados:**
- `Pages/Stock/GestionStock.aspx.cs` (modificado - implementar lógica)

**Commit message:**
```
feat(stock): implementar lógica de gestión de stock
- Validación de permisos de administrador
- Operaciones de entrada/salida de stock
- Registro de motivos de ajuste
- Actualización dinámica con UpdatePanel
- Indicadores visuales según nivel de stock
- Validación de operaciones
```

---

### Commit 6.5: Reportes - Lógica

**Tareas:**
1. Implementar `Pages/Reportes/ReporteInventario.aspx.cs`:
   - `Page_Load`: validar admin y cargar reporte
   - `CargarDesplegables()`: llenar filtros de categoría y marca
   - `CargarReporte()`: listar inventario con `ReporteNegocio.ObtenerInventario()`
   - `CalcularTotales()`: calcular cantidad total y valor total del inventario
   - `btnFiltrar_Click`: recargar con filtros aplicados
   - `btnExportarPDF_Click`: 
     - Generar PDF con iTextSharp
     - Incluir datos del reporte
     - Descargar archivo
   - `btnExportarExcel_Click`: 
     - Exportar GridView a formato Excel
     - Configurar headers
     - Descargar archivo

**Archivos afectados:**
- `Pages/Reportes/ReporteInventario.aspx.cs` (modificado - implementar lógica)
- Agregar referencia a iTextSharp (si no está)

**Commit message:**
```
feat(reportes): implementar lógica de reporte de inventario
- Validación de permisos de administrador
- Carga de datos con ReporteNegocio
- Filtros por categoría y marca
- Cálculo de totales (cantidad y valor)
- Exportación a PDF con iTextSharp
- Exportación a Excel
```

---

### Commit 6.6: Admin (Categorías) - Lógica

**Tareas:**
1. Implementar `Pages/Admin/Categorias.aspx.cs`:
   - `Page_Load`: validar admin con `SessionManager.ValidarAdministrador()` y cargar categorías
   - `CargarCategorias()`: listar con `CategoriaNegocio.Listar()`
   - `btnNueva_Click`: limpiar modal y mostrar para nueva categoría
   - `btnEditar_Click`: 
     - Obtener ID (CommandArgument)
     - Cargar datos en modal
     - Mostrar modal
   - `btnGuardar_Click`:
     - Crear objeto Categoria
     - Si tiene ID: `CategoriaNegocio.Modificar()`, sino `Agregar()`
     - Recargar grid
     - Cerrar modal
   - `btnEliminar_Click`:
     - Validar que no tenga artículos asociados
     - Llamar `CategoriaNegocio.Eliminar()`
     - Recargar grid

**Archivos afectados:**
- `Pages/Admin/Categorias.aspx.cs` (modificado - implementar lógica)

**Commit message:**
```
feat(admin): implementar lógica de gestión de categorías
- Validación de permisos de administrador
- CRUD completo con CategoriaNegocio
- Alta/modificación con modal
- Validación de eliminación (no tener artículos asociados)
- Actualización dinámica sin postback completo
```

---

### Commit 6.7: Admin (Marcas) - Lógica

**Tareas:**
1. Implementar `Pages/Admin/Marcas.aspx.cs` (lógica idéntica a Categorías):
   - Usar `MarcaNegocio` en lugar de `CategoriaNegocio`
   - Mismas validaciones y operaciones CRUD

**Archivos afectados:**
- `Pages/Admin/Marcas.aspx.cs` (modificado - implementar lógica)

**Commit message:**
```
feat(admin): implementar lógica de gestión de marcas
- Validación de permisos de administrador
- CRUD completo con MarcaNegocio
- Alta/modificación con modal
- Validación de eliminación (no tener artículos asociados)
- Actualización dinámica sin postback completo
```

---

### Commit 6.8: Finalizar páginas de error y validaciones

**Tareas:**
1. Completar `AccesoDenegado.aspx`:
   - Diseño con jumbotron
   - Mensaje "No tiene permisos para acceder a esta página"
   - Botón "Volver al inicio"
   - Sin Master Page (página independiente)

2. Completar `Error.aspx`:
   - Diseño con jumbotron
   - Mensaje de error genérico
   - Label para mostrar detalle del error (opcional)
   - Botón "Volver al inicio"
   - Sin Master Page (página independiente)

3. Configurar en `Web.config`:
   - `<customErrors mode="On" defaultRedirect="~/Error.aspx">`
   - `<error statusCode="403" redirect="~/AccesoDenegado.aspx" />`
   - `<error statusCode="404" redirect="~/Error.aspx" />`

**Archivos afectados:**
- `AccesoDenegado.aspx` (completar)
- `AccesoDenegado.aspx.cs` (completar)
- `Error.aspx` (completar)
- `Error.aspx.cs` (completar)
- `Web.config` (modificado)

**Commit message:**
```
feat: completar páginas de error y configurar custom errors
- Diseño de página de acceso denegado
- Diseño de página de error global
- Configurar custom errors en Web.config
- Redirecciones automáticas según código de error
```

---

## 📝 Resumen Reorganizado por Día

| Día | Commits | Enfoque | Tipo |
|-----|---------|---------|------|
| **1** | 5 | Configuración inicial | Setup (sin código) |
| **2** | 4 | Preparación final | Setup (sin código) |
| **3** | 6 | Master Page y Login | Programación |
| **4** | 3 | Dashboard y Artículos | Programación + Diseño |
| **5** | 5 | Interfaces de todos los módulos | Solo Diseño (HTML/ASPX) |
| **6** | 3 | Backend Artículos y Ventas | Solo Programación (C#) |
| **7** | 3 | Backend Stock y Reportes | Solo Programación (C#) |
| **8** | 2 | Backend Admin y Finalización | Solo Programación (C#) |
| **TOTAL** | **31 commits** | | Proyecto completo |

### Nueva Distribución:
- **Días 1-2:** Estructura, configuración, archivos estáticos (9 commits)
- **Días 3-4:** Login, Dashboard, inicio de Artículos (9 commits)
- **Día 5:** TODAS las interfaces restantes (5 commits - SOLO DISEÑO)
- **Días 6-8:** TODA la lógica/backend (8 commits - SOLO PROGRAMACIÓN)

### Ventajas de esta reorganización:
1. **Día 5 dedicado a diseño:** Crear todas las interfaces de una vez permite tener una visión completa del sistema
2. **Días 6-8 dedicados a backend:** Implementar la lógica después de tener todas las interfaces claras
3. **Mejor flujo de trabajo:** Diseñar primero, programar después
4. **Facilita testing:** Se puede probar el diseño antes de agregar lógica
5. **Menos ida y vuelta:** No saltar entre diseño y lógica constantemente

---

| Día | Commits | Enfoque | Módulos |
|-----|---------|---------|---------|
| **1** | 5 | Configuración inicial | Proyecto, dependencias, estructura, capas |
| **2** | 4 | Lógica base | Negocio, helpers, estilos |
| **3** | 5 | UI base | Master Page, Login, Dashboard |
| **4** | 5 | Artículos | ABM completo con validaciones |
| **5** | 4 | Ventas | Carrito, checkout, historial |
| **6** | 5 | Finales | Stock, Reportes, Admin |
| **TOTAL** | **28 commits** | | Proyecto completo |

---

## 🎯 Checklist Final de Validación

### Funcionalidades Básicas
- [ ] Login funciona correctamente
- [ ] Sesión se mantiene entre páginas
- [ ] Master Page con navegación operativa
- [ ] Dashboard muestra información
- [ ] ABM de artículos completo
- [ ] Sistema de ventas con carrito funcional
- [ ] Gestión de stock operativa
- [ ] Reportes se generan correctamente
- [ ] ABM de categorías y marcas funciona
- [ ] Cerrar sesión funciona
 (REORGANIZADO)

| Día | Commits | Enfoque | Tipo |
|-----|---------|---------|------|
| **1** | 5 | Configuración inicial | Setup (sin código) |
| **2** | 4 | Preparación final | Setup (sin código) |
| **3** | 5 | Master Page y Login | Programación |
| **4** | 5 | Dashboard y Artículos | Programación |
| **5** | 4 | Ventas completo | Programación |
| **6** | 5 | Stock, Reportes, Admin | Programación |
| **TOTAL** | **28 commits** | | Proyecto completo |

### Distribución:
- **Días 1-2:** Estructura, configuración, archivos estáticos (9 commits)
- **Días 3-6:** Toda la programación y funcionalidades (19 commits)
- [ ] Mensajes de error/éxito claros
- [ ] Botones con confirmación (eliminar)
- [ ] Diseño consistente en todas las páginas

### Base de Datos
- [ ] Connection string correcta
- [ ] Procedimientos almacenados funcionan
- [ ] Triggers activos (actualización stock)
- [ ] Transacciones implementadas

---

## 📚 Conceptos del Curso Aplicados

### ✅ Unidad 1: HTML, CSS, JS
- Estructura HTML en archivos `.aspx`
- CSS personalizado en `site.css`
- JavaScript para confirmaciones y modales

### ✅ Unidad 2: Master Page
- `Site.Master` como layout principal
- ContentPlaceHolder para contenido
- Code-behind compartido

### ✅ Unidad 3: Bootstrap
- Grid system responsive
- Componentes: navbar, cards, modals, forms
- Clases de utilidad

### ✅ Unidad 4: Eventos y Sesión
- Manejo de sesión con `SessionManager`
- Eventos server-side
- Pasaje de parámetros con CommandArgument

### ✅ Unidad 5: Manejo de Datos
- GridView para listados
- Repeater para control personalizado
- Procedimientos almacenados

### ✅ Unidad 6: ABM desde Web
- Formularios con DropDownList
- Alta/Modificación en misma página
- UpdatePanel para actualizaciones parciales

### ✅ Unidad 7: Controles Avanzados
- UpdatePanel para AJAX
- Filtros dinámicos
- JTable/GridView con paginación

### ✅ Unidad 8: Validaciones
- RequiredFieldValidator
- RangeValidator
- RegularExpressionValidator
- Validaciones JavaScript

---


