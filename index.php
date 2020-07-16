<?php 


header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
header('Access-Control-Allow-Methods: *');
header('Access-Control-Allow-Credentials: true');
header('Content-Type: application/json');

require 'connect.php';
require 'functions.php';
// getting request body
$post = json_decode(file_get_contents("php://input"), true);

$method = $_SERVER['REQUEST_METHOD'];
// defining a query string
$route = $_GET['q'];
// die(print_r($route));

$routArr = explode('/', $route);
$type = $routArr[0];
$param = $routArr[1];


if ($method === 'GET') {
    if ($param === 'messages') {
        getMessages($connect);
    };
    if ($param ==='delete') {
        deleteMessage($connect);
    };
} elseif ($method ==='POST') {
    if ($param === 'webhook') {
        addMessages($connect, $post);
    }
};


