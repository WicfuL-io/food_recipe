<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include "../config/db.php";
$id = $_POST['id'];
$conn->query("DELETE FROM recipes WHERE id=$id");

echo json_encode(["status" => "success"]);
?>