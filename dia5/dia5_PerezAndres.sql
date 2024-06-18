use dia3;

-- 1.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pago.codigo_cliente IS NULL;

-- 2.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.codigo_cliente IS NULL;

-- 3.Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pago.codigo_cliente IS NULL OR pedido.codigo_cliente IS NULL;

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE oficina.codigo_oficina IS NULL;

-- 5.Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT empleado.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_cliente IS NULL;

-- 6.Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
SELECT empleado.*, oficina.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.codigo_cliente IS NULL;

-- 7.Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE oficina.codigo_oficina IS NULL OR cliente.codigo_cliente IS NULL;

-- 8.Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT producto.*
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

-- 9.Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, 
-- la descripción y la imagen del producto.
SELECT producto.nombre, producto.descripcion, gama_producto.imagen
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
INNER JOIN gama_producto ON producto.gama = gama_producto.gama
WHERE detalle_pedido.codigo_producto IS NULL;

-- 10.Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas 
-- de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT DISTINCT oficina.*
FROM oficina
LEFT JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
LEFT JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
WHERE producto.gama = 'frutales' AND cliente.codigo_cliente IS NULL;

-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT DISTINCT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pedido.codigo_cliente IS NOT NULL AND pago.codigo_cliente IS NULL;

-- 12.Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT e1.codigo_empleado, e1.nombre, e1.apellido1, e1.apellido2, 
       e2.nombre AS nombre_jefe, e2.apellido1 AS apellido_jefe
FROM empleado e1
LEFT JOIN cliente c ON e1.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
WHERE c.codigo_cliente IS NULL;


-- Consultas resumen

-- 1.¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) AS total_empleados FROM empleado;

-- 2.¿Cuántos clientes tiene cada país?
SELECT pais, COUNT(*) AS total_clientes 
FROM cliente 
GROUP BY pais;

-- 3.¿Cuál fue el pago medio en 2009?
SELECT AVG(total) AS pago_medio_2009 
FROM pago 
WHERE YEAR(fecha_pago) = 2009;

-- 4.¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado, COUNT(*) AS total_pedidos 
FROM pedido 
GROUP BY estado 
ORDER BY total_pedidos DESC;

-- 5.Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(precio_venta) AS max_precio, MIN(precio_venta) AS min_precio 
FROM producto;

-- 6.Calcula el número de clientes que tiene la empresa.
SELECT COUNT(*) AS total_clientes FROM cliente;

-- 7.¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
SELECT COUNT(*) AS total_clientes_madrid 
FROM cliente 
WHERE ciudad = 'Madrid';

-- 8.¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT ciudad, COUNT(*) AS total_clientes 
FROM cliente 
WHERE ciudad LIKE 'M%' 
GROUP BY ciudad;

-- 9.Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS total_clientes 
FROM empleado e 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
GROUP BY e.codigo_empleado;

-- 10.Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(*) AS total_sin_representante 
FROM cliente 
WHERE codigo_empleado_rep_ventas IS NULL;

-- 11.Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
-- El listado deberá mostrar el nombre y los apellidos de cada cliente.
SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, 
       MIN(p.fecha_pago) AS primer_pago, MAX(p.fecha_pago) AS ultimo_pago
FROM cliente c 
JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.codigo_cliente;

-- 12.Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS total_productos 
FROM detalle_pedido 
GROUP BY codigo_pedido;

-- 13.Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT codigo_pedido, SUM(cantidad) AS total_cantidad 
FROM detalle_pedido 
GROUP BY codigo_pedido;

-- 14.Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
-- El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT p.codigo_producto, p.nombre, SUM(dp.cantidad) AS total_unidades 
FROM producto p 
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto 
GROUP BY p.codigo_producto 
ORDER BY total_unidades DESC 
LIMIT 20;

-- 15.La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
-- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
-- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT 
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS iva,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp;

-- 16.La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT 
    dp.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS iva,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
GROUP BY dp.codigo_producto;

-- 17.La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
SELECT 
    dp.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS iva,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
WHERE dp.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;

