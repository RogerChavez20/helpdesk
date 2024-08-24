<?php
/* TODO: Rol 1 es de Usuario */
if ($_SESSION["rol_id"] == 1) {
?>
    <nav class="side-menu">
        <ul class="side-menu-list">
            <li class="blue-dirty">
                <a href="..\Home\">
                    <span class="glyphicon glyphicon-home"></span>
                    <span class="lbl">Inicio</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\NuevoTicket\">
                    <span class="glyphicon glyphicon-plus-sign"></span>
                    <span class="lbl">Nuevo Ticket</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\ConsultarTicket\">
                    <span class="glyphicon glyphicon-file"></span>
                    <span class="lbl">Ver Incidencias</span>
                </a>
            </li>

        </ul>
    </nav>
<?php
} else if ($_SESSION["rol_id"] == 2) {
?>

    <nav class="side-menu">
        <ul class="side-menu-list">
            <li class="blue-dirty">
                <a href="..\Home\">
                    <span class="glyphicon glyphicon-home"></span>
                    <span class="lbl">Inicio</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\ConsultarTicket\">
                    <span class="glyphicon glyphicon-file"></span>
                    <span class="lbl">Consultar Ticket</span>
                </a>
            </li>
        </ul>
    </nav>

<?php
} else if ($_SESSION["rol_id"] == 3) {
?>

    <nav class="side-menu">
        <ul class="side-menu-list">
            <li class="blue-dirty">
                <a href="..\Home\">
                    <span class="glyphicon glyphicon-home"></span>
                    <span class="lbl">Inicio</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\NuevoTicket\">
                    <span class="glyphicon glyphicon-plus-sign"></span>
                    <span class="lbl">Nuevo Ticket</span>
                </a>
            </li>

            <li class="blue-dirty">

                <a href="..\MntPrioridad\">
                    <span class="glyphicon glyphicon-sort"></span>
                    <span class="lbl">Gestión Prioridad</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\MntCategoria\">
                    <span class="glyphicon glyphicon-tags"></span>
                    <span class="lbl">Gestión Categoria</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\MntSubCategoria\">
                    <span class="glyphicon glyphicon-tags"></span>
                    <span class="lbl">Mant. Sub Categoria</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\ConsultarTicket\">
                    <span class="glyphicon glyphicon-file"></span>
                    <span class="lbl">Consultar Ticket</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\Reporte\">
                    <span class="glyphicon glyphicon-file"></span>
                    <span class="lbl">Reportes</span>
                </a>
            </li>

        </ul>
    </nav>


<?php
} else {
?>
    <nav class="side-menu">
        <ul class="side-menu-list">
            <li class="blue-dirty">
                <a href="..\Home\">
                    <span class="glyphicon glyphicon-home"></span>
                    <span class="lbl">Inicio</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\NuevoTicket\">
                    <span class="glyphicon glyphicon-plus-sign"></span>
                    <span class="lbl">Nuevo Ticket</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\MntUsuario\">
                    <span class="glyphicon glyphicon-user"></span>
                    <span class="lbl">Gestión Usuarios</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\MntPrioridad\">
                    <span class="glyphicon glyphicon-sort"></span>
                    <span class="lbl">Gestión Prioridad</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\MntCategoria\">
                    <span class="glyphicon glyphicon-tags"></span>
                    <span class="lbl">Gestión Categoria</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\MntSubCategoria\">
                    <span class="glyphicon glyphicon-tags"></span>
                    <span class="lbl">Mant. Sub Categoria</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\ConsultarTicket\">
                    <span class="glyphicon glyphicon-file"></span>
                    <span class="lbl">Consultar Ticket</span>
                </a>
            </li>

            <li class="blue-dirty">
                <a href="..\Reporte\">
                    <span class="glyphicon glyphicon-file"></span>
                    <span class="lbl">Reportes</span>
                </a>
            </li>
        </ul>
    </nav>
<?php
}
?>