# Manual de Usuario - SGC-Web

Bienvenido al manual oficial de **SGC-Web (Sistema de Gestión Comercial)**. Esta guía te va a ayudar a manejarte con la plataforma para que puedas gestionar tu inventario y las ventas sin vueltas.

---

## 1. Acceso al Sistema

Para entrar al sistema, tenés que tener tus credenciales de acceso a mano.

1.  Abrí el navegador y cargá la URL de la aplicación.
2.  En la pantalla de **Login**, poné tu **Usuario** y **Contraseña**.
3.  Hacé clic en el botón **Ingresar**.
4.  Si los datos están bien, vas a entrar directo al **Dashboard Principal**.

*Ojo: Por seguridad, el sistema te cierra la sesión solo si pasás mucho tiempo sin hacer nada.*

---

## 2. Dashboard Principal (Inicio)

Apenas entres, te vas a encontrar con un resumen general de cómo viene el negocio:
- **Resumen de Ventas**: Para ver las últimas transacciones que se hicieron.
- **Accesos Directos**: Botones rápidos para lo que más usás (Nueva Venta, Ver Artículos, Stock).
- **Barra de Navegación**: Está arriba de todo para que te muevas entre los distintos módulos.

---

## 3. Gestión de Catálogo

Acá es donde administrás los productos y cómo los tenés clasificados.

### 3.1 Marcas y Categorías
Andá a **Administración > Catálogos** para organizar las etiquetas de tus productos:
- **Crear**: Usá el formulario de arriba para cargar nuevas categorías o marcas.
- **Editar/Eliminar**: Podés cambiarles el nombre o dar de baja las que ya no uses.

### 3.2 Artículos (Productos)
Desde el menú **Artículos**, tenés la lista completa de lo que vendés.
- **Búsqueda y Filtros**: Usá el buscador para encontrar cosas por nombre, marca o categoría. También podés filtrar por rango de precios.
- **Nuevo Artículo**: Dale al botón "+" o "Nuevo" para abrir el formulario de alta. Tenés que completar: Código, Nombre, Descripción, Marca, Categoría, Precio e Imagen.
- **Editar**: Hacé clic en el íconito del lápiz en la fila del artículo que quieras tocar.
- **Baja Lógica**: Si un producto no se vende más, lo podés desactivar. Así no te aparece en las ventas nuevas pero te queda guardado en el historial para los reportes viejos.

---

## 4. Control de Inventario (Stock)

El módulo de **Gestión de Stock** es clave para tener las cantidades siempre al día.

1.  Elegí el artículo al que le quieras ajustar el stock.
2.  El sistema te va a mostrar el **Stock Actual**.
3.  Cargá la cantidad que quieras **Aumentar** o **Bajar**.
4.  Confirmá y listo. El sistema guarda el cambio y te actualiza la disponibilidad al toque.

---

## 5. Sistema de Ventas

El proceso de venta es rápido y seguro, pensado para que no le pifies a nada.

### 5.1 Hacer una Venta Nueva
1.  Andá a **Ventas > Nueva Venta**.
2.  **Buscar Producto**: Escribí el nombre o el código del producto.
3.  **Sumar al Carrito**: Poné cuántos vas a vender y hacé clic en "Agregar". El sistema se fija solo si tenés stock suficiente.
4.  **Manejar el Carrito**: Vas a ver la lista de lo que elegiste. Podés borrar cosas o cambiar las cantidades antes de cerrar la venta.
5.  **Finalizar Venta**: Hacé clic en "Confirmar Venta". Ahí el sistema:
    - Guarda la transacción en la base de datos.
    - Descuenta automático el stock de cada cosa que vendiste.
    - Te avisa con un mensaje que salió todo bien.

---

## 6. Reportes y Estadísticas

Para saber dónde estás parado, pasate por el módulo de **Reportes**:
- **Reporte de Inventario**: Una lista detallada de todos tus productos, cuánto stock tenés y cuánto vale esa mercadería.
- **Gráficos de Participación**: Para ver qué marcas o categorías son las que más tenés en stock.
- **Exportación**: (Si está activado) Tenés la opción de bajarte los datos para abrirlos con Excel.

---

## 7. Solución de Problemas Comunes

- **"Stock Insuficiente"**: Te salta este aviso cuando querés vender más de lo que tenés. Si te acaba de entrar mercadería, hacé primero el ajuste de stock.
- **"Acceso Denegado"**: Fijate si tenés los permisos para entrar a esa parte de administración.
- **No se ve la imagen del producto**: Revisá que la dirección (URL) de la imagen sirva y se pueda ver en internet.

---
© 2026 SGC-Web - Sistema de Gestión Comercial
