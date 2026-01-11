# Guía PPC — Commits 6.1 a 6.8 (Programación)

Guía SIN CÓDIGO para implementar la lógica backend de los módulos, manteniendo los patrones visuales (jumbotron y footer) ya definidos en el Día 5. Incluye objetivos, estructura de handlers, pasos y checklist de QA técnico.

---

## Principios Comunes (aplican a 6.1–6.8)

- **Validación de sesión y roles**: usar `SessionManager.ValidarSesion()` o `ValidarAdministrador()` en `Page_Load` cuando corresponda.
- **Ciclo de vida WebForms**: respetar `IsPostBack` para inicializaciones.
- **Manejo de estado**: usar `SessionManager` para usuario/carrito; evitar duplicar estado en ViewState si no es necesario.
- **Errores y mensajes**: capturar excepciones y mostrar feedback amigable (labels o alerts), log interno si aplica.
- **Accesibilidad**: mantener labels, `aria-*` en botones generados dinámicamente, y foco tras operaciones.

---

## Commit 6.1 — Lista de artículos (Lógica)

- **Objetivo**
  - Completar la lógica de listado, filtros y acciones (editar, eliminar, agregar, detalles).

- **Handlers y responsabilidades**
  - `Page_Load`: validar sesión, `if(!IsPostBack) CargarArticulos()`.
  - `CargarArticulos()`: obtener artículos desde `ArticuloNegocio` aplicando filtros activos.
  - `btnBuscar_Click`: leer filtros, persistir criterios, llamar `CargarArticulos()`.
  - `btnEditar_Click`/`btnAgregar_Click`: redirecciones con QueryString según corresponda.
  - `btnEliminar_Click`: eliminar con confirmación previa (JS) y recargar.
  - `btnDetalles_Click` y `dgvArticulos_SelectedIndexChanged`: actualizar panel de detalles/imagen.

- **Checklist QA**
  - Filtros aplican correctamente y se limpian cuando corresponde.
  - Confirmaciones de eliminación previenen borrados accidentales.
  - Imagen/detalles reflejan la selección actual.

- **Mensaje de commit sugerido**
  - feat(articulos): completar lógica de listado y acciones
    - Carga inicial con IsPostBack y filtros persistentes
    - Handlers de buscar/editar/eliminar/detalles declarados
    - Confirmación de eliminación y recarga del listado
    - Actualización de panel de detalles/imagen

---

## Commit 6.2 — Formulario de artículo (Lógica)

- **Objetivo**
  - Implementar alta y modificación con carga de desplegables y vista previa de imagen.

- **Handlers y responsabilidades**
  - `EsModificacion`: true si hay `id` en QueryString.
  - `Page_Load`: `if(!IsPostBack)` cargar combos y, si aplica, el artículo a editar.
  - `CargarDesplegables()`: popular categorías y marcas.
  - `CargarArticulo()`: leer por ID y llenar controles.
  - `btnGuardar_Click`: armar entidad, validar, `Agregar()` o `Modificar()`, redirigir a lista.
  - `btnCancelar_Click`: regresar a lista.
  - `txtImagenUrl_TextChanged`: actualizar preview de imagen.

- **Checklist QA**
  - Validaciones server-side para campos obligatorios.
  - Modo Alta/Edición detectado correctamente.
  - Redirección y mensajes consistentes.

- **Mensaje de commit sugerido**
  - feat(articulos): implementar alta/modificación con combos
    - Detección de modo por QueryString
    - Carga de desplegables y población de controles
    - Guardar/Cancelar con redirección a la lista
    - Vista previa de imagen y validaciones

---

## Commit 6.3 — Nueva venta (Lógica)

- **Objetivo**
  - Completar carrito, búsqueda en tiempo real, registro de venta y actualización de stock.

- **Handlers y responsabilidades**
  - `Page_Load`: cargar disponibles y actualizar carrito en `!IsPostBack`.
  - `CargarArticulos()`: filtrar por texto y `stock > 0`.
  - `txtBuscar_TextChanged`: recargar artículos.
  - `rptArticulos_ItemCommand`: `SessionManager.AgregarAlCarrito()`.
  - `ActualizarCarrito()`: bind de grilla y total.
  - `gvCarrito_RowDataBound`: configurar controles de fila.
  - `txtCantidad_TextChanged`: actualizar cantidades en el carrito.
  - `gvCarrito_RowCommand`: quitar ítems.
  - `btnLimpiar_Click`: limpiar carrito.
  - `btnFinalizarVenta_Click`: registrar venta con `VentaNegocio`, limpiar y notificar.
  - `btnNuevaVenta_Click`: recargar página (modal).

- **Checklist QA**
  - No permite cantidades negativas ni superar stock.
  - Totales se recalculan correctamente.
  - Carrito persiste entre postbacks hasta finalizar o limpiar.

