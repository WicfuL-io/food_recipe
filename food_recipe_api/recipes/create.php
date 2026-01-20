<?php

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
