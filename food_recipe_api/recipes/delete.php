<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "../config/db.php";

$id = $_POST['id'] ?? 0;

$stmt = $conn->prepare("DELETE FROM recipes WHERE id=?");
$stmt->bind_param("i", $id);
$stmt->execute();

echo json_encode(["status" => "success"]);
