# 📋 Lista de Tareas Pendientes (To-Do List)

Esta lista te ayudará a saber qué falta hacer en cada pantalla para terminar el proyecto. Simplemente ve marcando con una `x` lo que vayas completando (ejemplo: `[x] Tarea lista`).

---

## 🛍️ Pantalla: Nueva Venta (`NuevaVenta.aspx`)
*Lo que usan los vendedores para cobrar.*

- [ ] **Crear la memoria del carrito**: Configurar una lista oculta para guardar los productos que se van sumando.
    > 💡 **Pista Lógica**: La web no tiene "memoria" por sí sola. Si recargas la página, las variables se borran. Por eso usamos la `Session`. Piensa en la `Session` como un casillero guardado en el servidor con el nombre de tu usuario.
    > 1. Al cargar la página (`Page_Load`), pregunta: "¿Existe ya mi lista en la Session?".
    > 2. Si NO existe (es null), crea una lista nueva vacía y guárdala en la Session.
    > 3. Si SÍ existe, no hagas nada, usa la que ya está.

- [ ] **Botón "Buscar"**: Que al escribir un producto y buscar, aparezca en la lista.
    > 💡 **Pista Lógica**: Esto es filtrar una lista.
    > 1. Trae TODOS los artículos de la base de datos (con tu Negocio).
    > 2. Usa LINQ o un bucle `foreach` para buscar los que coincidan con lo que escribió el usuario.
    > 3. Muestra esa sub-lista filtrada en la Grilla de productos.

- [ ] **Botón "Agregar"**: Que al elegir un producto, se sume al carrito de la derecha.
    > 💡 **Pista Lógica**: Mover datos de un lado a otro.
    > 1. Averigua qué ID de producto clickeó el usuario.
    > 2. Busca los datos completos de ese producto (Nombre, Precio).
    > 3. **Recupera tu lista del carrito desde la Session** (saca la lista del casillero).
    > 4. Agrega el nuevo producto a esa lista.
    > 5. **Vuelve a guardar la lista actualizada en la Session** (importante, si no guardas, se pierde).
    > 6. Pídele al GridView del carrito que se actualice (`DataBind`).

- [ ] **Calcular Totales**: Que cada vez que agrego algo, se actualice el "Total a Pagar".
    > 💡 **Pista Lógica**: Matemáticas simples.
    > 1. Recorre toda la lista del carrito (bucle `foreach`).
    > 2. Acumula: `Total = Total + (Precio * Cantidad)`.
    > 3. Muestra el resultado final en el Label.

- [ ] **Botón "Finalizar Venta"**:
    > 💡 **Pista Lógica**: Guardar en Base de Datos.
    > 1. Recupera la lista final del carrito desde la Session.
    > 2. Llama a tu capa de Negocio (`VentaNegocio`).
    > 3. Tu Negocio debe hacer dos cosas en orden (idealmente en una transacción):
    >    - Insertar el registro en la tabla `VENTAS` (Fecha, Total, Cliente).
    >    - Insertar un registro en `DETALLE_VENTA` por cada producto del carrito.
    > 4. Si todo sale bien, vacía la lista de la Session para que el carrito quede limpio para el próximo cliente.

---

## 📦 Pantalla: Artículos - Detalles (`DetallesArticulos.aspx`)
*Donde cargas nuevos productos o editas los existentes.*

- [ ] **Distinguir Nuevo vs Editar**:
    > 💡 **Pista Lógica**: ¿Cómo sabe la página qué hacer? Por la URL.
    > 1. En el `Page_Load`, pregunta: "¿Viene un parámetro 'id' en la URL?" (`Request.QueryString["id"]`).
    > 2. Si NO viene nada -> Estás creando uno nuevo. Deja todo vacío.
    > 3. Si SÍ viene un ID -> Estás editando. Usa ese ID para buscar el artículo en la BD y llena los TextBox con sus datos.

- [ ] **Cargar Desplegables**: Que las listas de "Marca" y "Categoría" traigan las opciones reales de la base de datos.
    > 💡 **Pista Lógica**: Llenar combos.
    > 1. Llama a `MarcaNegocio.Listar()` y `CategoriaNegocio.Listar()`.
    > 2. Asigna esas listas al `DataSource` de tus DropDownList.
    > 3. Diles qué campo mostrar (Nombre) y qué campo es el valor oculto (ID).
    > 4. Ejecuta `DataBind()`.
    > 5. **Ojo**: ¡Haz esto solo si `!IsPostBack`! Si no, se recargará cada vez que toques un botón y perderás la selección del usuario.

- [ ] **Botón Guardar**:
    > 💡 **Pista Lógica**: Recolectar y enviar.
    > 1. Crea un objeto `Articulo` nuevo en memoria.
    > 2. Llena sus propiedades con lo que escribió el usuario en los TextBox (`articulo.Nombre = txtNombre.Text`, etc.).
    > 3. Pregunta de nuevo: "¿Tengo un ID en la URL?".
    >    - Si hay ID -> Llama a `Negocio.Modificar(articulo)`.
    >    - Si NO hay ID -> Llama a `Negocio.Agregar(articulo)`.

---

## 📊 Pantalla: Stock (`GestionStock.aspx`)
*Para reponer mercadería o corregir cantidades.*

- [ ] **Colores de Alerta**:
    - [ ] Pintar de rojo filas con Stock 0.
    - [ ] Pintar de amarillo filas con poco stock.
- [ ] **Botón "Actualizar Stock"**:
    - [ ] Permitir escribir una nueva cantidad.
    - [ ] Guardar el cambio en base de datos.

---

## 📈 Pantalla: Reportes (`ReporteInventario.aspx`)
*El tablero de control.*

- [ ] **Conectar Tarjetas**: Que los números de arriba (Total Artículos, $$ Ventas) sean reales y no de ejemplo.
- [ ] **Mostrar Datos en Grilla**: Que al hacer clic en "Artículos bajo stock", la tabla de abajo muestre esa lista.

---

## 🛠️ Tareas Generales (Opcionales / Finales)
- [ ] **Probar todo junto**: Hacer una venta completa y ver si baja el stock en la otra pantalla.
- [ ] **Mensajes de Error**: Si algo falla, que no salga la pantalla amarilla fea, sino un mensaje bonito.

