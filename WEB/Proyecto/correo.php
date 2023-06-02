<?php
if (empty($_POST["nombre"])) {
    exit("Falta el nombre");
}

if (empty($_POST["email"])) {
    exit("Falta el correo");
}

if (empty($_POST["mensaje"])) {
    exit("Falta el mensaje");
}

$nombre = $_POST['nombre'];
$correo = $_POST['email'];
$mensaje = $_POST['mensaje'];

$correo = filter_var($correo, FILTER_VALIDATE_EMAIL);
if (!$correo) {
    header("Location: Falla.html");
    exit;
}

$para = "danny209daniel@gmail.com"; # correo que recibirá los mensajes
$asunto = 'Nuevo mensaje de ELEGANCE';
$de = 'From: ' . $correo;

$mensaje = "Mensaje recibido " . date('d/m/Y', time()) . "\r\n";
$mensaje .= "Remitente: " . $nombre . "\r\n";
$mensaje .= "Email: " . $correo . "\r\n";
$mensaje .= "Mensaje: \r\n" . $_POST["mensaje"];

if (mail($para, $asunto, $mensaje, $de)) {
    header("Location: Envio.html");
    
} else {
    header("Location: Falla.html");
    
}


////////////////////////////////////
 
$servidor="localhost";
$usuario="root";
$clave="";
$baseDeDatos="elegance";

$enlace = mysqli_connect($servidor, $usuario, $clave, $baseDeDatos);

if(!$enlace){
    header("Location: Falla.html");
}  

$fecha = date('Y-m-d');
$insertarDatos = "INSERT INTO correos VALUES(
    '$nombre', 
    '$correo',
    '$mensaje',
    '$fecha'
    )";

$ejecutarInsertar = mysqli_query($enlace, $insertarDatos);

if(!$ejecutarInsertar){
    header("Location: Falla.html");
}else{
    header("Location: Envio.html");
}

?>