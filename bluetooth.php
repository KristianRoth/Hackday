<?php 
require 'Aws/aws-autoloader.php';

try {
$sdk = new Aws\Sdk([
    'endpoint'   => 'https://dynamodb.eu-west-1.amazonaws.com/',
    'region'   => 'eu-west-1',
    'version'  => 'latest',
]);

$dynamodb = $sdk->createDynamoDb();

$response = $dynamodb->query([
	'TableName'=>'IoTData',
	'KeyConditionExpression' => 'deviceName = :v1 AND #timestamp > :vtime' ,
	'ExpressionAttributeNames' => ["#timestamp" => "timestamp"],
	'ExpressionAttributeValues' => [':v1' => ['S' => 'Bluetooth1'],
									':vtime' => ['S' => '1491046359394']]
]);
$marshaler = new Aws\DynamoDb\Marshaler();

$data = array();
foreach ($response['Items'] as $key => $value) {
	$item = array();
	$value = json_decode($marshaler->unmarshalJson($value));
	$item['timestamp'] = $value->timestamp;
	$item['devices'] = $value->data->state->reported->devices;
	if ($item['devices']) {
		$data[] = $item;
	}
}

$json = json_encode($data);
file_put_contents('bluetooth.json', $json);

echo $json;

} catch (DynamoDbException $e) {
    echo $e->getMessage() . "\n";
    exit ("Unable to create table $tableName\n");
}

