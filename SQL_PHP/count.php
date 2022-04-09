<?php
	header('Access-Control-Allow-Origin: *');

	header('Access-Control-Allow-Methods: GET, POST');

	header("Access-Control-Allow-Headers: X-Requested-With");
	
	include "config.php";
	
	$query = "SELECT COUNT(*) FROM laptops WHERE student IS NULL";

	$result = $conn->query($query);

	if ($result->num_rows > 0) {
  		// output data of each row
  		while($row = $result->fetch_assoc()) {
			echo $row["COUNT(*)"];
			//echo "\"status\" : \"" . ($row["COUNT(*)"]) . "\"";
		}
	}
	$conn->close();
?>
