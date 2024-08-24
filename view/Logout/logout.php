<?php
require_once("../../config/conexion.php");
/* TODO: Destruir Session */
session_destroy();
header("Location:" . Conectar::ruta() . "index.php");

exit();
