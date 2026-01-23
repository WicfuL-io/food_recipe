<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include "../config/db.php";

$title = $_POST['title'];
$description = $_POST['description'];
$ingredients = $_POST['ingredients'];
$steps = $_POST['steps'];

$image = $_FILES['image']['name'];
$tmp = $_FILES['image']['tmp_name'];

$path = "../upload/" . $image;
move_uploaded_file($tmp, $path);

$conn->query("INSERT INTO recipes 
(title,description,ingredients,steps,image)
VALUES ('$title','$description','$ingredients','$steps','$image')");

echo json_encode(["status" => "success"]);
?>