-- =====================================================
-- SISTEMA DE GESTIÓN COMERCIAL - DATOS INICIALES
-- =====================================================

USE SISTEMA_GESTION_COMERCIAL;
GO

-- =====================================================
-- DATOS INICIALES PARA PRUEBAS
-- =====================================================

-- 10 Categorías
INSERT INTO CATEGORIAS (Descripcion) VALUES 
('Electrónicos'),
('Ropa y Accesorios'),
('Hogar y Jardín'),
('Deportes y Fitness'),
('Libros y Papelería'),
('Herramientas'),
('Alimentos y Bebidas'),
('Salud y Belleza'),
('Automotriz'),
('Juguetes y Juegos');
GO

-- 50 Marcas
INSERT INTO MARCAS (Descripcion) VALUES 
('HP'),
('Samsung'),
('Nike'),
('Adidas'),
('Apple'),
('Sony'),
('LG'),
('Philips'),
('Bosch'),
('Black & Decker'),
('Dell'),
('Lenovo'),
('Asus'),
('Acer'),
('Canon'),
('Nikon'),
('Panasonic'),
('Toshiba'),
('Intel'),
('AMD'),
('NVIDIA'),
('Corsair'),
('Logitech'),
('Razer'),
('SteelSeries'),
('HyperX'),
('Kingston'),
('Western Digital'),
('Seagate'),
('SanDisk'),
('Puma'),
('Reebok'),
('Under Armour'),
('New Balance'),
('Converse'),
('Vans'),
('Levi''s'),
('Calvin Klein'),
('Tommy Hilfiger'),
('Ralph Lauren'),
('Gap'),
('Zara'),
('H&M'),
('Uniqlo'),
('Forever 21'),
('Champion'),
('Fila'),
('Kappa'),
('Umbro'),
('Diadora');
GO

-- Usuarios del sistema
INSERT INTO Usuarios (NombreUsuario, Contrasena, EsAdministrador, Estado) VALUES 
('admin', 'admin123', 1, 1),
('usuario', 'user123', 0, 1),
('vendedor', 'vend123', 0, 1);
GO

