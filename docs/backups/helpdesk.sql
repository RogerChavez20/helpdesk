-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-07-2024 a las 02:08:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `helpdesk`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `BackupSP` ()   BEGIN

    SET @dump_command = CONCAT('mysqldump -u root ticket > C:\\C9\\ticket.sql');

    CALL sys_exec(@dump_command);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `filtrar_ticket` (IN `tick_titulo` VARCHAR(50), IN `cat_id` INT, IN `prio_id` INT)   BEGIN

 IF tick_titulo = '' THEN            

 SET tick_titulo = NULL;

 END IF; 

 

  IF cat_id = '' THEN            

 SET cat_id = NULL;

 END IF; 

 

  IF prio_id = '' THEN  

 SET prio_id = NULL;

 END IF; 

 

SELECT

tm_ticket.tick_id,

tm_ticket.usu_id,

tm_ticket.cat_id,

tm_ticket.tick_titulo,

tm_ticket.tick_descrip,

tm_ticket.tick_estado,

tm_ticket.fech_crea,

tm_ticket.fech_cierre,

tm_ticket.usu_asig,

tm_ticket.fech_asig,

tm_usuario.usu_nom,

tm_usuario.usu_ape,

tm_categoria.cat_nom,

tm_ticket.prio_id,

tm_prioridad.prio_nom

FROM 

tm_ticket

INNER join tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id

INNER join tm_usuario on tm_ticket.usu_id = tm_usuario.usu_id

INNER join tm_prioridad on tm_ticket.prio_id = tm_prioridad.prio_id

WHERE

tm_ticket.est = 1

AND tm_ticket.tick_titulo like IFNULL(tick_titulo,tm_ticket.tick_titulo)

AND tm_ticket.cat_id =  IFNULL(cat_id,tm_ticket.cat_id)

AND tm_ticket.prio_id = IFNULL(prio_id,tm_ticket.prio_id)

