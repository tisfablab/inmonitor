<?php
//error_reporting(E_ALL); ini_set('display_errors', '1');

header("Content-Type: application/xml; charset=UTF-8");

include("_db.php");
$mysqli = new mysqli($DB_SERVER, $DB_USER, $DB_PASSWD, $DB_DATABASE);

$query = "SELECT d1.device_id as device, d1.temperature as temperature, 
	d1.humidity as humidity, d1.pressure as pressure, d1.illuminance as illuminance
	FROM data d1 
	WHERE d1.timestamp=(SELECT d2.timestamp FROM data d2 
		WHERE d2.device_id=d1.device_id ORDER BY d2.timestamp DESC LIMIT 1
	)";
//echo "<pre>$query</pre>\n";
$result = $mysqli->query($query);

$output = "<inmonitor>\n";

if ($mysqli->affected_rows>0)
{
	while ($row = $result->fetch_array(MYSQLI_ASSOC))
	{	
		$output .= "\t<device id=\"${row[device]}\">\n";
		foreach ($row as $key=>$value)
		{
			if ($key!="device") $output .= "\t\t<$key>$value</$key>\n";
		}
		$output .= "\t</device>\n";
	}
}

$output .= "</inmonitor>";
echo $output;

$mysqli->close();

?>
