<?php
if (empty($_POST["nombre"])) {
    exit("Falta el nombre");
}

if (empty($_POST["email"])) {
    exit("Falta el correo");
}

if (empty($_POST["calificacion"])) {
    exit("Falta la calificacion");
}

if (empty($_POST["mensaje"])) {
    exit("Falta el mensaje");
}

$nombre = $_POST['nombre'];
$correo = $_POST['email'];
$cali = $_POST['calificacion']; 
$mensaje = $_POST['mensaje'];

$correo = filter_var($correo, FILTER_VALIDATE_EMAIL);
if (!$correo) {
    header("Location: Falla_comentario.html");
    exit;
}
 
$servidor="localhost";
$usuario="root";
$clave="";
$baseDeDatos="elegance";

$enlace = mysqli_connect($servidor, $usuario, $clave, $baseDeDatos);

if(!$enlace){
    header("Location: Falla_comentario.html");
    exit;
}  

if($cali == "option1")
    $cali_val = 1;
else if($cali == "option2")
    $cali_val = 2;
else if($cali == "option3")
    $cali_val = 3;
else if($cali == "option4")
    $cali_val = 4;
else  
    $cali_val = 5;

$fecha = date('Y-m-d h:i:s');
$insertarDatos = "INSERT INTO comentarios VALUES(
    '$nombre', 
    '$correo',
    '$cali_val',
    '$mensaje',
    '$fecha'
    )";

$ejecutarInsertar = mysqli_query($enlace, $insertarDatos);

if(!$ejecutarInsertar){
    header("Location: Falla_comentario.html");
}else{
    header("Location: Envio_comentario.html");
}

?>