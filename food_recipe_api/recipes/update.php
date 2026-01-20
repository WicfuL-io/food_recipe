<?php
include "../config/db.php";

$id = $_POST['id'];
$title = $_POST['title'];
$description = $_POST['description'];
$ingredients = $_POST['ingredients'];
$steps = $_POST['steps'];

if (!empty($_FILES['image']['name'])) {
  $image = $_FILES['image']['name'];
  move_uploaded_file($_FILES['image']['tmp_name'], "../upload/$image");
  $conn->query("UPDATE recipes SET image='$image' WHERE id=$id");
}

$conn->query("UPDATE recipes SET
title='$title',
description='$description',
ingredients='$ingredients',
steps='$steps'
WHERE id=$id");
