DELIMITER $$

USE `pritienterprises`$$

DROP PROCEDURE IF EXISTS `getCompanyDetails`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCompanyDetails`(id_in INT)
BEGIN
		SELECT c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,c.`company_phone1`,
		c.`company_phone2`,c.`company_phone3`,s.`state_name`,s.`state_tin`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,c.`company_bank_account_no`
		FROM `clients_address` c JOIN `state`  s
		ON c.`company_state` =s.`id`
		WHERE c.id=id_in;
	END$$

DELIMITER ;