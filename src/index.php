<?php
declare(strict_types=1);

date_default_timezone_set('Asia/Tokyo');

$message = 'Hello from Apache + PHP 7.2 Docker';
$phpVersion = PHP_VERSION;
$time = date('Y-m-d H:i:s');
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Ngocuy dep trai</title>
</head>
<body>
    <h1><?= htmlspecialchars($message, ENT_QUOTES, 'UTF-8') ?></h1>
    <p>PHP version: <?= htmlspecialchars($phpVersion, ENT_QUOTES, 'UTF-8') ?></p>
    <p>Current time: <?= htmlspecialchars($time, ENT_QUOTES, 'UTF-8') ?></p>
</body>
</html>