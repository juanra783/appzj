<?php
require __DIR__.'/config/database.php';
$id=(int)($_GET['id']??0);
$q=$pdo->prepare('SELECT o.*,c.business_name,c.address,c.phone FROM bonilla_orders o LEFT JOIN bonilla_clients c ON c.id=o.client_id WHERE o.id=?');
$q->execute([$id]);$o=$q->fetch();
if(!$o){http_response_code(404);exit('Pedido no encontrado');}
$q=$pdo->prepare('SELECT * FROM bonilla_order_items WHERE order_id=? ORDER BY id ASC');$q->execute([$id]);$items=$q->fetchAll();
function h($v){return htmlspecialchars((string)$v,ENT_QUOTES,'UTF-8');}
function m($v){return number_format((float)$v,2,',','.').' €';}
$discount=(float)($o['discount']??0);
$paid=(($o['payment_status']??'pendiente')==='cobrado');
?><!doctype html><html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Albarán <?=h($o['albaran_number']??('Alb-'.$o['id']))?></title><style>
body{font-family:Arial,sans-serif;color:#172033;max-width:850px;margin:35px auto;padding:20px;background:#fff}header{display:flex;justify-content:space-between;gap:20px;border-bottom:4px solid #d71920;padding-bottom:18px}img{width:220px;max-height:100px;object-fit:contain}.box{background:#f4f6f8;padding:18px;margin:22px 0;border-radius:10px}.meta{display:grid;grid-template-columns:1fr 1fr;gap:12px}.meta strong{display:block}.status{display:inline-block;padding:7px 12px;border-radius:999px;background:#eef1f5}.paid{background:#dff7e8;color:#147a3d}.pending{background:#fff1d7;color:#9a6500}table{width:100%;border-collapse:collapse}th,td{padding:12px;border-bottom:1px solid #ddd;text-align:left}th{background:#172033;color:white}.total{text-align:right;font-size:20px;font-weight:bold;margin-top:20px;line-height:1.7}.firma{display:flex;gap:80px;margin-top:80px}.firma div{border-top:1px solid #555;width:40%;padding-top:10px}button{margin-top:25px;padding:12px 18px;border:0;border-radius:8px;background:#172033;color:white;cursor:pointer}@media print{button{display:none}body{margin:0;max-width:none}.firma{margin-top:60px}}
</style></head><body><header><img src="assets/logo-zq.png" alt="ZJ Distribuidor"><div><h1>Albarán</h1><b><?=h($o['albaran_number']??('Alb-'.$o['id']))?></b><br>Pedido #<?=h($o['id'])?><br><?=h($o['order_date'])?></div></header>
<div class="box"><div class="meta"><div><strong>Cliente</strong><?=h($o['business_name'])?><br><?=h($o['address'])?><br><?=h($o['phone'])?></div><div><strong>Estado de cobro</strong><span class="status <?=$paid?'paid':'pending'?>"><?=$paid?'Cobrado':'Pendiente de cobro'?></span><?php if($paid && !empty($o['payment_date'])):?><br>Fecha: <?=h($o['payment_date'])?><?php endif;?></div></div></div>
<table><tr><th>Producto</th><th>Cantidad</th><th>Precio</th><th>IVA</th><th>Importe</th></tr><?php foreach($items as $i):?><tr><td><?=h($i['product_name'])?></td><td><?=h($i['quantity'])?></td><td><?=m($i['unit_price'])?></td><td><?=h($i['vat'])?>%</td><td><?=m($i['quantity']*$i['unit_price'])?></td></tr><?php endforeach;?></table>
<div class="total">Subtotal: <?=m($o['subtotal'])?><br><?php if($discount>0):?>Descuento: -<?=m($discount)?><br><?php endif;?>IVA: <?=m($o['vat_total'])?><br>Total: <?=m($o['total'])?></div>
<?php if(!empty($o['notes'])):?><div class="box"><strong>Observaciones</strong><br><?=nl2br(h($o['notes']))?></div><?php endif;?>
<div class="firma"><div>Firma del cliente</div><div>Firma representante</div></div><button onclick="window.print()">Imprimir / guardar PDF</button></body></html>
