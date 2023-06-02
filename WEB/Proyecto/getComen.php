<?php
	$servidor="localhost";
	$usuario="root";
	$clave="";
	$baseDeDatos="elegance";

	$connection = mysqli_connect($servidor, $usuario, $clave, $baseDeDatos)
		or die("Conection Error");
 
	$getComen = "SELECT nombre, calificacion, fecha, mensaje FROM comentarios ORDER BY fecha DESC";
	$result = mysqli_query($connection, $getComen)
		or die ("Insert Error");
 
 
	$data = [];
	while($item = mysqli_fetch_array($result)) {
		$data[] = $item;
	    
	}
	echo json_encode($data);
?>