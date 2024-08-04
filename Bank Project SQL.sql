CREATE database FINAL_DATA;
use final_data;
select count(*) from finance__1;
select * FROM finance__1;
desc finance__1;
select count(*) from finance_2;
select * from finance_2;
desc finance_2;

# KPI Cards
select count(id) 'Total No of Loan',
concat(round(sum(loan_amnt)/1000000),"M") 'Total loan amnt',
concat(round(sum(funded_amnt)/1000000),"M") 'Total funded amnt',
concat(round(sum(funded_amnt_inv)/1000000),"M") 'Total funded amnt inv',
concat(round(sum(annual_inc)/1000000),"M") 'Total annual income',
concat(round(avg(int_rate)),"%") 'Avg interest rate'
from finance__1;
 
 # KPI_1
 -- YEAR WISE LOAN AMOUNT STATS --
 select	year(issue_d) 'Year', concat(round(sum(loan_amnt)/1000000),"M") 'Total loan amnt' 
 from finance__1 
 group by year(issue_d) 
 order by year(issue_d) asc;
 
 # KPI_2
 -- GRADE AND SUB_GRADE WISE REVOL_BAL --
 select f1.grade 'Grade', f1.sub_grade 'Sub_grade', sum(f2.revol_bal) 'Revol_bal' 
 from finance__1 f1 
 inner join finance_2 f2 on f1.id = f2.id
 group by f1.grade, f1.sub_grade, f2.revol_bal
 order by f1.grade desc;
 
 # KPI_3
 -- Total Payment for Verified status Vs Total Payment for Non Verified Status --
 select f1.verification_status 'Verification Status', concat(round(sum(f2.Total_pymnt)/1000),"K") 'Total Payment' 
 from finance__1 f1 
 inner join finance_2 f2 on f1.id = f2.id 
 group by f1.verification_status, f2.Total_pymnt
 order by f2.Total_pymnt desc;
 
 # KPI_4
 -- State wise and Month wise loan Status --
 select f1.addr_state 'State', monthname(f2.last_pymnt_d) 'Month', count(f1.loan_status) 'Loan Status'
 from finance__1 f1 inner join finance_2 f2 on f1.id = f2.id
 group by f1.addr_state , monthname(f2.last_pymnt_d) , f1.loan_status;

  # KPI_5
 -- Home ownership Vs last payment date stats --
 select year(f2.last_pymnt_d) 'Last Payment Date', f1.home_ownership 'Home ownership',count(f1.home_ownership) ' No of customers'
 from finance__1 f1 inner join finance_2 f2 on f1.id = f2.id
 group by f1.home_ownership , f2.last_pymnt_d
 order by  f2.last_pymnt_d asc;
