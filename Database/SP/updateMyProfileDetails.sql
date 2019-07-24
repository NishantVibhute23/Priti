DELIMITER $$

USE `pritienterprises`$$

DROP PROCEDURE IF EXISTS `updateMyProfileDetails`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMyProfileDetails`(id_in INT,comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin VARCHAR(200),comp_email VARCHAR(150),
comp_phone1 VARCHAR(20),comp_phone2 VARCHAR(20),comp_phone3 VARCHAR(20),comp_state INT,comp_bank_name VARCHAR(500),
comp_bank_ifsc VARCHAR(300),comp_bank_acc_no VARCHAR(300),comp_logo VARCHAR(1000),termsAndCondition1_in VARCHAR(1000),termsAndCondition2_in VARCHAR(1000),termsAndCondition3_in VARCHAR(1000),company_bank_branch_in VARCHAR(500))
BEGIN
		UPDATE `my_profile`
		SET `company_name`= comp_name,
		`company_address`=comp_add,
		`company_gstin`=comp_gstin,
		`company_email`=comp_email,
		`company_phone1`=comp_phone1,
		`company_phone2`=comp_phone2,
		`company_phone3`=comp_phone3,
		`company_state`=comp_state,
		`company_bank_name`=comp_bank_name,
		`company_bank_ifsc`=comp_bank_ifsc,
		`company_bank_account_no`=comp_bank_acc_no,
		`company_logo`=comp_logo,
		`term_condition1`=termsAndCondition1_in,
		`term_condition2`=termsAndCondition2_in,
		`term_condition3`=termsAndCondition3_in,
		company_bank_branch=company_bank_branch_in
		
		WHERE id=1;
		
		SELECT ROW_COUNT() ;
		
	END$$

DELIMITER ;