<?php
	header('Access-Control-Allow-Origin: *');

        header('Access-Control-Allow-Methods: GET, POST');

        header("Access-Control-Allow-Headers: X-Requested-With");

	include "config.php";
	
	$student = $_POST["student"];

	if ($conn->connect_error) {
  		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "INSERT INTO userSwipe (student) VALUES('$student')";
	
	$result = $conn->query($query);
		
	$query = "UPDATE `color` SET `c`='green'";

        $result = $conn->query($query);

	$conn->close();
?>
