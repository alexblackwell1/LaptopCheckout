<?php
	header('Access-Control-Allow-Origin: *');

        header('Access-Control-Allow-Methods: GET, POST');

        header("Access-Control-Allow-Headers: X-Requested-With");

	include "config.php";
	
	$student = $_POST["student"];

	if ($conn->connect_error) {
  		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "SELECT COUNT(*) FROM laptops WHERE student = '$student'";
	
	$result = $conn->query($query);

	$mad = 0;

	if ($result->num_rows > 0) {
                // output data of each row
                while($row = $result->fetch_assoc()) {
			$mad =  ($row["COUNT(*)"]);
			echo $mad;
                }
        }

	if (intval($mad) > 0) {
	        $query = "UPDATE `color` SET `c`='green'";

        	$result = $conn->query($query);
	}
	
	$conn->close();
?>
