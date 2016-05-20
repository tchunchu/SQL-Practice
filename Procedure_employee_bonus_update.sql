


  CREATE OR REPLACE PROCEDURE "HR"."EMP_UPD_SAL_BONUS" AS 
-- declaration section variables and cursors
v_first_name hr.employees.first_name%type;
v_last_name hr.employees.last_name%type;
v_sal hr.employees.salary%type;
v_state hr.locations.state_province%type;
v_upd NUMBER :=0;
v_total_upd NUMBER :=0;
v_bonus hr.employees.bonus%TYPE;
v_emp_id hr.employees.employee_id%TYPE;

/* Cursor Declaration */
CURSOR emp_cur IS
SELECT emp.first_name fname,emp.last_name lname,emp.salary sal, d.department_name dept_name, l.state_province state
from
employees emp, departments d, locations l
where
emp.department_id = d.department_id and
d.location_id = l.location_id and
salary >= 5000;

BEGIN
 /* Code */
DBMS_OUTPUT.PUT_LINE('Start of the Procedure '||TO_CHAR(SYSDATE,'MM/DD/YYYY HH24:MI:SS'));
  FOR emp_rec in emp_cur
  loop
    v_first_name := emp_rec.fname;
    v_last_name := emp_rec.lname;
    v_sal := emp_rec.sal;
    v_state := emp_rec.state;
   
   v_emp_id := GET_EMP_NUM(v_first_name,v_last_name);
   
   IF (v_emp_id is not null) THEN
    
    IF ((v_state = 'Washington') or (v_state = 'California')) THEN
      v_bonus := v_sal*20/100;
      update employees set bonus=v_bonus where employee_id=v_emp_id;
      v_upd := sql%rowcount;
      --DBMS_OUTPUT.PUT_LINE('The bonus of the employee with first_name:'||v_first_name||' and last_name: '||v_last_name||'is: '||v_bonus);
    ELSE
      v_bonus := v_sal*10/100;
      update employees set bonus=v_bonus where employee_id=v_emp_id;
      v_upd := sql%rowcount;
    -- DBMS_OUTPUT.PUT_LINE('The bonus of the employee with first_name:'||v_first_name||' and last_name: '||v_last_name||'is: '||v_bonus);
    END IF;
      v_total_upd := v_total_upd + v_upd;
      commit;
   END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('The total number of employees bonus calculated is :'||v_total_upd);
  DBMS_OUTPUT.PUT_LINE('End of the Procedure '||TO_CHAR(SYSDATE,'MM/DD/YYYY HH24:MI:SS'));
EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('The process of execution errored at '||v_emp_id);
END EMP_UPD_SAL_BONUS;

/
