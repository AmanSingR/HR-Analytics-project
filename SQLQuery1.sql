-- 1.	Compare an employee's performance rating with the average rating of their peers in the same department.

select e.Employee_Number,e.Department,Performance_Rating,d.avg_perf_rating from (
select Department,AVG(PERFORMANCE_RATING) avg_perf_rating from Hr_data1
GROUP BY Department) d
inner join Hr_data1 e
on d.Department = e.Department



--2.Compare the attrition rate between different departments.

WITH AttritionCount AS (
    SELECT Department, COUNT(*) AS DeptAttritionCount
    FROM Hr_data1
    WHERE Attrition = 1
    GROUP BY Department
	),
TotalEmployee AS (
    SELECT Department, COUNT(*) AS TotalDeptCount
    FROM Hr_data1
    GROUP BY Department
	)
select ac.Department,cast(round(ac.DeptAttritionCount *100.0 / te.TotalDeptCount,1) as decimal(10,1)) depart_attrition from TotalEmployee te
join AttritionCount ac
on te.Department = ac.Department


--3.Pivot data to compare the average hourly rate across different education fields.

select Education,avg(Hourly_Rate) as AverageHourlyRate from Hr_data1
group by Education
order by AverageHourlyRate desc

--4.Identify Employees Eligible for Next Promotion

SELECT Employee_Number , Years_Since_Last_Promotion Promotion
FROM Hr_data1
WHERE Years_Since_Last_Promotion >= 5;

--5.Assess the Impact of Training on Performance Rating

select Training_Times_Last_Year,avg(Performance_Rating) as AvgPerformance from Hr_data1
group by Training_Times_Last_Year
order by Training_Times_Last_Year

--6.Compare Average Hourly Rate by Gender

select Gender,avg(Hourly_Rate) AvgHourlyRate from Hr_data1
group by gender

--7.Calculate the Average Monthly Income by Department

SELECT Department, AVG(Monthly_Income) as AvgIncome
FROM Hr_data1
GROUP BY Department
