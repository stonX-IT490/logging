<?php

require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;

$exchange = $argv[1];

$connection = new AMQPStreamConnection('10.4.90.102', 5672, 'log', 'stonx_log', 'logHost');
$channel = $connection->channel();
//param
$channel->exchange_declare($exchange, 'fanout', false, false, false);

//param: queue,,durable,autodelete,
list($queue_name, ,) = $channel->queue_declare('log', false, true, false, false);

$channel->queue_bind($queue_name, $exchange);

echo " [*] Waiting for logs. To exit press CTRL+C\n";


$callback = function ($msg) {
        echo ' [x] Received ', "\n";
        global $exchange;
        $file_name = "/var/logCentral/".$exchange;
        echo $file_name;
        $logFile = fopen($file_name, 'a') or die('Cannot open file: '.$file_name); 
        fwrite($logFile, $msg->body);
        fclose($logFile);

};

$channel->basic_consume($queue_name, '', false, true, false, false, $callback);

while ($channel->is_open()) {
    $channel->wait();
}

$channel->close();
$connection->close();
?>