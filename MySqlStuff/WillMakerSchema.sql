/*
REM ******************************************************************
REM  File:        WillMakerSchema.sql
REM  Description: Web based Will Drafter
REM               Kaigh J. Taylor
REM  Start Date:  July 29, 2014
REM ******************************************************************
*/

CREATE TABLE IF NOT EXISTS WM_RELATION
(
	Relate_id			INT			NOT NULL	AUTO_INCREMENT ,
	Relation			VARCHAR(20)	NOT NULL ,
	PRIMARY KEY (Relate_id)
)	ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS WM_ROLE
(
	RoleID				INT			NOT NULL	AUTO_INCREMENT ,
	Role_Type			VARCHAR(35)	NOT NULL,
	PRIMARY KEY(RoleID)
)	ENGINE=INNODB;
	
CREATE TABLE IF NOT EXISTS WM_CLIENT
(
	ClientID				INT		NOT NULL	AUTO_INCREMENT ,
	ClFName				CHAR(25)	NOT NULL ,
	ClMName				CHAR(25)	NULL ,
	ClLName				CHAR(35)	NOT NULL ,
	ClGender			CHAR(1)		NOT NULL ,
	PRIMARY KEY(ClientID)
)	ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS WM_ALIAS
(	
	AliasID				INT			NOT NULL	AUTO_INCREMENT ,
	ClientID			INT			NOT NULL ,
	Alias_FName			CHAR(25)	NOT NULL ,
	Alias_MName			CHAR(25)	NULL ,
	Alias_LName			CHAR(35)	NOT NULL ,
	PRIMARY KEY(AliasID)
)	ENGINE=INNODB;
/*	
FOREIGN KEY Alias_ClientID REFERENCES WM_CLIENT(ClientID))
*/

CREATE TABLE IF NOT EXISTS WM_ACTOR
(	
	Act_ID				INT			NOT NULL 	AUTO_INCREMENT ,
	ClientID			INT			NOT NULL ,
	Act_Name			CHAR(60)	NOT NULL ,
	Act_MName			CHAR(30)	NULL ,
	Act_LName			CHAR(30)	NULL ,
	Act_Gender			CHAR(1)		NOT NULL ,
	Act_Addr1			CHAR(50)	NULL ,
	Act_Addr2			CHAR(50)	NULL ,
	Act_City			CHAR(30)	NULL ,
	Act_State			CHAR(2)		NULL ,
	Act_Phone1			INT(10)		NULL ,
	Act_Phone2			INT(10)		NULL ,
	Act_Email			CHAR(50)	NULL ,
	Relate_ID			INT			NOT NULL ,
	Act_Type			CHAR(1)		NOT NULL ,
	PRIMARY KEY(Act_ID)
)	ENGINE=INNODB;
/*	
FOREIGN KEY Actor_Relate_ID REFERENCES WM_RELATIONS(Relate_ID),
FOREIGN KEY ClientID REFERENCES WM_CLIENT(ClientID)),

--	Name is either person's First name or Entity/Business name
--  P for person, E for entity
*/

CREATE TABLE IF NOT EXISTS WM_SPOUSE
(
	SpouseID			INT			NOT NULL	AUTO_INCREMENT ,
	Act_ID				INT			NOT NULL ,
	PRIMARY KEY (SpouseID, Act_ID)
)	ENGINE=INNODB;
/*
FOREIGN KEY Act_ID REFERENCES WM_ACTOR(Act_ID)),

-- 	A Connector table must be used to hold 1-to-1 relationship of Client to Spouse	
*/

CREATE TABLE IF NOT EXISTS WM_ROLE_SOURCE
(
	Source_ID			INT			NOT NULL	AUTO_INCREMENT ,
	ClientID			INT			NOT NULL ,
	Act_ID				INT			NOT NULL ,
	Role_ID				INT			NOT NULL ,
	PRIMARY KEY(Source_ID)
)	ENGINE=INNODB;
/*
-- 	This table requires careful consideration.
*/
	
