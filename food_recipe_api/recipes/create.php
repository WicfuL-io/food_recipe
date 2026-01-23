<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include "../config/db.php";

$title       = $_POST['title'] ?? '';
$description = $_POST['description'] ?? '';
$ingredients = $_POST['ingredients'] ?? '';
$steps       = $_POST['steps'] ?? '';

if ($title == '' || $description == '') {
    echo json_encode(["status" => "error", "message" => "Data tidak lengkap"]);
    exit;
}

$imageName = "";
if (!empty($_FILES['image']['name'])) {
    $ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
    $imageName = time() . "." . $ext;
    move_uploaded_file($_FILES['image']['tmp_name'], "../upload/$imageName");
}

$stmt = $conn->prepare(
    "INSERT INTO recipes (title, description, ingredients, steps, image)
     VALUES (?, ?, ?, ?, ?)"
);
$stmt->bind_param("sssss", $title, $description, $ingredients, $steps, $imageName);
$stmt->execute();

echo json_encode(["status" => "success"]);
