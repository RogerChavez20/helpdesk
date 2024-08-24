<?php
  require_once("../../config/conexion.php"); 
  if(isset($_SESSION["usu_id"])){ 
?>
<!DOCTYPE html>
<html>
    <?php require_once("../MainHead/head.php");?>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
	<link rel="stylesheet" href="../../public/css/lib/fullcalendar/fullcalendar.min.css">
	<link rel="stylesheet" href="../../public/css/separate/pages/calendar.min.css">

    <link href="../../public/css/lib/charts-c3js/c3.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../public/css/lib/datatables-net/datatables.min.css">
	<link rel="stylesheet" href="../../public/css/separate/vendor/datatables-net.min.css">
    <link rel="stylesheet" href="../../public/css/lib/font-awesome/font-awesome.min.css">
    <link rel="stylesheet" href="../../public/css/lib/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../public/css/main.css">

	<title>Sistema HelpDesk</title>
</head>
<body class="with-side-menu">

    <?php require_once("../MainHeader/header.php");?>

    <div class="mobile-menu-left-overlay"></div>

    <?php require_once("../MainNav/nav.php");?>

	 
    <!-- Contenido -->
	<div class="page-content">
		<div class="container-fluid">

            <div class="box-typical box-typical-padding">
				<div class="row">
                    <div class="col-sm-6">
                        <section class="card">
                            <header class="card-header">
                                TOTAL DE TICKET ABIERTOS
                            </header>
                            <div class="card-block" style="MARGIN-TOP: -32px;">
                                <!-- <div id="topgraficotecnico" style="height: 250px;"></div> -->
                                <!-- <canvas id="topgraficotecnico" style="height: 250px;"></canvas> -->
                            </div>

                            <div class="card-block">
                                <div id="ticket_abierto" style="height: 280px;"></div>
                            </div>
                                     
                        </section>
                    </div>

                    <div class="col-sm-6">
                        <section class="card">
                            <header class="card-header">
                                TOTAL DE TICKET SIN ASIGNAR
                            </header>
                                    

                            <div class="card-block">
                                <div id="categoriaprioridad" style="height: 280px;"></div>
                            </div>

                                  
                        </section>
                    </div>
                    
                </div>
            </div>

            <div class="box-typical box-typical-padding"> 
                <div class="row">
                    <!-- <div class="col-xl-6">
                        <div class="box-typical box-typical-padding">
                            <div class=" ">
                                <h3 style="border-bottom: 2px solid #3E438D; margin-top: 5px;    margin-bottom: 58px; padding-top: 4px; font-size: 18px; font-weight: 500;color: #3E438D">TOTAL DE TICKET POR TÉCNICO</h3>	 
                            </div>
                            
                            
                            <table id="example" class="display table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>Técnico</th>
                                    <th>Abierto</th>
                                    <th>Cerrado</th>
                                    <th>Total</th> 
                                </tr>
                                </thead>
                                                            
                                <tbody>
                                                            
                                                            
                                </tbody>
                            </table>
                                        
                        </div>
                    </div> -->
                    <div class="col-xl-12">
                        <section class="card">
                            <header class="card-header">
                                TOTAL DE TICKET POR TÉCNICO
                            </header>
                            <div class="box-typical box-typical-padding">
                                <div class="m-b-0" id="ticket_tecnico"></div>
                            </div>
                        </section>                      
                    </div>
                </div>
            </div>
 
            <div class="row">
                <div class="col-xl-12">
                    <div class="box-typical box-typical-padding">
                        <div class=" ">
                            <h3 style="border-bottom: 2px solid #3E438D; margin-top: 5px;    margin-bottom: 58px; padding-top: 4px; font-size: 18px; font-weight: 500;color: #3E438D">REPORTE DE TICKETS</h3>	 
                        </div>
                        
                        <div class="row" id="rangofecha">
                            <div class="col-lg-3">
                                <fieldset class="form-group">
                                    <label class="form-label" for="fech_inicio">Fecha inicio</label>
                                    <input type="date" class="form-control" id="fech_inicio" name="fech_inicio" placeholder="Ingrese la fecha de inicio" required>
                                </fieldset>
                            </div>

                            <div class="col-lg-3">
                                <fieldset class="form-group">
                                    <label class="form-label" for="fech_fin">Fecha fin</label>
                                    <input type="date" class="form-control" id="fech_fin" name="fech_fin" placeholder="Ingrese la fecha fin" required>
                                </fieldset>
                            </div>

                            <div class="col-lg-2">
                                <fieldset class="form-group">
                                    <label class="form-label" for="btnbuscar">&nbsp;</label>
                                    <button type="submit" class="btn btn-rounded btn-primary btn-block" id="btnbuscar">Buscar</button>
                                </fieldset>
                            </div>

                            <div class="col-lg-2">
                                <fieldset class="form-group">
                                    <label class="form-label" for="btntodo">&nbsp;</label>
                                    <button class="btn btn-rounded btn-primary btn-block" id="btntodo">Ver Todo</button>
                                </fieldset>
                            </div>
                        </div>

                        <div class="box-typical box-typical-padding" id="filtro_tabla">
                            <table id="fecha_filtro" class="table table-bordered table-striped table-vcenter js-dataTable-full">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">Nro.</th> 
                                        <th style="width: 30%;">Titulo</th>
                                        <th style="width: 30%;">Categoria</th> 
                                        <th style="width: 30%;">Usuario</th>
                                        <th style="width: 30%;">Técnico</th>
                                        <th style="width: 5%;">Prioridad</th> 
                                        <th style="width: 10%;">Fecha Asignación</th>
                                        <th style="width: 10%;">Fecha Cierre</th>
                                        <th style="width: 5%;">Estado</th> 
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                                        
                    </div>
                </div>
                    
            </div>
      

            
           

		</div>
	</div>
	<!-- Contenido -->

	<?php require_once("../MainJs/js.php");?>

	<script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="../../public/js/lib/d3/d3.min.js"></script>
    <script src="../../public/js/lib/charts-c3js/c3.min.js"></script>
    <script src="../../public/js/lib/charts-c3js/c3js-init.js"></script>

    <script src="../../public/js/lib/datatables-net/datatables.min.js"></script>
    
    
    
	<script type="text/javascript" src="../../public/js/lib/moment/moment-with-locales.min.js"></script>
	<script src="../../public/js/lib/fullcalendar/fullcalendar.min.js"></script>

	<script type="text/javascript" src="reporte.js"></script>

	<script type="text/javascript" src="../notificacion.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- <script>
		$(function() {
			$('#example').DataTable();
		});
	</script> 

    <script src="../../public/js/app.js"></script> -->
</body>
</html>
<?php
  } else {
    header("Location:".Conectar::ruta()."index.php");
  }
?>