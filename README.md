Employee Productivity Analytics
📌 Overview
This project establishes a database to analyze employee productivity in a corporate environment. It includes information about employee details, work hours, project participation, and productivity metrics. The database and queries are designed to provide actionable insights into departmental performance, individual productivity, and trends over time.

🌟 Objectives
To organize employee productivity data into a structured relational database.
To analyze key metrics like work hours, tasks completed, errors, and project completion rates using SQL.
To enable efficient reporting for HR and management teams.
🛠️ Features
Database Creation: A normalized schema with tables for employees, work hours, projects, and productivity metrics.
Data Analysis Queries:
Average work hours by department.
Top-performing employees based on tasks completed.
Project completion rates across departments.
Productivity trends (tasks completed vs. errors).
📊 Dataset
Employees Table: Contains employee information, including ID, name, department, role, and join date.
Work Hours Table: Tracks daily work hours for employees.
Projects Table: Records project assignments, durations, and statuses.
Productivity Metrics Table: Captures monthly tasks completed and errors for each employee.
🗃️ Schema Design
Employees Table:
Employee_ID: Unique identifier for employees.
Name, Department, Role, Join_Date: Employee details.
Work_Hours Table:
Employee_ID, Date, Hours_Worked: Work hour records for each employee.
Projects Table:
Project_ID, Employee_ID, Start_Date, End_Date, Status: Project details and employee assignments.
Productivity_Metrics Table:
Employee_ID, Month, Tasks_Completed, Errors: Monthly productivity metrics.
🔍 Key Insights
Average Hours Worked by Department:

sql
Copy code
SELECT e.Department, AVG(wh.Hours_Worked) AS Avg_Hours
FROM Employees e
JOIN Work_Hours wh ON e.Employee_ID = wh.Employee_ID
GROUP BY e.Department;
Top Employees by Tasks Completed:

sql
Copy code
SELECT e.Name, pm.Tasks_Completed
FROM Employees e
JOIN Productivity_Metrics pm ON e.Employee_ID = pm.Employee_ID
WHERE pm.Tasks_Completed = (SELECT MAX(Tasks_Completed) FROM Productivity_Metrics);
Project Completion Rates by Department:

sql
Copy code
SELECT e.Department, COUNT(p.Project_ID) AS Total_Projects,
       SUM(CASE WHEN p.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Projects
FROM Employees e
JOIN Projects p ON e.Employee_ID = p.Employee_ID
GROUP BY e.Department;
Productivity Trends (Tasks Completed vs. Errors):

sql
Copy code
SELECT pm.Month, e.Department, SUM(pm.Tasks_Completed) AS Total_Tasks, SUM(pm.Errors) AS Total_Errors
FROM Productivity_Metrics pm
JOIN Employees e ON pm.Employee_ID = e.Employee_ID
GROUP BY pm.Month, e.Department;
🏗️ How to Use
Set Up the Database:

Execute the CREATE TABLE scripts provided in the employee_productivity.sql file.
Populate the tables using the INSERT statements.
Run Queries:

Copy and paste the provided queries into your SQL workbench.
Analyze the outputs for insights into employee and departmental productivity.
🌐 Links
GitHub Repository: Your GitHub Repository Link
