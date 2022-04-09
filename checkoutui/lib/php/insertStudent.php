<?php
header('Content-Type: application/json');
include "../flutter_api/db.php";


$studentID = $_POST['id'];

$stmt = $db->prepare("INSERT INTO userSwipe(student) VALUES $studentID");
$result = $stmt->execute([$studentID]);

echo json_encode([
'success' => $result
]);

?>