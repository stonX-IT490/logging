<?php

require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

$exchange = $argv[1];
$dir = '/var/log/'.$exchange;

$connection = new AMQPStreamConnection('10.4.90.102', 5672, 'log', 'stonx_log', 'logHost');
$channel = $connection->channel();

$channel->exchange_declare(logs, 'fanout', false, false, false);

$file = escapeshellarg( $dir );
$last_line = `tail -n 1 $file`;

$msg = new AMQPMessage($last_line);

$channel->basic_publish($msg, $exchange);

echo ' [x] Sent ', $dir, "\n";
$channel->close();
$connection->close();

?>