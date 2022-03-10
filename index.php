<?php
echo "Inside K8s with MySQL \n";
$MYSQL_HOST = getenv("MYSQL_HOST");
echo "Your HOST is " . $MYSQL_HOST ."\n";
$MYSQL_PORT = getenv("MYSQL_PORT");
echo "Your port is " . $MYSQL_PORT ."\n";
$MYSQL_USER = getenv("MYSQL_USER");
echo "Your user is " . $MYSQL_USER."\n";
$MYSQL_PASSWORD = getenv("MYSQL_PASSWORD");
echo "Your pwd is " . $MYSQL_PASSWORD ."\n";
$MYSQL_DB= getenv("MYSQL_DB");
echo 'db is '. $MYSQL_DB ."\n" ;


echo "Connection to Database with all you credentials start ...." ;
$conn = new mysqli($MYSQL_HOST .':' . $MYSQL_PORT  , $MYSQL_USER ,$MYSQL_PASSWORD , $MYSQL_DB);
// Check connection
if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
//echo 'KO connections' ;
}

echo "Good connection is ok !\n";

$sql = "SELECT name FROM users";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
                echo $row['name']."<br>";
        }
} else {
        echo "0 results\n";
}
echo "the end \n" ;
$conn->close();


