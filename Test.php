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
	'ExpressionAttributeValues' => [':v1' => ['S' => 'WeatherStation1']]
]);

file_put_contents('weatherdata.json', json_encode($response['Items']));

foreach ($response['Items'] as $key => $value) {
	echo $key . " => " . $value . PHP_EOL;
}

} catch (DynamoDbException $e) {
    echo $e->getMessage() . "\n";
    exit ("Unable to create table $tableName\n");
}

