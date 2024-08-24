<?php
/* TODO:Cadena de Conexion */
require_once("../config/conexion.php");
/* TODO:Clases Necesarias */
require_once("../models/Reporte.php");
$reporte = new Reporte();

$key = "mi_key_secret";
$cipher = "aes-256-cbc";
$iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length($cipher));

switch ($_GET["op"]) {

    case "ticketabierto";
        $datos = $reporte->ticket_abierto();
        echo json_encode($datos);
        break;

    case "listar_ticket_total":
        $datos=$reporte->get_tecnico_total_ticket();
        $data= Array();
        foreach($datos as $row){
            $sub_array = array();
            $sub_array[] = $row["NombreSoporte"];
            $sub_array[] = $row["Abierto"];
            $sub_array[] = $row["Cerrado"];
            $sub_array[] = $row["Total"];
            $data[] = $sub_array;
        }

        $results = array(
            "sEcho"=>1,
            "iTotalRecords"=>count($data),
            "iTotalDisplayRecords"=>count($data),
            "aaData"=>$data);
        echo json_encode($results);
        break;
    case "ticket_sinasignar":
        $datos = $reporte->get_ticket_sinasignar();
        $data = array();
        foreach ($datos as $row) {
            $data[] = array(
                'Ticket' => $row['ticket'],
                'Prioridad' => $row['prioridad'],  
                'TotalTickets' => $row['TotalTickets']
            );
        }
        echo json_encode($data);
        break;
    case "rango_fecha_crea":
        $fech_inicio = isset($_POST['fech_inicio']) ? $_POST['fech_inicio'] : '';
        $fech_fin = isset($_POST['fech_fin']) ? $_POST['fech_fin'] : '';
    
        if($fech_inicio != '' && $fech_fin != '') {
            // Modificar tu función de consulta SQL para aceptar parámetros de fechas
            $datos = $reporte->filtro_fecha_crea($fech_inicio, $fech_fin);
        } else {
            $datos = $reporte->filtro_fecha_crea();
        }
    
        $data= Array();
        foreach($datos as $row){
            $sub_array = array();
            $sub_array[] = $row["tick_id"];
                $sub_array[] = $row["titulo"];
                $sub_array[] = $row["Categoria"]; 
                $sub_array[] = $row["NombreUsuario"];
                $sub_array[] = $row["NombreSoporte"];
                $sub_array[] = $row["Prioridad"];  

                if ($row["FechaAsignacion"] == null) {
                    $sub_array[] = '<span class="label label-pill label-default">Sin Asignar</span>';
                } else {
                    $sub_array[] = date("d/m/Y", strtotime($row["FechaAsignacion"]));
                }

                if ($row["FechaCierre"] == null) {
                    $sub_array[] = '<span class="label label-pill label-default">Sin Cerrar</span>';
                } else {
                    $sub_array[] = date("d/m/Y", strtotime($row["FechaCierre"]));
                }
                
                if ($row["estado"] == "Abierto") {
                    $sub_array[] = '<span class="label label-pill label-success">Abierto</span>';
                } else {
                    $sub_array[] = '<a onClick="CambiarEstado(' . $row["tick_id"] . ')"><span class="label label-pill label-danger">Cerrado</span></a>';
                }
                $data[] = $sub_array;
        }
    
        $results = array(
            "sEcho"=>1,
            "iTotalRecords"=>count($data),
            "iTotalDisplayRecords"=>count($data),
            "aaData"=>$data);
        echo json_encode($results);
        break;
    
     
}


?>