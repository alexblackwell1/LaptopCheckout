<?php
	header("refresh: 3");

	echo "<!DOCTYPE html>
<html>
<head>
<style>
body {
  background-color: ";

	include "config.php";

        $query = "SELECT * FROM color";

        $result = $conn->query($query);

        if ($result->num_rows > 0) {
                // output data of each row
                while($row = $result->fetch_assoc()) {
                        echo $row["c"];
                }
        }
        $conn->close();
	
	echo ";
}
</style>
</head>
<body>

</body>
</html>";

?>
