
## Commit 5.2 — Nueva Venta: Interfaz completa

- **Objetivo**
  - Página de venta con dos columnas: selección de artículos y carrito. Modal de confirmación. Patrón de jumbotron y footer unificados.

- **Estructura (sin código)**
  1. Crear `Pages/Ventas/NuevaVenta.aspx` con `Site.Master`.
  2. Insertar Jumbotron centrado con estilo `p-5 text-center bg-body-tertiary rounded-3 border shadow` (título “Gestión de Ventas” + subtítulo breve).
  3. Cuerpo: `container-fluid pb-3` con `row g-3 justify-content-center`, columnas izquierda `col-12 col-lg-7` y derecha `col-12 col-lg-3`.
  4. Panel izquierdo — Selección de artículos (en contenedor `bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100`):
     - Buscador arriba: `input-group` con botón “Buscar” y acción “Mostrar todos”.
     - Listado en `table table-striped table-hover w-100` (Código, Nombre, Categoría, Marca, Precio, Stock) como alternativa a la grilla de cards.
     - Botón general al pie: “Agregar al carrito” (`btn bg-primary-dark text-light-custom fw-semibold`).
  5. Panel derecho — Carrito (en contenedor `bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100`):
     - Tabla `table table-striped table-hover w-100` (Artículo, Cantidad, Precio, Subtotal).
     - Acciones: `Quitar` y `Limpiar` (`btn btn-outline-info`) y total destacado.
     - CTA principal: “Procesar Venta” (`btn bg-primary-dark btn-lg text-light-custom fw-semibold`).
  6. Modal de confirmación (opcional en 5.2, recomendado para 6.x): confirmar procesamiento de venta.
  7. Footer unificado al final, consistente con el estilo usado en esta pantalla.

- **Handlers a declarar (sin lógica)**
  - `Page_Load`, `txtBuscar_TextChanged`, `btnBuscar_Click`, `btnMostrarTodos_Click`, `btnAgregarSeleccion_Click`, `txtCantidad_TextChanged`, `gvCarrito_RowCommand`, `btnLimpiar_Click`, `btnFinalizarVenta_Click`.

- **Criterios de aceptación**
  - Jumbotron/footer presentes. Cards de productos consistentes. Carrito legible/sticky. Modal disponible. Sin lógica aún, pero eventos enlazados.

- **QA rápido (visual y accesibilidad)**
  - Imágenes proporcionadas (`img-fluid`), textos truncados sin desbordes.
  - Botones con iconos y `btn-sm` consistentes; foco visible.
  - Carrito no produce scroll horizontal; total destacable (`fs-4 fw-semibold`).

- **Mensaje de commit sugerido**
  - feat(ventas): crear interfaz de nueva venta (jumbotron y dos paneles)
    - Layout 7/3 con `container-fluid` y `row g-3`
    - Tabla de artículos y carrito con estilos Bootstrap
    - Botones y paleta personalizada (`bg-primary-dark`, `text-light-custom`)
    - UpdatePanels y handlers declarados (sin lógica backend)
    - Footer unificado y estados vacíos

---

## Commit 5.3 — Gestión de Stock: Interfaz

- **Objetivo**
  - Pantalla con gran listado a la izquierda y panel de detalle/ajuste a la derecha, con atajos de filtros. Similar a la imagen de referencia.

- **Estructura (sin código)**
  1. Crear `Pages/Stock/GestionStock.aspx` con `Site.Master`.
  2. Jumbotron “Gestión de Stock” + ícono.
  3. Cuerpo: `container-fluid pb-3` con `row g-3 justify-content-center`, izquierda `col-12 col-lg-7` y derecha `col-12 col-lg-3`.
  4. Panel izquierdo — Listado (contenedor `bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100`):
     - Tabla `table table-striped table-hover` con badges de stock por fila.
     - Barra de atajos superior o inferior: `row g-2` con botones `btn btn-outline-* btn-sm` (“Stock Bajo”, “Sin Stock”, “Mostrar todos”) y control “Stock mínimo” en `input-group input-group-sm`.
  5. Panel derecho — Detalle/Ajuste (contenedor `bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100`):
     - Campos compactos `form-control/form-select form-control-sm` y ayuda en `small text-body-secondary`.
     - Acciones: Ejecutar (`btn bg-primary-dark` o `btn btn-warning`) y Limpiar (`btn btn-outline-secondary`).
  6. Footer unificado.

- **Estados visuales**
  - Badges en filas: `text-bg-danger` (sin stock), `text-bg-warning` (bajo), `text-bg-success` (ok).
  - Mensajes vacíos como `alert alert-info`.

- **Criterios de aceptación**
  - Jumbotron/footer consistentes. Contenedores `bg-body-secondary` y botones con esquema personalizado. Atajos visibles. Panel derecho compacto y claro.

- **QA rápido**
  - Badges legibles en contraste oscuro/claro; botones `btn-sm` alineados.
  - Controles de panel derecho con espaciado `mb-2`; sin scroll horizontal.