-- 100 Artículos de prueba con Stock
INSERT INTO ARTICULOS (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio, Stock) VALUES 
-- Electrónicos (1-20)
('ART001', 'Laptop HP Pavilion 15', 'Laptop 15.6" Intel i5 8GB RAM 256GB SSD', 1, 1, 'https://ejemplo.com/laptop1.jpg', 850.00, 15),
('ART002', 'Mouse Inalámbrico Logitech', 'Mouse óptico inalámbrico USB recargable', 23, 1, 'https://ejemplo.com/mouse1.jpg', 25.00, 50),
('ART003', 'Teclado Mecánico Razer', 'Teclado mecánico RGB gaming switches verdes', 24, 1, 'https://ejemplo.com/teclado1.jpg', 120.00, 25),
('ART004', 'Monitor Samsung 24"', 'Monitor LED 24" Full HD 75Hz', 2, 1, 'https://ejemplo.com/monitor1.jpg', 200.00, 8),
('ART005', 'Auriculares Sony Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 6, 1, 'https://ejemplo.com/auriculares1.jpg', 80.00, 0),
('ART006', 'Smartphone Samsung Galaxy', 'Smartphone Android 128GB 6GB RAM', 2, 1, 'https://ejemplo.com/phone1.jpg', 450.00, 12),
('ART007', 'Tablet Apple iPad', 'Tablet 10.9" 64GB WiFi', 5, 1, 'https://ejemplo.com/tablet1.jpg', 350.00, 6),
('ART008', 'Cámara Canon EOS', 'Cámara DSLR 24MP con lente 18-55mm', 15, 1, 'https://ejemplo.com/camara1.jpg', 600.00, 4),
('ART009', 'Impresora HP LaserJet', 'Impresora láser monocromática WiFi', 1, 1, 'https://ejemplo.com/impresora1.jpg', 150.00, 10),
('ART010', 'Router WiFi TP-Link', 'Router WiFi 6 dual band 3000Mbps', 1, 1, 'https://ejemplo.com/router1.jpg', 80.00, 20),
('ART011', 'Disco Duro Externo WD', 'Disco duro externo 1TB USB 3.0', 28, 1, 'https://ejemplo.com/disco1.jpg', 60.00, 30),
('ART012', 'Memoria RAM Corsair 16GB', 'Memoria DDR4 16GB 3200MHz', 22, 1, 'https://ejemplo.com/ram1.jpg', 90.00, 15),
('ART013', 'Placa de Video NVIDIA RTX', 'Placa de video RTX 3060 12GB GDDR6', 21, 1, 'https://ejemplo.com/gpu1.jpg', 400.00, 3),
('ART014', 'Procesador Intel i7', 'Procesador Intel Core i7-11700K', 19, 1, 'https://ejemplo.com/cpu1.jpg', 300.00, 8),
('ART015', 'Motherboard ASUS', 'Placa madre ATX Intel Z590', 13, 1, 'https://ejemplo.com/motherboard1.jpg', 180.00, 5),
('ART016', 'Fuente de Poder Corsair', 'Fuente de poder 750W 80 Plus Gold', 22, 1, 'https://ejemplo.com/fuente1.jpg', 120.00, 12),
('ART017', 'Gabinete Cooler Master', 'Gabinete ATX mid tower con RGB', 1, 1, 'https://ejemplo.com/gabinete1.jpg', 100.00, 7),
('ART018', 'Webcam Logitech HD', 'Webcam HD 1080p con micrófono', 23, 1, 'https://ejemplo.com/webcam1.jpg', 70.00, 18),
('ART019', 'Micrófono Blue Yeti', 'Micrófono USB condensador profesional', 1, 1, 'https://ejemplo.com/microfono1.jpg', 110.00, 9),
('ART020', 'Altavoces Logitech 2.1', 'Sistema de altavoces 2.1 con subwoofer', 23, 1, 'https://ejemplo.com/altavoces1.jpg', 50.00, 25),

-- Ropa y Accesorios (21-40)
('ART021', 'Camisa de Algodón Nike', 'Camisa deportiva 100% algodón', 3, 2, 'https://ejemplo.com/camisa1.jpg', 45.00, 30),
('ART022', 'Pantalón Vaquero Levi''s', 'Pantalón vaquero clásico 501', 37, 2, 'https://ejemplo.com/pantalon1.jpg', 65.00, 12),
('ART023', 'Zapatillas Nike Air Max', 'Zapatillas running con tecnología Air Max', 3, 2, 'https://ejemplo.com/zapatillas1.jpg', 95.00, 18),
('ART024', 'Chaqueta Adidas', 'Chaqueta deportiva con capucha', 4, 2, 'https://ejemplo.com/chaqueta1.jpg', 75.00, 14),
('ART025', 'Gorra New Era', 'Gorra ajustable con logo bordado', 33, 2, 'https://ejemplo.com/gorra1.jpg', 25.00, 40),
('ART026', 'Reloj Casio Digital', 'Reloj digital resistente al agua', 1, 2, 'https://ejemplo.com/reloj1.jpg', 35.00, 22),
('ART027', 'Bolso Nike', 'Bolso deportivo con múltiples compartimentos', 3, 2, 'https://ejemplo.com/bolso1.jpg', 40.00, 16),
('ART028', 'Cinturón de Cuero', 'Cinturón de cuero genuino marrón', 1, 2, 'https://ejemplo.com/cinturon1.jpg', 30.00, 28),
('ART029', 'Gafas de Sol Ray-Ban', 'Gafas de sol clásicas aviator', 1, 2, 'https://ejemplo.com/gafas1.jpg', 120.00, 8),
('ART030', 'Bufanda de Lana', 'Bufanda de lana merino suave', 1, 2, 'https://ejemplo.com/bufanda1.jpg', 20.00, 35),
('ART031', 'Guantes de Invierno', 'Guantes térmicos para frío extremo', 1, 2, 'https://ejemplo.com/guantes1.jpg', 15.00, 45),
('ART032', 'Calcetines Deportivos', 'Pack de 6 calcetines deportivos', 3, 2, 'https://ejemplo.com/calcetines1.jpg', 12.00, 60),
('ART033', 'Vestido Casual', 'Vestido casual de algodón estampado', 1, 2, 'https://ejemplo.com/vestido1.jpg', 35.00, 20),
('ART034', 'Falda Plisada', 'Falda plisada de poliéster', 1, 2, 'https://ejemplo.com/falda1.jpg', 25.00, 18),
('ART035', 'Blusa de Seda', 'Blusa de seda natural elegante', 1, 2, 'https://ejemplo.com/blusa1.jpg', 55.00, 12),
('ART036', 'Traje de Baño', 'Traje de baño de una pieza', 1, 2, 'https://ejemplo.com/traje1.jpg', 40.00, 15),
('ART037', 'Pijama de Algodón', 'Pijama de dos piezas 100% algodón', 1, 2, 'https://ejemplo.com/pijama1.jpg', 30.00, 25),
('ART038', 'Ropa Interior Pack', 'Pack de 5 ropa interior básica', 1, 2, 'https://ejemplo.com/ropa1.jpg', 18.00, 50),
('ART039', 'Medias de Nylon', 'Pack de 10 medias de nylon', 1, 2, 'https://ejemplo.com/medias1.jpg', 8.00, 80),
('ART040', 'Collar de Plata', 'Collar de plata 925 con dije', 1, 2, 'https://ejemplo.com/collar1.jpg', 45.00, 10),

-- Hogar y Jardín (41-60)
('ART041', 'Sofá de 3 Plazas', 'Sofá moderno para living color gris', 1, 3, 'https://ejemplo.com/sofa1.jpg', 450.00, 3),
('ART042', 'Mesa de Centro', 'Mesa de centro de madera de roble', 1, 3, 'https://ejemplo.com/mesa1.jpg', 120.00, 7),
('ART043', 'Lámpara de Pie', 'Lámpara de pie LED con control remoto', 8, 3, 'https://ejemplo.com/lampara1.jpg', 80.00, 12),
('ART044', 'Cortinas Blackout', 'Cortinas opacas para dormitorio', 1, 3, 'https://ejemplo.com/cortinas1.jpg', 35.00, 20),
('ART045', 'Alfombra Persa', 'Alfombra persa 2x3 metros', 1, 3, 'https://ejemplo.com/alfombra1.jpg', 200.00, 5),
('ART046', 'Cama King Size', 'Cama king size con cabecero de madera', 1, 3, 'https://ejemplo.com/cama1.jpg', 300.00, 4),
('ART047', 'Colchón Memory Foam', 'Colchón de espuma viscoelástica', 1, 3, 'https://ejemplo.com/colchon1.jpg', 250.00, 6),
('ART048', 'Mesa de Comedor', 'Mesa de comedor para 6 personas', 1, 3, 'https://ejemplo.com/mesa2.jpg', 180.00, 8),
('ART049', 'Sillas de Comedor', 'Set de 4 sillas de comedor', 1, 3, 'https://ejemplo.com/sillas1.jpg', 120.00, 10),
('ART050', 'Estantería de Libros', 'Estantería de 5 niveles de madera', 1, 3, 'https://ejemplo.com/estanteria1.jpg', 90.00, 15),
('ART051', 'Maceta de Cerámica', 'Maceta de cerámica esmaltada 30cm', 1, 3, 'https://ejemplo.com/maceta1.jpg', 25.00, 30),
('ART052', 'Regadera de Metal', 'Regadera de metal galvanizado 2L', 1, 3, 'https://ejemplo.com/regadera1.jpg', 20.00, 25),
('ART053', 'Semillas de Tomate', 'Pack de 50 semillas de tomate cherry', 1, 3, 'https://ejemplo.com/semillas1.jpg', 5.00, 100),
('ART054', 'Fertilizante Orgánico', 'Fertilizante orgánico 1kg', 1, 3, 'https://ejemplo.com/fertilizante1.jpg', 15.00, 40),
('ART055', 'Herramientas de Jardín', 'Set de 5 herramientas de jardín', 1, 3, 'https://ejemplo.com/herramientas1.jpg', 35.00, 18),
('ART056', 'Aspiradora Dyson', 'Aspiradora inalámbrica potente', 1, 3, 'https://ejemplo.com/aspiradora1.jpg', 200.00, 5),
('ART057', 'Lavadora Samsung', 'Lavadora automática 8kg', 2, 3, 'https://ejemplo.com/lavadora1.jpg', 400.00, 3),
('ART058', 'Secadora LG', 'Secadora de ropa 7kg', 7, 3, 'https://ejemplo.com/secadora1.jpg', 350.00, 2),
('ART059', 'Refrigerador Samsung', 'Refrigerador de dos puertas 300L', 2, 3, 'https://ejemplo.com/refrigerador1.jpg', 600.00, 2),
('ART060', 'Microondas Panasonic', 'Microondas 25L con grill', 17, 3, 'https://ejemplo.com/microondas1.jpg', 120.00, 8),

-- Deportes y Fitness (61-80)
('ART061', 'Pelota de Fútbol Nike', 'Pelota de fútbol oficial FIFA', 3, 4, 'https://ejemplo.com/pelota1.jpg', 30.00, 25),
('ART062', 'Raqueta de Tenis Wilson', 'Raqueta de tenis profesional', 1, 4, 'https://ejemplo.com/raqueta1.jpg', 80.00, 12),
('ART063', 'Pesas Ajustables', 'Set de pesas ajustables 20kg', 1, 4, 'https://ejemplo.com/pesas1.jpg', 150.00, 8),
('ART064', 'Cinta de Correr', 'Cinta de correr eléctrica plegable', 1, 4, 'https://ejemplo.com/cinta1.jpg', 300.00, 3),
('ART065', 'Bicicleta Estática', 'Bicicleta estática con monitor', 1, 4, 'https://ejemplo.com/bicicleta1.jpg', 250.00, 5),
('ART066', 'Yoga Mat', 'Colchoneta de yoga antideslizante', 1, 4, 'https://ejemplo.com/yoga1.jpg', 25.00, 40),
('ART067', 'Mancuernas de Hierro', 'Par de mancuernas 10kg cada una', 1, 4, 'https://ejemplo.com/mancuernas1.jpg', 60.00, 15),
('ART068', 'Cuerda para Saltar', 'Cuerda para saltar ajustable', 1, 4, 'https://ejemplo.com/cuerda1.jpg', 12.00, 50),
('ART069', 'Guantes de Boxeo', 'Guantes de boxeo de cuero', 1, 4, 'https://ejemplo.com/guantes2.jpg', 45.00, 18),
('ART070', 'Proteína en Polvo', 'Proteína whey 2kg sabor chocolate', 1, 4, 'https://ejemplo.com/proteina1.jpg', 35.00, 30),
('ART071', 'Botella Deportiva', 'Botella de acero inoxidable 750ml', 1, 4, 'https://ejemplo.com/botella1.jpg', 15.00, 60),
('ART072', 'Toalla Deportiva', 'Toalla de microfibra absorbente', 1, 4, 'https://ejemplo.com/toalla1.jpg', 10.00, 80),
('ART073', 'Cronómetro Deportivo', 'Cronómetro digital con memoria', 1, 4, 'https://ejemplo.com/cronometro1.jpg', 20.00, 35),
('ART074', 'Bandas de Resistencia', 'Set de 5 bandas de resistencia', 1, 4, 'https://ejemplo.com/bandas1.jpg', 18.00, 45),
('ART075', 'Balón de Baloncesto', 'Balón de baloncesto oficial NBA', 1, 4, 'https://ejemplo.com/balon1.jpg', 25.00, 20),
('ART076', 'Gafas de Natación', 'Gafas de natación antiniebla', 1, 4, 'https://ejemplo.com/gafas2.jpg', 15.00, 30),
('ART077', 'Gorro de Natación', 'Gorro de natación de silicona', 1, 4, 'https://ejemplo.com/gorro1.jpg', 8.00, 50),
('ART078', 'Tabla de Surf', 'Tabla de surf de espuma para principiantes', 1, 4, 'https://ejemplo.com/tabla1.jpg', 120.00, 6),
('ART079', 'Casco de Ciclismo', 'Casco de ciclismo con ventilación', 1, 4, 'https://ejemplo.com/casco1.jpg', 40.00, 15),
('ART080', 'Luces para Bicicleta', 'Set de luces LED para bicicleta', 1, 4, 'https://ejemplo.com/luces1.jpg', 12.00, 40),

-- Libros y Papelería (81-100)
('ART081', 'Libro de Programación', 'Libro "Clean Code" de Robert Martin', 1, 5, 'https://ejemplo.com/libro1.jpg', 35.00, 20),
('ART082', 'Cuaderno Universitario', 'Cuaderno universitario 200 hojas', 1, 5, 'https://ejemplo.com/cuaderno1.jpg', 8.00, 100),
('ART083', 'Bolígrafo Parker', 'Bolígrafo Parker de acero inoxidable', 1, 5, 'https://ejemplo.com/boligrafo1.jpg', 25.00, 50),
('ART084', 'Calculadora Científica', 'Calculadora científica Casio FX-991EX', 1, 5, 'https://ejemplo.com/calculadora1.jpg', 30.00, 25),
('ART085', 'Mochila Escolar', 'Mochila escolar con compartimento para laptop', 1, 5, 'https://ejemplo.com/mochila1.jpg', 45.00, 30),
('ART086', 'Estuche de Lápices', 'Estuche de lápices de colores 24 unidades', 1, 5, 'https://ejemplo.com/estuche1.jpg', 12.00, 60),
('ART087', 'Regla de 30cm', 'Regla de acrílico transparente 30cm', 1, 5, 'https://ejemplo.com/regla1.jpg', 3.00, 200),
('ART088', 'Goma de Borrar', 'Goma de borrar blanca sin migas', 1, 5, 'https://ejemplo.com/goma1.jpg', 2.00, 150),
('ART089', 'Tijeras de Oficina', 'Tijeras de oficina ergonómicas', 1, 5, 'https://ejemplo.com/tijeras1.jpg', 8.00, 40),
('ART090', 'Grapadora de Oficina', 'Grapadora de oficina con capacidad 20 hojas', 1, 5, 'https://ejemplo.com/grapadora1.jpg', 15.00, 25),
('ART091', 'Perforadora de 2 Agujeros', 'Perforadora de 2 agujeros ajustable', 1, 5, 'https://ejemplo.com/perforadora1.jpg', 12.00, 30),
('ART092', 'Cinta Adhesiva', 'Rollos de cinta adhesiva transparente', 1, 5, 'https://ejemplo.com/cinta2.jpg', 5.00, 80),
('ART093', 'Marcadores Permanentes', 'Set de 8 marcadores permanentes', 1, 5, 'https://ejemplo.com/marcadores1.jpg', 10.00, 50),
('ART094', 'Resaltadores', 'Set de 6 resaltadores fluorescentes', 1, 5, 'https://ejemplo.com/resaltadores1.jpg', 8.00, 60),
('ART095', 'Post-it Notes', 'Pack de 5 blocos de notas adhesivas', 1, 5, 'https://ejemplo.com/postit1.jpg', 6.00, 100),
('ART096', 'Carpeta de Archivo', 'Carpeta de archivo con separadores', 1, 5, 'https://ejemplo.com/carpeta1.jpg', 4.00, 120),
('ART097', 'Sobre Manila', 'Sobres de papel manila tamaño carta', 1, 5, 'https://ejemplo.com/sobre1.jpg', 3.00, 200),
('ART098', 'Clips de Oficina', 'Caja de clips de oficina metálicos', 1, 5, 'https://ejemplo.com/clips1.jpg', 2.00, 300),
('ART099', 'Engrapadora Manual', 'Engrapadora manual con grapas incluidas', 1, 5, 'https://ejemplo.com/engrapadora1.jpg', 7.00, 45),
('ART100', 'Libro de Cocina', 'Libro "Recetas del Mundo" ilustrado', 1, 5, 'https://ejemplo.com/libro2.jpg', 28.00, 15);
GO

/*
=====================================================
DATOS INICIALES CARGADOS
=====================================================

CATEGORÍAS CREADAS (10):
- Electrónicos, Ropa y Accesorios, Hogar y Jardín, Deportes y Fitness, 
  Libros y Papelería, Herramientas, Alimentos y Bebidas, Salud y Belleza, 
  Automotriz, Juguetes y Juegos

MARCAS CREADAS (50):
- HP, Samsung, Nike, Adidas, Apple, Sony, LG, Philips, Bosch, Black & Decker,
  Dell, Lenovo, Asus, Acer, Canon, Nikon, Panasonic, Toshiba, Intel, AMD,
  NVIDIA, Corsair, Logitech, Razer, SteelSeries, HyperX, Kingston, 
  Western Digital, Seagate, SanDisk, Puma, Reebok, Under Armour, 
  New Balance, Converse, Vans, Levi's, Calvin Klein, Tommy Hilfiger,
  Ralph Lauren, Gap, Zara, H&M, Uniqlo, Forever 21, Champion, Fila, 
  Kappa, Umbro, Diadora

USUARIOS CREADOS:
- admin / admin123 (Administrador)
- usuario / user123 (Vendedor)
- vendedor / vend123 (Vendedor)

ARTÍCULOS DE PRUEBA (100):
- 20 Electrónicos (laptops, mouses, teclados, monitores, etc.)
- 20 Ropa y Accesorios (camisas, pantalones, zapatillas, etc.)
- 20 Hogar y Jardín (sofás, mesas, lámparas, electrodomésticos, etc.)
- 20 Deportes y Fitness (pelotas, pesas, equipos de ejercicio, etc.)
- 20 Libros y Papelería (libros, cuadernos, útiles de oficina, etc.)

CARACTERÍSTICAS:
- Stock variado para probar el sistema de ventas
- Algunos artículos con stock 0 para probar validaciones
- Precios realistas y variados
- Descripciones detalladas
- Distribución equilibrada entre categorías

NOTA: Este archivo es opcional y solo para pruebas.
En producción, los datos se cargarán a través de la aplicación.
*/