- **Mensaje de commit sugerido**
  - feat(ventas): completar lógica de carrito y registro de venta
    - Búsqueda en tiempo real y filtro por stock > 0
    - Agregar/Quitar ítems y actualización de cantidades
    - Recalculo de totales y persistencia del carrito
    - Finalización de venta y limpieza

---

## Commit 6.4 — Gestión de stock (Lógica)

- **Objetivo**
  - Operaciones de entrada/salida, registro de motivos y feedback inmediato.

- **Handlers y responsabilidades**
  - `Page_Load`: validar admin y cargar stock en `!IsPostBack`.
  - `CargarStock()`: listar inventario.
  - `ObtenerClaseStock()`: devolver clase CSS por nivel.
  - `gvStock_RowDataBound`: aplicar badges por fila.
  - `btnAjustar_Click`: preparar y mostrar modal.
  - `btnGuardarAjuste_Click`: validar operación, actualizar stock, registrar motivo, recargar grilla y cerrar modal.
  - `btnCancelar_Click`: cerrar modal.

- **Checklist QA**
  - No permite dejar stock en valores inválidos.
  - Modal no pierde foco ni datos tras validación.
  - Colores de badges coherentes con niveles.

- **Mensaje de commit sugerido**
  - feat(stock): implementar ajustes de stock con modal
    - Listado de inventario y badges por nivel
    - Preparación y validación de operación
    - Actualización de stock y registro de motivo
    - Feedback inmediato y cierre de modal

---

## Commit 6.5 — Reportes (Lógica)

- **Objetivo**
  - Reporte de inventario con filtros, totales y exportación.

- **Handlers y responsabilidades**
  - `Page_Load`: validar admin y cargar reporte en `!IsPostBack`.
  - `CargarDesplegables()`: popular combos.
  - `CargarReporte()`: consultar `ReporteNegocio.ObtenerInventario()`.
  - `CalcularTotales()`: cantidad y valor total.
  - `btnFiltrar_Click`: aplicar filtros y recargar.
  - `btnExportarPDF_Click`: generar PDF (iTextSharp) y descargar.
  - `btnExportarExcel_Click`: exportar GridView a Excel.

- **Checklist QA**
  - Totales coherentes con filtro.
  - Exportaciones se descargan con nombres/versiones correctas.
  - Encabezados de archivo correctos.

- **Mensaje de commit sugerido**
  - feat(reportes): lógica de inventario con exportaciones
    - Filtros y recarga de resultados
    - Cálculo de totales (cantidad y valor)
    - Exportación a PDF y Excel con nombres adecuados

---

## Commit 6.6 — Admin (Categorías) Lógica

- **Objetivo**
  - CRUD completo de categorías con modal.

- **Handlers y responsabilidades**
  - `Page_Load`: validar admin y cargar categorías.
  - `CargarCategorias()`: listar con `CategoriaNegocio`.
  - `btnNueva_Click`: limpiar y abrir modal.
  - `btnEditar_Click`: cargar datos en modal.
  - `btnGuardar_Click`: alta/modificación y recarga.
  - `btnEliminar_Click`: validar referencias y eliminar.

- **Checklist QA**
  - Evita eliminar con artículos asociados.
  - Mensajes claros de confirmación/error.
  - Actualización sin postback completo cuando sea posible.

- **Mensaje de commit sugerido**
  - feat(admin): CRUD de categorías con modal
    - Carga inicial y refresco de lista
    - Alta/modificación y edición en modal
    - Validación de referencias antes de eliminar

---

## Commit 6.7 — Admin (Marcas) Lógica

- **Objetivo**
  - CRUD de marcas con mismas reglas que categorías.

- **Handlers y responsabilidades**
  - Mismos handlers que 6.6 usando `MarcaNegocio`.

- **Checklist QA**
  - Reglas de negocio simétricas a categorías.
  - Modal reutiliza estilos y validaciones.

- **Mensaje de commit sugerido**
  - feat(admin): CRUD de marcas simétrico a categorías
    - Handlers y reglas equivalentes a categorías
    - Reutilización de estilos y validaciones

---

## Commit 6.8 — Páginas de error y validaciones

- **Objetivo**
  - Completar páginas de `AccesoDenegado` y `Error`, y configurar `customErrors`.

- **Tareas (sin código)**
  - Diseñar jumbotron y mensajes.
  - Botón “Volver al inicio”.
  - Configurar `Web.config` para redirecciones (403, 404 y default).

- **Checklist QA**
  - Redirecciones funcionan según código.
  - Mensajes claros y layout consistente.
  - No exponen trazas en producción.

- **Mensaje de commit sugerido**
  - feat(core): páginas de error y customErrors
    - Diseños de AccesoDenegado y Error con jumbotron
    - Botón “Volver al inicio”
    - Redirecciones por código y sin trazas en producción
