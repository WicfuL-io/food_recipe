<?php
$conn = new mysqli("localhost", "root", "", "food_recipe");

if ($conn->connect_error) {
    die(json_encode([
        "status" => false,
        "message" => "Database connection failed"
    ]));
}
