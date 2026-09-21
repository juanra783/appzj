<?php
$config = require __DIR__ . '/config/database.php';

try {
    $pdo = new PDO(
        'mysql:host=' . $config['host'] .
        ';dbname=' . $config['dbname'] .
        ';charset=' . $config['charset'],
        $config['user'],
        $config['pass'],
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );

    echo "<h2>Comprobación de Bonilla</h2>";

    $tables = [
        'bonilla_clients',
        'bonilla_products',
        'bonilla_orders',
        'bonilla_order_items'
    ];

    foreach ($tables as $table) {
        try {
            $count = $pdo->query("SELECT COUNT(*) FROM `$table`")->fetchColumn();
            echo "✅ $table → $count registros<br>";
        } catch (Throwable $e) {
            echo "❌ $table → " . htmlspecialchars($e->getMessage()) . "<br>";
        }
    }

} catch (Throwable $e) {
    echo "<h2>Error</h2><pre>" . htmlspecialchars($e->getMessage()) . "</pre>";
}