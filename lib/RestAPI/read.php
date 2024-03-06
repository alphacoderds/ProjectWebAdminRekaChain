<?php
$conn=new mysqli("localhost","root","","db_rekachain");
$query=mysqli_query($conn,"select * from project");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);

?>
