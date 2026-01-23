<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "../config/db.php";

$id          = $_POST['id'];
$title       = $_POST['title'];
$description = $_POST['description'];
$ingredients = $_POST['ingredients'];
$steps       = $_POST['steps'];

if (!empty($_FILES['image']['name'])) {
    $ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
    $image = time() . "." . $ext;
    move_uploaded_file($_FILES['image']['tmp_name'], "../upload/$image");

    $stmt = $conn->prepare(
        "UPDATE recipes 
         SET title=?, description=?, ingredients=?, steps=?, image=?
         WHERE id=?"
    );
    $stmt->bind_param("sssssi", $title, $description, $ingredients, $steps, $image, $id);
} else {
    $stmt = $conn->prepare(
        "UPDATE recipes 
         SET title=?, description=?, ingredients=?, steps=?
         WHERE id=?"
    );
    $stmt->bind_param("ssssi", $title, $description, $ingredients, $steps, $id);
}

$stmt->execute();
echo json_encode(["status" => "success"]);
