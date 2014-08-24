/*
REM ******************************************************************
REM  File:        WillMaker_TableTriggers.sql
REM  Description: Triggers for the Web based Will Drafter
REM               Kaigh J. Taylor
REM  Start Date:  July 29, 2014
REM ******************************************************************
*/

################################
# CHECK Triggers for Tables
################################

################################
# CHECK Triggers for WM_CLIENT
################################
DROP TRIGGER IF EXISTS trig_client_gndr;
DELIMITER |
CREATE TRIGGER trig_client_gndr
BEFORE INSERT ON WM_CLIENT
FOR EACH ROW
BEGIN
        IF UPPER(NEW.ClGender) NOT IN ('M','F') THEN
                SET NEW.ClGender ='U';
        END IF;
END |
DELIMITER ;

################################
# CHECK Triggers for WM_ACTOR
################################
DROP TRIGGER IF EXISTS trigs_insert_actor;
DELIMITER |
CREATE TRIGGER trig_actor_gndr 
BEFORE INSERT ON WM_ACTOR 
FOR EACH ROW 
BEGIN 
	IF UPPER(NEW.Act_Gender) NOT IN ('M','F') THEN 
		SET NEW.Act_Gender ='U'; 
	END IF; 
	IF UPPER(NEW.Act_Type) NOT IN ('P','E') THEN 
		SET NEW.Act_Type ='P'; 
	END IF; 	
END |
DELIMITER ;

/*	
--  P for person, E for entity
*/

##################################
# CHECK Triggers for WM_CL_DETAILS
##################################

DROP TRIGGER IF EXISTS trig_insert_details;
DELIMITER |
CREATE TRIGGER trig_details_alias 
BEFORE UPDATE ON WM_CL_DETAILS 
FOR EACH ROW 
BEGIN 
	IF NEW.Cl_Alias NOT IN (0,1) THEN 
		SET NEW.Cl_Alias =0; 
	END IF; 
	IF NEW.Cl_Marital NOT IN (0,1) THEN 
		SET NEW.Cl_Marital =0; 
	END IF; 
	IF NEW.Cl_OmitSp NOT IN (0,1) THEN 
		SET NEW.Cl_OmitSp =0; 
	END IF; 
	IF NEW.Cl_ExSpouse NOT IN (0,1) THEN 
		SET NEW.Cl_ExSpouse =0; 
	END IF; 
	IF NEW.Cl_Issue NOT IN (0,1) THEN 
		SET NEW.Cl_Issue =0; 
	END IF; 
END |
DELIMITER ;

/*	
-- Does client have aliases 0=No,1=Yes

-- 0=P for person, 1=E for entity
	
-- Omit Spouse from Will? 0=No,1=Yes

-- Does Client have and ex-spouse? 0=No,1=Yes

-- Does Client have any children? 0=No,1=Yes
*/

########################################
# CHECK Triggers for WM_Specific_Bene
########################################

DROP TRIGGER IF EXISTS trig_spc_bene_role;
DELIMITER |
CREATE TRIGGER trig_spc_bene_role 
BEFORE INSERT ON WM_Specific_Bene 
FOR EACH ROW 
BEGIN 
	IF NEW.SPC_Role NOT IN (0,1) THEN 
		SET NEW.SPC_Role =0; 
	END IF; 
END;
DELIMITER ;

/*	
-- 0=Primary Specific Bene; 1=Alternate Specific Bene
*/

########################################
# CHECK Triggers for WM_Residuary_Bene
########################################

DROP TRIGGER IF EXISTS trig_res_bene_role;
DELIMITER |
CREATE TRIGGER trig_res_bene_role 
BEFORE INSERT ON WM_Residuary_Bene 
FOR EACH ROW 
BEGIN 
	IF NEW.RES_Role NOT IN (0,1) THEN 
		SET NEW.RES_Role =0; 
	END IF; 
END |
DELIMITER ;

/*	
-- 0=Primary Specific Bene; 1=Alternate Specific Bene
*/