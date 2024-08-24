<?php

class Reporte extends Conectar
{
    public function get_tecnico_total_ticket()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT t.tick_id,
            CONCAT(u.usu_nom, ' ', u.usu_ape) AS NombreSoporte,
            SUM(CASE WHEN t.tick_estado = 'Abierto' THEN 1 ELSE 0 END) AS Abierto,
            SUM(CASE WHEN t.tick_estado = 'Cerrado' THEN 1 ELSE 0 END) AS Cerrado,
            COUNT(t.tick_id) AS Total
        FROM tm_usuario u
        LEFT JOIN tm_ticket t ON u.usu_id = t.usu_asig
        WHERE u.rol_id = 2
        GROUP BY u.usu_id
        ORDER BY NombreSoporte";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $resultado = $sql->fetchAll();
    }

    public function ticket_abierto()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT t.tick_titulo as NombreTicket, 
            COUNT(t.tick_id) AS TotalTickets
        FROM tm_ticket t
        LEFT JOIN tm_categoria c ON t.cat_id = c.cat_id 
        WHERE t.tick_estado = 'Abierto'  
        GROUP BY NombreTicket
        ORDER BY NombreTicket";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $resultado = $sql->fetchAll();
    }

    public function get_ticket_sinasignar()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT t.tick_titulo as ticket, 
        p.prio_nom as prioridad, 
        COUNT(t.tick_id) AS TotalTickets
        FROM tm_ticket t
        LEFT JOIN tm_categoria c ON t.cat_id = c.cat_id
        LEFT JOIN tm_prioridad p ON t.prio_id = p.prio_id
        WHERE t.usu_asig is null
        GROUP BY ticket,  p.prio_nom 
        ORDER BY ticket, p.prio_nom";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $resultado = $sql->fetchAll();
    }

    public function filtro_fecha_crea($fech_inicio = '', $fech_fin = '')
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT tick.tick_id,	tick.tick_titulo as titulo, 
            cat.cat_nom as Categoria, sub.cats_nom as SubCategoria,
            CONCAT(usucrea.usu_nom,' ',usucrea.usu_ape) as NombreUsuario,
            IFNULL(CONCAT(usuasig.usu_nom,' ',usuasig.usu_ape),'Sin Asignar') as NombreSoporte,
            prio.prio_nom as Prioridad,	DATE(tick.fech_crea) as FechaCreacion,
            DATE(tick.fech_asig) as FechaAsignacion,
            DATE(tick.fech_cierre) as FechaCierre,
            tick.tick_estado as estado
            FROM tm_ticket tick
            INNER join tm_categoria cat on tick.cat_id = cat.cat_id
            INNER JOIN tm_subcategoria sub on tick.cats_id = sub.cats_id
            INNER join tm_usuario usucrea on tick.usu_id = usucrea.usu_id
            LEFT JOIN tm_usuario usuasig on tick.usu_asig = usuasig.usu_id
            INNER join tm_prioridad prio on tick.prio_id = prio.prio_id
            WHERE tick.est = 1";

        if ($fech_inicio != '' && $fech_fin != '') {
            $sql .= " AND DATE(tick.fech_crea) BETWEEN ? AND ?";
        }

        $sql = $conectar->prepare($sql);

        if ($fech_inicio != '' && $fech_fin != '') {
            $sql->bindValue(1, $fech_inicio);
            $sql->bindValue(2, $fech_fin);
        }

        $sql->execute();
        return $resultado = $sql->fetchAll();
    }

} 

