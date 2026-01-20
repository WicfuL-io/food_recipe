<?php
include "../config/db.php";
$id = $_POST['id'];
$conn->query("DELETE FROM recipes WHERE id=$id");