- **Mensaje de commit sugerido**
  - feat(stock): crear interfaz de gestión de stock
    - Layout 7/3 con contenedores `bg-body-secondary`
    - Listado en tabla con badges por nivel de stock
    - Atajos de filtro y control de “Stock mínimo”
    - Acciones y controles compactos (`form-control-sm`, `btn-sm`)
    - Footer unificado

---

## Commit 5.4 — Reportes y Estadísticas: Interfaz

- **Objetivo**
  - Parrilla de botones de reportes, filtros de fecha y gran área de resultados, similar a la imagen.

- **Estructura (sin código)**
  1. Crear `Pages/Reportes/ReporteInventario.aspx` con `Site.Master`.
  2. Jumbotron “Reportes y Estadísticas” + ícono.
  3. Parrilla de acciones: `row row-cols-2 row-cols-md-3 row-cols-lg-4 g-2` con botones `btn btn-outline-info/primary/secondary`.
  4. Filtros laterales/derecha: bloque `bg-body-secondary rounded-3 p-3 p-md-4 border shadow` con “Desde/Hasta” en `input-group input-group-sm` y botón “Exportar” (`btn bg-primary-dark text-light-custom`).
  5. Área de resultados: `card` con `table-responsive` y `table table-striped table-hover table-sm`. Totales en `fw-semibold` al pie.
  6. Footer unificado.

- **Criterios de aceptación**
  - Botonera clara y pareja, filtros alineados y tabla legible con totales.

- **QA rápido**
  - Botones con iconos y separación `g-2` parejos; foco accesible.
  - Fechas alineadas en `input-group-sm`; tabla sin desbordes.

- **Mensaje de commit sugerido**
  - feat(reportes): crear interfaz de reporte de inventario
    - Dashboard de accesos directos con cards, iconos y gradientes
    - Filtros de fecha y exportación a PDF
    - Tabla de resultados con estilos y EmptyDataTemplate
    - Configuración de ResponseEncoding="utf-8" para caracteres especiales
    - Footer unificado y estilos hover personalizados

---

## Commit 5.5 — Admin: Interfaz unificada de Categorías y Marcas

- **Objetivo**
  - Unificar la administración de Categorías y Marcas en una sola página con dos contenedores lado a lado (sin selector), reutilizando el patrón visual.

- **Estructura (sin código)**
  1. Crear una única página: `Pages/Admin/Catalogos.aspx` (o `CategoriasMarcas.aspx`).
  2. Jumbotron “Gestión de Categorías y Marcas” + ícono.
  3. Diseño de dos contenedores paralelos dentro de `container-fluid pb-3` y `row g-3`:
     - Izquierda — Categorías (contenedor `bg-body-secondary rounded-3 p-3 p-md-4 border shadow`): buscador `input-group input-group-sm`, botón “Nueva”, `table-responsive` con `table table-striped table-hover table-sm` y acciones por fila (Editar/Eliminar `btn btn-outline-info btn-sm`).
     - Derecha — Marcas (contenedor `bg-body-secondary rounded-3 p-3 p-md-4 border shadow`): buscador `input-group input-group-sm`, botón “Nueva”, `table-responsive` con `table table-striped table-hover table-sm` y acciones por fila (Editar/Eliminar `btn btn-outline-info btn-sm`).
  4. Modal ABM único reutilizable para ambas entidades (campos `form-control form-control-sm`, botones de acción con `bg-primary-dark text-light-custom`).
  5. Footer unificado.

- **Handlers a declarar (sin lógica)**
  - Nuevo, Editar/Eliminar, Guardar/Cancelar del modal (para ambos contenedores).

- **Criterios de aceptación**
  - Dos contenedores presentes y responsivos. Búsqueda, tabla y modal consistentes con el resto del sistema. Sin tabs ni toggles.

- **Mensaje de commit sugerido**
  - feat(admin): crear interfaz unificada de categorías y marcas
    - Dos contenedores paralelos en `container-fluid` (layout responsive)
    - Buscadores y acciones por fila (`btn-outline-info btn-sm`)
    - Modal ABM reutilizable (campos `form-control-sm`)
    - Footer unificado y consistencia visual

---

## Checklist Global (Día 5)

- Jumbotron y footer presentes e idénticos en 5.2–5.5.
- Estructuras responsive correctas (cols, g-3/g-4, cards/tablas).
- Botones con íconos y tamaños coherentes (`btn-sm` en tablas/cards; `btn-lg` en CTA).
- Estados vacíos/ayuda visibles (`alert` o `text-body-secondary`).
- Accesibilidad básica cubierta (labels, `aria-label`, contraste, foco).
- Handlers declarados y enlazados (sin implementar lógica aún).

---

## Notas de Mejora (opcionales)

- Hacer sticky el panel derecho (carrito o detalles) para evitar scroll largo.
- Usar `text-truncate` y `overflow-hidden` en tarjetas para nombres largos.
- Aplicar `shadow-sm` y `border-info-subtle` para sensación de profundidad.
- Mantener consistencia de iconografía FA 4.7 en headers y botones.

