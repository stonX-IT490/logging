<?php

require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

$exchange = $argv[1];
$queue = gethostname().'-'.$exchange;
$dir = '/var/log/'.$exchange;

$connection = new AMQPStreamConnection('broker', 5672, 'log', 'stonx_log', 'logHost');
$channel = $connection->channel();

$channel->exchange_declare($exchange, 'fanout', false, true, false);
$channel->queue_declare($queue, false, false, false, false);

$file = escapeshellarg( $dir );
$last_line = `tail -n 1 $file`;

$msg = new AMQPMessage($last_line);

$channel->basic_publish($msg, $exchange);

$date = date('m/d/Y H:i:s', time());

echo $date,' ',$queue,' SENT ', $dir, "\n";
$channel->close();
$connection->close();

?>
