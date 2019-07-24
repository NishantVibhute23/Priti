DELIMITER $$

USE `pritienterprises`$$

DROP PROCEDURE IF EXISTS `getMyProfileDetails`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMyProfileDetails`()
BEGIN
		SELECT c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,
		c.`company_phone1`,c.`company_phone2`,c.`company_phone3`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,
		c.`company_bank_account_no`,c.`company_logo`,s.`state_name`,s.`state_tin`,c.`term_condition1`,c.`term_condition2`
,c.`term_condition3`,company_bank_branch		FROM `my_profile` c JOIN `state`  s
		ON c.`company_state` =s.`id`
		WHERE c.id=1;
	END$$

DELIMITER ;