<?php
require_once("../../config/conexion.php");
require_once("../../models/Usuario.php");

if (isset($_SESSION["usu_id"])) {
	$usuario = new Usuario();
	$usuarios = $usuario->get_usuario_x_rol_1();
?>
	<!DOCTYPE html>
	<html>
	<?php require_once("../MainHead/head.php"); ?>
	<title>Sistema HelpDesk</title>
	</head>

	<body class="with-side-menu">

		<?php require_once("../MainHeader/header.php"); ?>

		<div class="mobile-menu-left-overlay"></div>

		<?php require_once("../MainNav/nav.php"); ?>

		<!-- Contenido -->
		<div class="page-content">
			<div class="container-fluid">


				<div class="box-typical box-typical-padding">
					<div class=" ">
						<h3 style="border-bottom: 2px solid #3E438D; margin-top: 5px;    margin-bottom: 58px; padding-top: 4px; font-size: 18px; font-weight: 500;color: #3E438D">Ingrese la información</h3>
					</div>

                    <?php if ($_SESSION["rol_id"] == 3 | $_SESSION["rol_id"] == 4) { ?>
                        <button  style="float: right; position: relative; margin-top: -44px;" type="button" id="btnnuevo" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm"><i class="fa fa-plus fa-sm text-white-50"></i> Agregar Nuevo Usuario</button>
                    <?php } ?>


					<div class="row">
						<form method="post" id="ticket_form">

							<?php if ($_SESSION["rol_id"] == 3 | $_SESSION["rol_id"] == 4) { ?>
								<div class="col-lg-12">
									<fieldset class="form-group">
										<label class="form-label semibold" for="usu_id_incidencia">Usuario (*)</label>
										<select id="usu_id_incidencia" name="usu_id_incidencia" class="form-control select2" required>
											<option value="">Seleccionar</option>
											<?php foreach ($usuarios as $usuario) { ?>
												<option value="<?php echo $usuario['usu_id']; ?>"><?php echo $usuario['usu_nom'] . ' ' . $usuario['usu_ape']; ?></option>
											<?php } ?>
										</select>
									</fieldset>
								</div>
							<?php } ?>

                            <input type="hidden" id="usu_id" name="usu_id" value="<?php echo $_SESSION["usu_id"] ?>">
                            <input type="hidden" id="rol_id" value="<?php echo $_SESSION["rol_id"]; ?>"> <!-- Nuevo campo hidden para rol_id -->

                            <div class="col-lg-12">
								<fieldset class="form-group">
									<label class="form-label semibold" for="tick_titulo">Titulo (*)</label>
									<input type="text" class="form-control" id="tick_titulo" name="tick_titulo" placeholder="Ingrese Titulo" required>
								</fieldset>
							</div>

							<div class="col-lg-6">
								<fieldset class="form-group">
									<label class="form-label semibold" for="exampleInput">Categoria (*)</label>
									<select id="cat_id" name="cat_id" class="form-control select2" required>
										<option value="">Seleccionar</option>
									</select>
								</fieldset>
							</div>

							<div class="col-lg-6">
								<fieldset class="form-group">
									<label class="form-label semibold" for="exampleInput">SubCategoria (*)</label>
									<select id="cats_id" name="cats_id" class="form-control select2" required>
										<option value="">Seleccionar</option>
									</select>
								</fieldset>
							</div>

							<div class="col-lg-6">
								<fieldset class="form-group">
									<label class="form-label semibold" for="exampleInput">Prioridad (*)</label>
									<select id="prio_id" name="prio_id" class="form-control select2" required>
										<option value="">Seleccionar</option>
									</select>
								</fieldset>
							</div>

							<div class="col-lg-6">
								<fieldset class="form-group">
									<label class="form-label semibold" for="exampleInput" hidden>Documentos Adicionales</label>
									<input type="file" name="fileElem" id="fileElem" class="form-control" multiple hidden>
								</fieldset>
							</div>

							<div class="col-lg-12">
								<fieldset class="form-group">
									<label class="form-label semibold" for="tick_descrip" hidden>Descripción (*)</label>
									<div class="summernote-theme-1">
										<textarea id="tick_descrip" name="tick_descrip" class="summernote" name="name" required></textarea>
									</div>
								</fieldset>
							</div>

							<div class="col-lg-12">
								<button type="submit" id="btnguardar" name="action" value="add" class="btn btn-rounded btn-inline btn-primary">
									Guardar
								</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>
		<!-- Contenido -->

        <?php require_once("../MntUsuario/modalmantenimiento.php"); ?>

		<?php require_once("../MainJs/js.php"); ?>

		<script type="text/javascript" src="nuevoticket.js"></script>

		<script type="text/javascript" src="../notificacion.js"></script>

	</body>

	</html>
<?php
} else {
	header("Location:" . Conectar::ruta() . "index.php");
}
?>