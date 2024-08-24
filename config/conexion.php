<?php
session_start();

class Conectar
{
    protected $dbh;

    protected function Conexion()
    {
        try {
            //TODO: Cadena de Conexion
            $conectar = $this->dbh = new PDO("mysql:local=localhost;dbname=helpdesk", "root", "");
            return $conectar;
        } catch (Exception $e) {
            print "¡Error BD!: " . $e->getMessage() . "<br/>";
            die();
        }
    }

    /* TODO: Set Name para utf 8 español - evitar tener problemas con las tildes */
    public function set_names()
    {
        return $this->dbh->query("SET NAMES 'utf8'");
    }

    public static function ruta()
    {
        //TODO: Ruta Proyecto Local
        return "http://localhost/HelpDesk_GRTC/";
        //TODO: Ruta Proyecto Produccion
        //return "http://helpdesk.grtc.com/";
    }
}
