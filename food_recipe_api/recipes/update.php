<?php
include "../config/db.php";

$id = $_POST['id'];
$title = $_POST['title'];
$description = $_POST['description'];
$ingredients = $_POST['ingredients'];
$steps = $_POST['steps'];

if (!empty($_FILES['image']['name'])) {
    $imageName = time() . "_" . $_FILES['image']['name'];
    move_uploaded_file($_FILES['image']['tmp_name'], "../upload/".$imageName);
    $conn->query("UPDATE recipes SET image='$imageName' WHERE id=$id");
}

$sql = "UPDATE recipes SET
title='$title',
description='$description',
ingredients='$ingredients',
steps='$steps'
WHERE id=$id";

$conn->query($sql);
echo json_encode(["status" => true]);
