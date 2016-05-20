/* anonymous pl/sql block */
/*
declare
<variables>
begin
   <set of statements>
   <control statements>
   <looping statements>
exception
 <set of statements>
end;

*/

/* Scenario - Fetch all the employees and apply the filter to only increment salaries by 1000 for employees in department of SALES. If there are 
other employees, raise their salaries by 500. 
*/ 

declare
v_empid NUMBER;
v_dept_name hr.departments.department_name%type;
v_curr_sal hr.employees.salary%type;
v_new_sal hr.employees.salary%type;
BEGIN
dbms_output.put_line('Execution of Employee Update has started '||TO_CHAR(sysdate,'MM/DD/YYYY HH24:MI:SS'));
for emp_rec in (select a.employee_id emp_id,d.department_name dept_name,a.salary sal from employees a, departments d where a.department_id=d.department_id)
loop
  v_empid := emp_rec.emp_id;
  v_dept_name := emp_rec.dept_name;
  v_curr_sal := emp_rec.sal;
IF (v_dept_name = 'Sales') THEN
  v_new_sal := v_curr_sal + 1000;
  update employees set salary=v_new_Sal where employee_id = v_empid;
ELSE
 v_new_sal := v_curr_Sal + 500;
 update employees set salary=v_new_Sal where employee_id = v_empid; 
END IF;
dbms_output.put_line('The Salary of the employee '||v_empid||' is updated from:'||v_curr_sal||'to '||v_new_sal);
commit;
end loop;
dbms_output.put_line('Execution of Employee Update has ended '||TO_CHAR(sysdate,'MM/DD/YYYY HH24:MI:SS'));
EXCEPTION
  WHEN NO_DATA_FOUND THEN NULL;
  WHEN OTHERS THEN dbms_output.put_line('The Update failed at '||v_empid);
END;