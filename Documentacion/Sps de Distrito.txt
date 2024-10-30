DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerDistrito`()
BEGIN
    SELECT d.idDistrito, d.nombreDistrito, c.idCanton
    FROM tbdistrito d
    JOIN tbcanton c ON d.idCanton = c.idCanton;
END$$
DELIMITER ;

----------------------------------------