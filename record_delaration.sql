set serveroutput on;
CREATE OR REPLACE PROCEDURE procWithRecord AS
--a) record cust_record
TYPE cust_record is RECORD (ID_client CLIENT1.ID_CL%type,
				    First_Name CLIENT1.First_Name%type,
				    Last_Name CLIENT1.Last_Name%type);
--b) record acct_record	
TYPE acct_record is RECORD (Balance ACCOUNT1.Balance%type,
				 Account_Type ACCOUNT1.Account_Type%type);	
--c) compound record cust_acct_record
TYPE cust_acct_record is RECORD (cust cust_record,
				 acct acct_record);
--d)three instances
  cust_acct_record1 cust_acct_record;
  cust_acct_record2 cust_acct_record;
  cust_acct_record3 cust_acct_record;

BEGIN

cust_acct_record1.cust.ID_client := 1;	
cust_acct_record2.cust.ID_client := 4;
cust_acct_record3.cust.ID_client := 7;

--e) assigning values

cust_acct_record1.acct.Balance := 30000;
cust_acct_record2.acct.Balance := 40000;
cust_acct_record3.acct.Balance := 50000;
  
--f)Update account table
update account1
set Balance = cust_acct_record1.acct.Balance where ID_CL = cust_acct_record1.cust.ID_client;
update account1
set Balance = cust_acct_record2.acct.Balance where ID_CL =cust_acct_record2.cust.ID_client;
update account1
set Balance = cust_acct_record3.acct.Balance where ID_CL = cust_acct_record3.cust.ID_client;

						
COMMIT;
END;			

/
exec procWithRecord;	

/
select * from account1;				