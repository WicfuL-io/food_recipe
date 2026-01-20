<?php

$host = "localhost";
$user = "root";
$pass = "";
$db   = "food_recipe";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Koneksi database gagal");
}
?>
