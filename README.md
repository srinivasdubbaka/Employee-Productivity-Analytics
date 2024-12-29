# Employee Productivity Analysis

## 📌 Overview
This project analyzes employee productivity in a simulated organizational setup using SQL. It tracks metrics like work hours, project statuses, tasks completed, and errors to derive insights into employee performance and departmental efficiency.

## 🌟 Objectives
- Structure employee productivity data into a relational database.
- Provide performance insights via SQL queries.
- Identify productivity trends, work distribution, and project outcomes.

## 🛠️ Features
- **Database Design:** Includes tables for employees, work hours, projects, and productivity metrics.
- **Sample Queries:**
  - Average work hours by department.
  - Top performers based on tasks completed.
  - Project completion rates by department.
  - Productivity trends comparing tasks completed and errors.

## 🗃️ Schema Overview
### Employees Table
- **Employee_ID**: Primary key.
- **Details**: Name, Department, Role, and Join_Date.

### Work_Hours Table
- **Employee_ID**: Foreign key referencing `Employees`.
- **Details**: Date and Hours_Worked.

### Projects Table
- **Project_ID**: Primary key.
- **Details**: Employee_ID, Start_Date, End_Date, and Status.

### Productivity_Metrics Table
- **Employee_ID**: Foreign key referencing `Employees`.
- **Details**: Month, Tasks_Completed, and Errors.

## 🔍 Key Insights
1: **Average Work Hours by Department:**
```sql
SELECT e.Department, AVG(wh.Hours_Worked) AS Avg_Hours
FROM Employees e
JOIN Work_Hours wh ON e.Employee_ID = wh.Employee_ID
GROUP BY e.Department;

2: **Top Performers:**
```sql
SELECT e.Name, pm.Tasks_Completed
FROM Employees e
JOIN Productivity_Metrics pm ON e.Employee_ID = pm.Employee_ID
WHERE pm.Tasks_Completed = (SELECT MAX(Tasks_Completed) FROM Productivity_Metrics);

3. **Project Completion Rates by Department:**
```sql
SELECT e.Department, COUNT(p.Project_ID) AS Total_Projects,
       SUM(CASE WHEN p.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Projects
FROM Employees e
JOIN Projects p ON e.Employee_ID = p.Employee_ID
GROUP BY e.Department;

