
<?php

$db_name = "LaptopCheckout";
$db_server = "192.168.1.2";
$db_user = "root";
$db_pass = "blics101";

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

?>