CREATE TABLE IF NOT EXISTS WM_CL_DETAILS
(
	CL_DETAIL_ID	 	INT			NOT NULL	AUTO_INCREMENT ,
	ClientID		 	INT			NOT NULL	UNIQUE ,
	Ste_Cnty_ID		 	INT			NOT NULL ,
	Cl_Alias		 	INT			NOT NULL	DEFAULT 0 ,
	Cl_Marital		 	INT			NOT NULL	DEFAULT 0 ,
	SpouseID		 	INT			NULL		UNIQUE ,
	Cl_OmitSp		 	INT			NOT NULL	DEFAULT 0 ,
	Cl_ExSpouse		 	INT			NOT NULL	DEFAULT 0 ,
	Cl_Issue		 	INT			NOT NULL	DEFAULT 0 ,
	PRIMARY KEY(CL_DETAIL_ID)
)	ENGINE=INNODB;
/*	
FOREIGN KEY ClientID 	REFERENCES WM_CLIENT(ClientID),
FOREIGN KEY SpouseID 	REFERENCES WM_CL_SPOUSE(SpouseID),
FOREIGN KEY Ste_Cnty_ID REFERENCES WM_STATE_CNTY(Ste_Cnty_ID),

-- 	Connect to the client
-- 	State_County is a FK
-- 	Alias? is a boolean Flag
-- 	Marital status is a boolean Flag - if 1 SpouseID NOT NULL
-- 	Spouse ID flagged by CL_Marital
-- 	Omit Spouse is a boolean Flag	
-- 	Ex Spouse is a boolean Flag 
-- 	Issue - (Children) is a boolean Flag
*/	

CREATE TABLE IF NOT EXISTS WM_Specific_Inherit
(
	Specific_ID			INT			NOT NULL 	AUTO_INCREMENT ,
	ClientID			INT			NOT NULL ,
	Specific_Item		CHAR(255)	NOT NULL ,
	PRIMARY KEY(Specific_ID)
)	ENGINE=INNODB;
/*	
FOREIGN KEY ClientID 	REFERENCES WM_CLIENT(ClientID)

-- 	This is WHAT is being SPECIFICALLY inherited
*/
	
CREATE TABLE IF NOT EXISTS WM_Specific_Bene
(
	Spec_Bene_ID		INT			NOT NULL 	AUTO_INCREMENT ,
	Specific_ID			INT			NOT NULL ,
	ClientID			INT			NOT NULL ,
	Act_ID				INT			NOT NULL ,
	SPC_Role			INT 		NOT NULL	DEFAULT 0 ,
	Distro_Percent	DEC(3,2)		NOT NULL ,
	PRIMARY KEY(Spec_Bene_ID)
)	ENGINE=INNODB;
/*
FOREIGN KEY ClientID 	REFERENCES WM_CLIENT(ClientID)

-- 	SPC_Role must be verified as Primary or Alternate
-- 	This is WHO is SPECIFICALLY inheriting and in what percentage
*/
	
CREATE TABLE IF NOT EXISTS WM_Residuary_Bene
(
	Res_Bene_ID			INT			NOT NULL 	AUTO_INCREMENT ,
	ClientID			INT			NOT NULL ,
	Act_ID				INT			NOT NULL ,
	RES_Role			INT 		NOT NULL	DEFAULT 0 ,
	Distro_Percent	DEC(3,2)		NOT NULL ,
	PRIMARY KEY(Res_Bene_ID)
)	ENGINE=INNODB;
/*
FOREIGN KEY ClientID 	REFERENCES WM_CLIENT(ClientID),
FOREIGN KEY Act_ID 		REFERENCES WM_ACTOR(Act_ID)),

-- 	RES_Role must be verified as Primary or Alternate
--	This is WHO is inheriting WHATEVER is left and in what percentage
*/