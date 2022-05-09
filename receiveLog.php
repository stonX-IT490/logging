<?php

require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;

$date = date('m/d/Y H:i:s', time());
$exchange = $argv[1];
$queue = gethostname().'-'.$exchange;
$dir = "/var/logCentral/".$exchange;

$connection = new AMQPStreamConnection('broker', 5672, 'log', 'stonx_log', 'logHost');
$channel = $connection->channel();
//param
$channel->exchange_declare($exchange, 'fanout', false, true, false);

//param: queue,,durable,autodelete,
list($queue_name, ,) = $channel->queue_declare($queue, false, true, false, false);

$channel->queue_bind($queue_name, $exchange);

echo $date,' ',$queue," Receiver Started \n";

$callback = function ($msg) {
        global $exchange;
        $date = date('m/d/Y H:i:s', time());
        global $dir;
        global $queue;
        echo $date,' ',$queue,' RECEIVED ', $dir, "\n";
        $logFile = fopen($dir, 'a') or die('Cannot open file: '.$dir); 
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
