CAMBIO: PEDIDOS Y COBROS CENTRALIZADOS

- Pedidos es ahora el centro de gestión.
- Cada pedido permite: Ver pedido, Editar, Ver nota/documento, marcar Cobrado/Pendiente y Eliminar.
- Ya no se crean registros en bonilla_delivery_notes al guardar o editar pedidos.
- Se elimina del menú y del flujo la sección independiente de Notas de entrega.
- El documento imprimible se genera directamente desde el pedido mediante pedido_documento.php.
- Cobros usa bonilla_orders.payment_status, payment_date y payment_method.
- Control de cobros muestra: Pendiente de cobro, Cobrado, Precio Producto, Ganancias Estimadas y Ganancias Reales.
- Ganancias estimadas = total del pedido - coste de los productos.
- Ganancias reales = total - coste solamente de pedidos ya cobrados.
- Se añade protección contra doble envío para evitar crear dos pedidos por doble clic/refresco del formulario.
- Se añade columna discount en bonilla_orders y se conserva IVA/estado de pago.
- Los registros antiguos de bonilla_delivery_notes no se usan para calcular cobros.
