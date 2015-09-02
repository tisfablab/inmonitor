<?php

$INTERVAL = "5 MINUTE"; 
$DEBUG = 0;
$error = 1;

include("_db.php");
$mysqli = new mysqli($DB_SERVER, $DB_USER, $DB_PASSWD, $DB_DATABASE);

if ($mysqli->connect_errno) 
{
    if ($DEBUG) echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
else
{
	foreach (array('device', 'password', 'temperature', 'humidity', 'pressure', 'illuminance', 'localaddr') as $x)
	{
		${$x} = $mysqli->escape_string($_REQUEST[$x]);
	}
	$query = "UPDATE devices 
		SET private_ip=\"$localaddr\", last_ip=\"${_SERVER['REMOTE_ADDR']}\", last_conn=CURRENT_TIMESTAMP() 
		WHERE ID=\"$device\" AND password=MD5(\"$password\")
		AND last_conn <= DATE_SUB(NOW(), INTERVAL ${INTERVAL})
	";
	//echo $query;
	$mysqli->query($query);
	if ( $mysqli->affected_rows>0 )
	{
		if ($DEBUG) echo "auth ok\n";
		$mysqli->query("INSERT INTO data (device_id, timestamp, temperature, humidity, pressure, illuminance) 
			VALUES (\"$device\", CURRENT_TIMESTAMP(), \"$temperature\", \"$humidity\", \"$pressure\", \"$illuminance\")
		");
		if ( $mysqli->affected_rows>0 )
		{
			if ($DEBUG) echo "insert ok\n";
			$error = 0;
		}
	}
}

if ($error) header("HTTP/1.1 400 Bad Request");
else header("HTTP/1.1 200 OK");
header('Content-Type: text/plain');
echo ( $error ? "FAILED" : "OK" );

?>