-- 18.Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, 
-- total facturado y total facturado con impuestos (21% IVA).
SELECT 
    p.nombre,
    SUM(dp.cantidad) AS total_unidades,
    SUM(dp.cantidad * dp.precio_unidad) AS total_facturado,
    SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado_con_iva
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.codigo_producto
HAVING total_facturado > 3000;

-- 19.Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
SELECT 
    YEAR(fecha_pago) AS anio, 
    SUM(total) AS total_pagos 
FROM pago 
GROUP BY anio;

-- Subconsultas con operadores básicos de comparación

-- 1.Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente 
FROM cliente 
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

-- 2.Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre 
FROM producto 
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

-- 3.Devuelve el nombre del producto del que se han vendido más unidades.
SELECT p.nombre 
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.codigo_producto
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

-- 4.Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
SELECT nombre_cliente 
FROM cliente c
WHERE limite_credito > (SELECT SUM(total) FROM pago WHERE codigo_cliente = c.codigo_cliente);

-- 5.Devuelve el producto que más unidades tiene en stock.
SELECT nombre 
FROM producto 
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

-- 6.Devuelve el producto que menos unidades tiene en stock.
SELECT nombre 
FROM producto 
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

-- 7.Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT e2.nombre, e2.apellido1, e2.apellido2, e2.email 
FROM empleado e1 
JOIN empleado e2 ON e1.codigo_empleado = e2.codigo_jefe 
WHERE e1.nombre = 'Alberto' AND e1.apellido1 = 'Soria';

-- Subconsultas con ALL y ANY
-- 8.Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente 
FROM cliente 
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);

-- 9.Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre 
FROM producto 
WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);

-- 10.Devuelve el producto que menos unidades tiene en stock.
SELECT nombre 
FROM producto 
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM producto);

-- Subconsultas con IN y NOT IN
-- 11.Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT e.nombre, e.apellido1, e.puesto 
FROM empleado e 
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

-- 12.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT * 
FROM cliente 
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

-- 13.Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT * 
FROM cliente 
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);

-- 14.Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * 
FROM producto 
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

-- 15.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono 
FROM empleado e 
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

-- 16.Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún 
-- cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT * 
FROM oficina 
WHERE codigo_oficina NOT IN (
    SELECT e.codigo_oficina 
    FROM empleado e 
    JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
    JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
    JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido 
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto 
    WHERE pr.gama = 'Frutales'
);

-- 17.Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT * 
FROM cliente 
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pedido)
  AND codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);


-- Subconsultas con EXISTS y NOT EXISTS
-- 18.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT * 
FROM cliente c 
WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE c.codigo_cliente = p.codigo_cliente);

-- 19.Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT * 
FROM cliente c 
WHERE EXISTS (SELECT 1 FROM pago p WHERE c.codigo_cliente = p.codigo_cliente);

-- 20.Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * 
FROM producto p 
WHERE NOT EXISTS (SELECT 1 FROM detalle_pedido dp WHERE p.codigo_producto = dp.codigo_producto);

-- 21.Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT * 
FROM producto p 
WHERE EXISTS (SELECT 1 FROM detalle_pedido dp WHERE p.codigo_producto = dp.codigo_producto);

-- Consultas variadas
-- 1.Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS total_pedidos 
FROM cliente c 
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.codigo_cliente;

-- 2.Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
SELECT c.nombre_cliente, SUM(p.total) AS total_pagado 
FROM cliente c 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.codigo_cliente;

-- 3.Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT DISTINCT c.nombre_cliente 
FROM cliente c 
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
WHERE YEAR(p.fecha_pedido) = 2008 
ORDER BY c.nombre_cliente;

-- 4.Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono 
-- de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.telefono 
FROM cliente c 
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

-- 5.Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su 
-- representante de ventas y la ciudad donde está su oficina.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c 
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 6.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono 
FROM empleado e 
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

-- 7.Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT o.ciudad, COUNT(e.codigo_empleado) AS total_empleados 
FROM oficina o 
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
GROUP BY o.ciudad;
