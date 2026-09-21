<?php
$config = require __DIR__ . '/config/database.php';

try {
    $pdo = new PDO(
        'mysql:host=' . $config['host'] .
        ';dbname=' . $config['dbname'] .
        ';charset=' . $config['charset'],
        $config['user'],
        $config['pass'],
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        ]
    );

    echo "CONEXIÓN CORRECTA<br>";
    echo "Base de datos: " . htmlspecialchars($config['dbname']);

} catch (Throwable $e) {
    echo "<h2>Error de conexión</h2>";
    echo "<pre>" . htmlspecialchars($e->getMessage()) . "</pre>";
}