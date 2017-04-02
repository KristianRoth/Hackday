<?php

require('../Aws/aws-autoloader.php');
if(getRfid()) {
	file_put_contents('../Aika/lasttime.txt', '0');
	echo "ghost";
} else {
	echo "no ghost";
}


function getRfid() {

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
		$item['devices'] = $value->data->state->reported->token;
		if ($item['devices']) {
			$data[] = $item;
		}
	}

	if (intval(file_get_contents('movement')) < intval(end($data)['timestamp'])) {
		return false;
	} else {
		return true;
	}


	} catch (DynamoDbException $e) {
	    echo $e->getMessage() . "\n";
	    exit ("Unable to create table $tableName\n");
	}
}