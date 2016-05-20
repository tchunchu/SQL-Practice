/* TRIGGERS */


select * from employees_audit;
alter table employees_audit add (new_salary number(8,2),operation_cd varchar2(10),date_modified DATE); 
alter table employees_audit rename column salary to old_salary;
alter table employees_audit drop column commission_pct;
alter table employees_audit drop column manager_id;
alter table employees_audit drop column hire_date;
alter table employees_audit drop column job_id;

CREATE OR REPLACE TRIGGER trg_upd_emp_sal
BEFORE UPDATE ON HR.EMPLOYEES
FOR EACH ROW
BEGIN
  IF (:NEW.salary <> :OLD.salary) THEN
     insert into employees_audit (employee_id,first_name,last_name,old_salary,new_salary,department_id,email,operation_cd,date_modified) 
     values
     (:OLD.employee_id,:OLD.first_name,:OLD.last_name,:OLD.salary,:NEW.salary,:OLD.department_id,:OLD.email,'UPDATE',SYSDATE);
  END IF;
END;

/* Update */ -- Salary update triggering an action
update employees set salary = salary + 1000 where employee_id=101;
select * from employees_audit;
select * from employees where employee_id=101;

/* Update Email */ -- Email Update should not trigger
update employees set email='NKOCK' where employee_id=101;
select * from employees_audit;
select * from employees where employee_id=101;

/* Update Salary for multiple records */
update employees set salary=salary+500 where salary >= 15000 and salary <= 20000;
select * from employees_audit;
select * from employees where employee_id=101;

/* SYNONYM */

CREATE SYNONYM <synonym_name> for <schema_owner.table_name>;

CREATE synonym emp for hr.employees;

select * from emp;

Private Synonym - That can be used only in that schema.
Public Synonym - That can be used in any schema.

