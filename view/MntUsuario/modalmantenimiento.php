
<div id="modalmantenimiento" class="modal fade bd-example-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="modal-close" data-dismiss="modal" aria-label="Close">
                    <i class="font-icon-close-2"></i>
                </button>
                <h4 class="modal-title" id="mdltitulo"></h4>
            </div>
            <form method="post" id="usuario_form">
                <div class="modal-body">
                    <input type="hidden" id="usu_id" name="usu_id">

                    <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-6"> 
                                        <label class="form-label" for="usu_nom">Nombre</label>
                                        <input type="text" class="form-control" id="usu_nom" name="usu_nom" placeholder="Ingrese Nombre" required>
                                    </div>
                                    <div class="col-lg-6">
                                        <label class="form-label" for="usu_ape">Apellido</label>
                                        <input type="text" class="form-control" id="usu_ape" name="usu_ape" placeholder="Ingrese Apellido" required>
                                    </div>
                                </div>
                                <div class="row">
                                   
                                    <div class="col-lg-8">
                                        <label class="form-label" for="rol_id">Rol</label>
                                        <select class="form-control" id="rol_id" name="rol_id">
                                            <option value="1">Usuario</option>
                                            <option value="2">Soporte</option>
                                            <option value="3">Helpdesk</option>
                                            <option value="4">Administrador</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-4">
                                        <label class="form-label" for="usu_telf">Telefono</label>
                                        <input type="text" class="form-control" id="usu_telf" name="usu_telf" placeholder="Ingrese Telefono" required>
                                    </div>
                                </div>
                            
                               

                                <div class="row">
                                    <div class="col-lg-6">
                                        <label class="form-label" for="usu_correo" style="margin-top: 8px;">Correo Electronico</label>
                                        <input type="email" class="form-control" id="usu_correo" name="usu_correo" placeholder="ejemplo@gmail.com" required>
                                    </div>
                                    <div class="col-lg-6">
                                        <label class="form-label" for="usu_pass"  style="margin-top: 8px;">Contraseña</label>
                                        <input type="password" class="form-control" id="usu_pass" name="usu_pass" placeholder="************" required>
                                    </div>
                                   
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Cerrar</button>
                    <button type="submit" name="action" id="#" value="add" class="btn btn-rounded btn-primary">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>