ORDER BY tm_ticket.tick_id DESC;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `filtrar_ticket2` (IN `tick_titulo` VARCHAR(50), IN `cat_id` INT, IN `prio_id` INT)   SELECT 


            tm_ticket.tick_id, 


            tm_ticket.usu_id,


            tm_ticket.cat_id,


            tm_ticket.tick_titulo, 


            tm_ticket.tick_descrip,


            tm_ticket.tick_estado, 


            tm_ticket.fech_crea, 


            tm_ticket.fech_cierre, 


            tm_ticket.usu_asig, 


            tm_ticket.fech_asig, 


            tm_usuario.usu_nom, 


            tm_usuario.usu_ape, 


            tm_categoria.cat_nom, 


            tm_ticket.prio_id, 


            tm_prioridad.prio_nom 


            FROM 


            tm_ticket 


            INNER join tm_categoria on tm_ticket.cat_id=tm_categoria.cat_id 


            INNER join tm_usuario on tm_ticket.usu_id=tm_usuario.usu_id 


            INNER join tm_prioridad on tm_ticket.prio_id=tm_prioridad.prio_id 


            WHERE 


            tm_ticket.est = 1 


            AND tm_ticket.tick_titulo like IFNULL(tick_titulo, tm_ticket.tick_titulo) 


            AND tm_ticket.cat_id like IFNULL(cat_id, tm_ticket.cat_id) 


            AND tm_ticket.prio_id like IFNULL(prio_id, tm_ticket.prio_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_d_usuario_01` (IN `xusu_id` INT)   BEGIN


	UPDATE tm_usuario 


	SET 


		est='0',


		fech_elim = now() 


	where usu_id=xusu_id;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_i_ticketdetalle_01` (IN `xtick_id` INT, IN `xusu_id` INT)   BEGIN

	INSERT INTO td_ticketdetalle 

    (tickd_id,tick_id,usu_id,tickd_descrip,fech_crea,est) 

    VALUES 

    (NULL,xtick_id,xusu_id,'Ticket Cerrado...',now(),'1');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_reporte_01` ()   BEGIN

SELECT

	tick.tick_id as id,

	tick.tick_titulo as titulo,

	tick.tick_descrip as descripcion,

	tick.tick_estado as estado,

	tick.fech_crea as FechaCreacion,

	tick.fech_cierre as FechaCierre,

	tick.fech_asig as FechaAsignacion,

	CONCAT(usucrea.usu_nom,' ',usucrea.usu_ape) as NombreUsuario,

	IFNULL(CONCAT(usuasig.usu_nom,' ',usuasig.usu_ape),'Sin Asignar') as NombreSoporte,

	cat.cat_nom as Categoria,

	prio.prio_nom as Prioridad,

	sub.cats_nom as SubCategoria

	FROM 

	tm_ticket tick

	INNER join tm_categoria cat on tick.cat_id = cat.cat_id

	INNER JOIN tm_subcategoria sub on tick.cats_id = sub.cats_id

	INNER join tm_usuario usucrea on tick.usu_id = usucrea.usu_id

	LEFT JOIN tm_usuario usuasig on tick.usu_asig = usuasig.usu_id

	INNER join tm_prioridad prio on tick.prio_id = prio.prio_id

	WHERE

	tick.est = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_usuario_01` ()   BEGIN

	SELECT * FROM tm_usuario where est='1';

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_usuario_02` (IN `xusu_id` INT)   BEGIN

	SELECT * FROM tm_usuario where usu_id=xusu_id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento`
--

CREATE TABLE `td_documento` (
  `doc_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `doc_nom` varchar(400) NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_documento`
--

INSERT INTO `td_documento` (`doc_id`, `tick_id`, `doc_nom`, `fech_crea`, `est`) VALUES
(1, 8, 'Conexion de circuito_bb.pdf', '2024-07-10 21:26:47', 1),
(2, 9, 'NÉSTOR ADRIÁN MORA MACÍAS - CRISTHIAN XAVIER VEGA INTRIAGO.pdf', '2024-07-11 16:15:20', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento_detalle`
--

CREATE TABLE `td_documento_detalle` (
  `det_id` int(11) NOT NULL,
  `tickd_id` int(11) NOT NULL,
  `det_nom` varchar(200) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_documento_detalle`
--

INSERT INTO `td_documento_detalle` (`det_id`, `tickd_id`, `det_nom`, `est`) VALUES
(1, 8, 'Conexion de circuito_bb.pdf', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_ticketdetalle`
--

CREATE TABLE `td_ticketdetalle` (
  `tickd_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `tickd_descrip` mediumtext NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_ticketdetalle`
--

INSERT INTO `td_ticketdetalle` (`tickd_id`, `tick_id`, `usu_id`, `tickd_descrip`, `fech_crea`, `est`) VALUES
(1, 1, 5, 'Ticket Cerrado...', '2024-07-09 14:03:47', 1),
(2, 2, 4, '<p>hola como te puedo ayudar</p>', '2024-07-09 14:27:25', 1),
(3, 2, 6, '<p>necesito que arregles el teclado</p>', '2024-07-09 14:28:41', 1),
(4, 2, 5, 'Ticket Cerrado...', '2024-07-09 15:33:36', 1),
(5, 3, 5, 'Ticket Cerrado...', '2024-07-09 15:34:08', 1),
(6, 5, 5, '<p>pedir mas datos</p>', '2024-07-09 17:34:03', 1),
(7, 5, 3, 'hola si', '2024-07-09 17:34:45', 1),
(8, 5, 4, '<p>bklerlre</p>', '2024-07-09 17:36:23', 1),
(9, 5, 4, 'Ticket Cerrado...', '2024-07-09 17:38:51', 1),
(10, 8, 8, '&nbsp;mdsa msd&nbsp;', '2024-07-10 21:28:41', 1),
(11, 8, 6, '<p>de</p>', '2024-07-11 00:08:46', 1),
(12, 8, 6, '<p>nkbjkigfkjvkhfvihkn</p>', '2024-07-11 15:12:42', 1),
(13, 6, 2, 'Ticket Cerrado...', '2024-07-12 14:57:18', 1),
(14, 11, 2, 'Ticket Cerrado...', '2024-07-12 14:59:25', 1),
(15, 20, 2, 'Ticket Cerrado...', '2024-07-12 15:00:06', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_categoria`
--

CREATE TABLE `tm_categoria` (
  `cat_id` int(11) NOT NULL,
  `cat_nom` varchar(150) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_categoria`
--

INSERT INTO `tm_categoria` (`cat_id`, `cat_nom`, `est`) VALUES
(1, 'Hardware', 1),
(2, 'Software', 1),
(3, 'Incidencia', 1),
(4, 'Petición de Servicio', 1),
(5, 'test2', 0),
(7, 'test2', 0),
(8, 'test', 0),
(9, 'test2', 0),
(10, 'Otros', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_notificacion`
--

CREATE TABLE `tm_notificacion` (
  `not_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `not_mensaje` varchar(400) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_notificacion`
--

INSERT INTO `tm_notificacion` (`not_id`, `usu_id`, `not_mensaje`, `tick_id`, `est`) VALUES
(32, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(33, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(34, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(35, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(36, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(37, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(38, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(39, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(40, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(41, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(42, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(43, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(44, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(45, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(46, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 107, 1),
(47, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 107, 1),
(48, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 108, 1),
(49, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 108, 1),
(50, 2, 'Se le ha asignado el ticket Nro : ', 108, 1),
(51, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 108, 1),
(52, 2, 'Se le ha asignado el ticket Nro : ', 109, 1),
(53, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 109, 1),
(54, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 109, 1),
(55, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 109, 1),
(56, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 109, 1),
(57, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 109, 1),
(58, 2, 'Se le ha asignado el ticket Nro : ', 110, 1),
(59, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 110, 1),
(60, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 110, 1),
(61, 2, 'Se le ha asignado el ticket Nro : ', 111, 1),
(62, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 111, 1),
(63, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 111, 1),
(64, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 111, 1),
(65, 2, 'Se le ha asignado el ticket Nro : ', 112, 1),
(66, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 112, 1),
(67, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 112, 1),
(68, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 112, 1),
(69, 3, 'Se le ha asignado el ticket Nro : ', 88, 1),
(70, 6, 'Se le ha asignado el ticket Nro : ', 89, 1),
(71, 2, 'Se le ha asignado el ticket Nro : ', 90, 1),
(72, 2, 'Se le ha asignado el ticket Nro : ', 91, 1),
(73, 2, 'Se le ha asignado el ticket Nro : ', 132, 1),
(74, 2, 'Se le ha asignado el ticket Nro : ', 131, 1),
(75, 2, 'Se le ha asignado el ticket Nro : ', 134, 1),
(76, 2, 'Se le ha asignado el ticket Nro : ', 133, 1),
(77, 3, 'Se le ha asignado el ticket Nro : ', 139, 1),
(78, 3, 'Se le ha asignado el ticket Nro : ', 135, 1),
(79, 4, 'Se le ha asignado el ticket Nro : ', 1, 1),
(80, 4, 'Se le ha asignado el ticket Nro : ', 2, 1),
(81, 8, 'Se le ha asignado el ticket Nro : ', 3, 1),
(82, 4, 'Se le ha asignado el ticket Nro : ', 5, 1),
(83, 4, 'Se le ha asignado el ticket Nro : ', 6, 1),
(84, 8, 'Se le ha asignado el ticket Nro : ', 4, 1),
(85, 8, 'Se le ha asignado el ticket Nro : ', 8, 1),
(86, 10, 'Se le ha asignado el ticket Nro : ', 11, 1),
(87, 10, 'Se le ha asignado el ticket Nro : ', 20, 2),
(88, 4, 'Se le ha asignado el ticket Nro : ', 16, 2),
(89, 8, 'Se le ha asignado el ticket Nro : ', 14, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_prioridad`
--

CREATE TABLE `tm_prioridad` (
  `prio_id` int(11) NOT NULL,
  `prio_nom` varchar(50) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_prioridad`
--

INSERT INTO `tm_prioridad` (`prio_id`, `prio_nom`, `est`) VALUES
(1, 'Bajo', 1),
(2, 'Medio', 1),
(3, 'Alto', 1),
(4, 'test2', 0),
(5, 'test', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_subcategoria`
--

CREATE TABLE `tm_subcategoria` (
  `cats_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cats_nom` varchar(150) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_subcategoria`
--

INSERT INTO `tm_subcategoria` (`cats_id`, `cat_id`, `cats_nom`, `est`) VALUES
(1, 1, 'Teclado', 1),
(2, 1, 'Monitor', 1),
(3, 2, 'Winrar', 1),
(4, 2, 'VSCODE', 1),
(5, 3, 'Corte de Red', 1),
(6, 3, 'Corte de Energia', 1),
(7, 4, 'JSON de Software', 1),
(8, 4, 'Instalación de IIS', 1),
(9, 1, 'test2', 0),
(10, 1, 'test', 0),
(11, 1, 'test', 0),
(12, 1, 'test', 0),
(13, 1, 'test', 0),
(14, 1, 'Otros', 1),
(15, 3, 'Otras', 1),
(16, 10, 'Otros', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_ticket`
--

CREATE TABLE `tm_ticket` (
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cats_id` int(11) NOT NULL,
  `tick_titulo` varchar(250) NOT NULL,
  `tick_descrip` mediumtext NOT NULL,
  `tick_estado` varchar(15) DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `usu_asig` int(11) DEFAULT NULL,
  `fech_asig` datetime DEFAULT NULL,
  `tick_estre` int(11) DEFAULT NULL,
  `tick_coment` varchar(300) DEFAULT NULL,
  `fech_cierre` datetime DEFAULT NULL,
  `prio_id` int(11) DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_ticket`
--

INSERT INTO `tm_ticket` (`tick_id`, `usu_id`, `cat_id`, `cats_id`, `tick_titulo`, `tick_descrip`, `tick_estado`, `fech_crea`, `usu_asig`, `fech_asig`, `tick_estre`, `tick_coment`, `fech_cierre`, `prio_id`, `est`) VALUES
(1, 3, 3, 5, 'Laptop', '<p>Windows 11</p>', 'Cerrado', '2024-07-09 13:53:26', 4, '2024-07-09 13:54:55', 3, 'encuesta', '2024-07-09 14:03:47', 2, 1),
(2, 6, 1, 1, 'Impresora', '<p>hola se malogro la impresora</p>', 'Cerrado', '2024-07-09 14:00:32', 4, '2024-07-09 14:03:13', NULL, NULL, '2024-07-09 15:33:36', 3, 1),
(3, 7, 1, 1, 'Teclado', '<p>Se malogro el teclado</p>', 'Cerrado', '2024-07-09 14:01:47', 8, '2024-07-09 14:03:30', NULL, NULL, '2024-07-09 15:34:08', 3, 1),
(4, 6, 1, 14, 'Impresora', '<p>hola</p>', 'Abierto', '2024-07-09 14:31:42', 8, '2024-07-10 12:19:12', NULL, NULL, NULL, 3, 1),
(5, 3, 1, 2, 'Monitor', '<p>bkdnlnedjlñdfs</p><p><br></p><p><br></p><p><br></p>', 'Cerrado', '2024-07-09 17:32:51', 4, '2024-07-09 17:35:25', NULL, NULL, '2024-07-09 17:38:51', 3, 1),
(6, 3, 1, 14, 'Impresora', '<p>Hola necesito ayuda</p>', 'Cerrado', '2024-07-09 17:45:43', 4, '2024-07-10 11:54:41', NULL, NULL, '2024-07-12 14:57:18', 3, 1),
(7, 6, 1, 14, 'de', '<p>hola</p>', 'Abierto', '2024-07-10 12:18:43', NULL, NULL, NULL, NULL, NULL, 1, 1),
(8, 6, 2, 3, 'Formateo de laptop', '<p>oldsksdlkd&nbsp;</p>', 'Abierto', '2024-07-10 21:26:47', 8, '2024-07-10 21:27:50', NULL, NULL, NULL, 3, 1),
(9, 5, 1, 14, 'hola', '<p>iuhjgij</p>', 'Abierto', '2024-07-11 16:15:20', NULL, NULL, NULL, NULL, NULL, 1, 1),
(10, 6, 1, 14, 'ROGER', '<p>CDWESW</p>', 'Abierto', '2024-07-11 16:19:42', NULL, NULL, NULL, NULL, NULL, 1, 1),
(11, 9, 10, 16, 'Antivirus', '<p>ESET NOT 32</p>', 'Cerrado', '2024-07-11 16:39:53', 10, '2024-07-11 16:40:46', NULL, NULL, '2024-07-12 14:59:25', 3, 1),
(12, 11, 1, 14, 'ewewew', '<p>ew</p>', 'Abierto', '2024-07-11 21:05:23', NULL, NULL, NULL, NULL, NULL, 2, 1),
(13, 11, 2, 3, 'HOLA 3', '<p>HOLA 3&nbsp;&nbsp;&nbsp;&nbsp;</p>', 'Abierto', '2024-07-11 21:05:57', NULL, NULL, NULL, NULL, NULL, 2, 1),
(14, 11, 1, 14, 'wwe', '<p>dew</p>', 'Abierto', '2024-07-11 21:14:08', 8, '2024-07-12 14:59:05', NULL, NULL, NULL, 1, 1),
(15, 11, 1, 1, 'cd', '<p>csd</p>', 'Abierto', '2024-07-11 21:23:39', NULL, NULL, NULL, NULL, NULL, 2, 1),
(16, 11, 1, 14, 'erer', 'hola roger', 'Abierto', '2024-07-11 21:28:16', 4, '2024-07-12 14:58:48', NULL, NULL, NULL, 2, 1),
(17, 11, 1, 1, 'fer', '<p>dewfweede</p>', 'Abierto', '2024-07-11 21:30:54', NULL, NULL, NULL, NULL, NULL, 3, 1),
(18, 11, 1, 1, 'rer', '<p>cef</p>', 'Abierto', '2024-07-11 21:32:42', NULL, NULL, NULL, NULL, NULL, 3, 1),
(19, 11, 1, 1, 'c', '<p>ef</p>', 'Abierto', '2024-07-11 21:34:58', NULL, NULL, NULL, NULL, NULL, 3, 1),
(20, 11, 1, 1, 'dddd', '<p>dcs</p>', 'Cerrado', '2024-07-11 21:35:54', 10, '2024-07-12 14:58:24', NULL, NULL, '2024-07-12 15:00:06', 3, 1),
(21, 11, 10, 16, 'xcdw', '<p>xw</p>', 'Abierto', '2024-07-11 21:42:59', NULL, NULL, NULL, NULL, NULL, 3, 1),
(22, 2, 1, 1, 'd', '<p>cd</p>', 'Abierto', '2024-07-11 21:49:48', NULL, NULL, NULL, NULL, NULL, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE `tm_usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nom` varchar(150) DEFAULT NULL,
  `usu_ape` varchar(150) DEFAULT NULL,
  `usu_correo` varchar(150) NOT NULL,
  `usu_pass` varchar(150) NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `usu_telf` varchar(12) NOT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla Mantenedor de Usuarios';

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`usu_id`, `usu_nom`, `usu_ape`, `usu_correo`, `usu_pass`, `rol_id`, `usu_telf`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(2, 'Roger', 'Chavez', 'rogerchavezmedina10@gmail.com', 'j4epUDQR8BbyiQHmksdxhS04O8rnOZZsDEnSg6Z5RKg=', 4, '930572455', '2024-07-09 13:46:36', NULL, NULL, 1),
(3, 'Mauricio', 'Chavez', 'mauricio@gmail.com', '/8QI3eqMC7pcfSmbcjoWQOgC/ui8aBAVyVmcBtJUga0=', 1, '963258741', '2024-07-09 13:49:46', NULL, NULL, 1),
(4, 'Manuel', 'Cardozo', 'manuel@gmail.com', 'IyO/eu06fRa1GieLfMibJANT9DoBlQOs8Nbss/A9qjQ=', 2, '987456321', '2024-07-09 13:50:40', NULL, NULL, 1),
(5, 'Jorge', 'Antonio', 'jorge@gmail.com', '0tvUmURnerjolzGzTZUn573oPUTQWes2r/OMETrpAcA=', 3, '985674123', '2024-07-09 13:51:54', NULL, NULL, 1),
(6, 'Bryan', 'Diaz', 'bryan@gmail.com', 'ko+lCmS0E0XnA/wmYyijmb7otwl27Dxc2JNnH20396o=', 1, '965832147', '2024-07-09 13:57:06', NULL, NULL, 1),
(7, 'Wagner', 'Villasis', 'wagner@gmail.com', 'eeH6s1uyCtj/LB2txHJVEBEPWG8ZZ9fLmJRDyKz6540=', 1, '963258741', '2024-07-09 13:57:42', NULL, NULL, 1),
(8, 'Cazado', 'Vargaz', 'cazado@gmail.com', 'KNgIIlegCYgpikYf+oyQvijJdDd1eap27XL0WxYRxZY=', 2, '987456123', '2024-07-09 13:58:20', NULL, NULL, 1),
(9, 'Fiorela', 'Sanchez', 'fiorela@gmail.com', 'HA2TpdJW6fJ+AWe8YhGmbGWLr3xrogKNU17QfEFu+Rg=', 1, '963258741', '2024-07-11 16:35:54', NULL, NULL, 1),
(10, 'Yomona', 'Ahunari', 'yomona@gmail.com', 'd1xidp4XTvpm9JxyffzOfhSowynX28VbfS8QeZNkwvw=', 2, '986574123', '2024-07-11 16:37:10', NULL, NULL, 1),
(11, 'Sandro', 'Melgar', 'rogercha305@gmail.com', 'VPPnVviCbqXOeBxXrqNuBzfVj6b+DLdhaFOGVZ48aNQ=', 1, '930572455', '2024-07-11 20:56:49', NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `td_documento`
--
ALTER TABLE `td_documento`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indices de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  ADD PRIMARY KEY (`det_id`);

--
-- Indices de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  ADD PRIMARY KEY (`tickd_id`);

--
-- Indices de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `tm_notificacion`
--
ALTER TABLE `tm_notificacion`
  ADD PRIMARY KEY (`not_id`);

--
-- Indices de la tabla `tm_prioridad`
--
ALTER TABLE `tm_prioridad`
  ADD PRIMARY KEY (`prio_id`);

--
-- Indices de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  ADD PRIMARY KEY (`cats_id`);

--
-- Indices de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  ADD PRIMARY KEY (`tick_id`);

--
-- Indices de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  ADD PRIMARY KEY (`usu_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `td_documento`
--
ALTER TABLE `td_documento`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  MODIFY `det_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  MODIFY `tickd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tm_notificacion`
--
ALTER TABLE `tm_notificacion`
  MODIFY `not_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT de la tabla `tm_prioridad`
--
ALTER TABLE `tm_prioridad`
  MODIFY `prio_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  MODIFY `cats_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  MODIFY `tick_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
