<?php
include "../config/db.php";

$title = $_POST['title'];
$description = $_POST['description'];
$ingredients = $_POST['ingredients'];
$steps = $_POST['steps'];

$imageName = time() . "_" . $_FILES['image']['name'];
$path = "../upload/" . $imageName;

move_uploaded_file($_FILES['image']['tmp_name'], $path);

$sql = "INSERT INTO recipes 
(title, description, ingredients, steps, image)
VALUES
('$title','$description','$ingredients','$steps','$imageName')";

if ($conn->query($sql)) {
    echo json_encode(["status" => true]);
} else {
    echo json_encode(["status" => false]);
}
