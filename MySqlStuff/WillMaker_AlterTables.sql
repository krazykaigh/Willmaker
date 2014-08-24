/*
REM ******************************************************************
REM  File:        WillMaker_AlterTables.sql
REM  Description: Web based Will Drafter
REM               Kaigh J. Taylor
REM  Start Date:  July 29, 2014
REM ******************************************************************
*/
###########################
# Define Alias foreign keys 
###########################
ALTER TABLE WM_ALIAS ADD CONSTRAINT fk_alias_ClientID FOREIGN KEY (ClientID) REFERENCES WM_CLIENT (ClientID);

###########################
# Define Actor foreign keys 
###########################
ALTER TABLE WM_ACTOR ADD CONSTRAINT fk_actor_ClientID FOREIGN KEY (ClientID) REFERENCES WM_CLIENT (ClientID);
ALTER TABLE WM_ACTOR ADD CONSTRAINT fk_actor_Relate_ID FOREIGN KEY (Relate_ID) REFERENCES WM_RELATION(Relate_ID);

###########################
# Define Spouse foreign keys 
###########################
ALTER TABLE WM_SPOUSE ADD CONSTRAINT fk_spouse_Act_ID FOREIGN KEY (Act_ID) REFERENCES WM_ACTOR (Act_ID);

#############################
# Define Details foreign keys 
#############################
ALTER TABLE WM_CL_DETAILS ADD CONSTRAINT fk_details_ClientID FOREIGN KEY (ClientID) REFERENCES WM_CLIENT (ClientID);
ALTER TABLE WM_CL_DETAILS ADD CONSTRAINT fk_details_SpouseID FOREIGN KEY (SpouseID) REFERENCES WM_SPOUSE (SpouseID);
ALTER TABLE WM_CL_DETAILS ADD CONSTRAINT fk_details_Ste_Cnty_ID FOREIGN KEY (Ste_Cnty_ID) REFERENCES WM_STATE_CNTY (Ste_Cnty_ID);

######################################
# Define Specific_Inherit foreign keys 
######################################
ALTER TABLE WM_Specific_Inherit ADD CONSTRAINT fk_SpcIN_ClientID FOREIGN KEY (ClientID) REFERENCES WM_CLIENT (ClientID);

###################################
# Define Specific_Bene foreign keys 
###################################
ALTER TABLE WM_Specific_Bene ADD CONSTRAINT fk_SpcBene_ClientID FOREIGN KEY (ClientID) REFERENCES WM_CLIENT (ClientID);

####################################
# Define Residuary_Bene foreign keys 
####################################
ALTER TABLE WM_Residuary_Bene ADD CONSTRAINT fk_ResBene_ClientID FOREIGN KEY (ClientID) REFERENCES WM_CLIENT (ClientID);
ALTER TABLE WM_Residuary_Bene ADD CONSTRAINT fk_ResBene_Act_ID FOREIGN KEY (Act_ID) REFERENCES WM_ACTOR (Act_ID);