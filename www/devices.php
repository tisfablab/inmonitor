<?php
//error_reporting(E_ALL); ini_set('display_errors', '1');

$ALIVE = "24 HOUR";

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include("_db.php");
$mysqli = new mysqli($DB_SERVER, $DB_USER, $DB_PASSWD, $DB_DATABASE);

$result = $mysqli->query("SELECT ID as id, private_ip, last_ip FROM devices WHERE last_conn>=DATE_SUB(NOW(), INTERVAL ${ALIVE}) ORDER BY ID");

$output = "[";
if ($mysqli->affected_rows>0) while($row = $result->fetch_array(MYSQLI_ASSOC)) 
{
	if ($output != "[") {$output .= ",";}
	$output .= '{ "id":"'.$row['id'].'"'; 
	if ($row['last_ip']==$_SERVER['REMOTE_ADDR']) $output .= ',"ip":"'.$row['private_ip'].'"';
	$output .= ' }';
}
$output .= "]";

$mysqli->close();
echo $output;

?>
