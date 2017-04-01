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
	'KeyConditionExpression' => 'deviceName = :v1',
	'ExpressionAttributeValues' => [':v1' => ['S' => 'RFID1']]
]);
$marshaler = new Aws\DynamoDb\Marshaler();

$data = array();
foreach ($response['Items'] as $key => $value) {
	$item = array();
	$value = json_decode($marshaler->unmarshalJson($value));

	$item['timestamp'] = $value->timestamp;
	$item['token'] = $value->data->current->state->reported->token;
	if ($item['token']) {
		$data[] = $item;
	}
}

$json = json_encode($data);
file_put_contents('RFID.json', $json);

echo $json;

} catch (DynamoDbException $e) {
    echo $e->getMessage() . "\n";
    exit ("Unable to create table $tableName\n");
}

