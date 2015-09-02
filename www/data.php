<?php
//error_reporting(E_ALL); ini_set('display_errors', '1');

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include("_db.php");
$mysqli = new mysqli($DB_SERVER, $DB_USER, $DB_PASSWD, $DB_DATABASE);

if (empty($_REQUEST['device'])) $_REQUEST['device']="0";
$device = $mysqli->escape_string($_REQUEST['device']);

// last values

$data = array();

if (!empty($device)) {
	$query = "SELECT 1 as devices, 1000*UNIX_TIMESTAMP(timestamp) as timestamp, temperature, humidity, pressure, illuminance 
		FROM data WHERE device_id=\"${device}\" ORDER BY timestamp DESC LIMIT 1";
		$result = $mysqli->query($query);
		if ($mysqli->affected_rows>0)
		{
			$row = $result->fetch_array(MYSQLI_ASSOC); 
			$data = array_merge($data, $row);
			$time = $data['timestamp'];
		}	
}
elseif (empty($DB_CLOUDSERVER)) {
	// get realtime data
	$data = json_decode(file_get_contents('http://localhost:2222/'), true);
	if (!empty($data)) $data['timestamp']=time()*1000;
	$data['devices'] = -1;
}
else {
	$query = "SELECT COUNT(d1.timestamp) as devices, MAX(1000*UNIX_TIMESTAMP(d1.timestamp)) as timestamp, AVG(d1.temperature) as temperature, 
		AVG(d1.humidity) as humidity, AVG(d1.pressure) as pressure, AVG(d1.illuminance) as illuminance
		FROM data d1 
		WHERE d1.timestamp=(SELECT d2.timestamp FROM data d2 
			WHERE d2.device_id=d1.device_id 
			AND d2.timestamp>=DATE_SUB(NOW(), INTERVAL 24 HOUR
			ORDER BY d2.timestamp DESC LIMIT 1
		)";
		$data = array('timestamp'=>time()*1000, 'devices'=>0);
}

// 24h- statistics

$query = "SELECT device_id as device, COUNT(temperature) as 24hdatasets,
	AVG(temperature) AS temperature_average, MIN(temperature) AS temperature_minimum, MAX(temperature) AS temperature_maximum, 
	AVG(humidity) AS humidity_average, MIN(humidity) AS humidity_minimum, MAX(humidity) AS humidity_maximum,
	AVG(pressure) AS pressure_average, MIN(pressure) AS pressure_minimum, MAX(pressure) AS pressure_maximum,
	AVG(illuminance) AS illuminance_average, MIN(illuminance) AS illuminance_minimum, MAX(illuminance) AS illuminance_maximum
	FROM data 
	WHERE temperature>0 AND humidity>0 AND pressure>0 AND illuminance>0 ";
$query .= "AND timestamp>=DATE_SUB(FROM_UNIXTIME(".($data['timestamp']/1000)."), INTERVAL 24 HOUR) ";
if (!empty($device)) $query .= "AND device_id=\"${device}\" ";
$query .= "GROUP BY device_id";
//print $query;
$result = $mysqli->query($query);
if ($mysqli->affected_rows>0)
{
	$row = $result->fetch_array(MYSQLI_ASSOC); 
	$data = array_merge($data, $row);
}

echo json_encode($data);

$mysqli->close();

?>
