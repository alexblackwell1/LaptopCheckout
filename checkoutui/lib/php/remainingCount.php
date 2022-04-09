<?php
header('Content-Type: application/json');
include "../flutter_api/db.php";

echo "statPHP";

$stmt = $db->prepare("SELECT COUNT(*) FROM laptops WHERE student IS NULL");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>