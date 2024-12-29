create database EmployeeProductivity;
use EmployeeProductivity;

CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Role VARCHAR(50),
    Join_Date DATE
);

INSERT INTO Employees (Employee_ID, Name, Department, Role, Join_Date) VALUES
(1, 'John Doe', 'IT', 'Developer', '2022-01-01'),
(2, 'Jane Smith', 'HR', 'Manager', '2021-05-15'),
(3, 'Alice Johnson', 'Finance', 'Analyst', '2023-03-10'),
(4, 'Bob Brown', 'IT', 'Developer', '2022-07-01'),
(5, 'Charlie Wilson', 'Marketing', 'Coordinator', '2020-11-20'),
(6, 'Emma Taylor', 'HR', 'Coordinator', '2021-08-11'),
(7, 'James Lee', 'IT', 'Team Lead', '2019-06-01'),
(8, 'Sophia Harris', 'Finance', 'Analyst', '2022-05-14'),
(9, 'Daniel Martin', 'Marketing', 'Manager', '2023-01-25'),
(10, 'Emily Clark', 'HR', 'Specialist', '2021-12-12'),
(11, 'Michael Lewis', 'Finance', 'CFO', '2018-03-01'),
(12, 'Liam Walker', 'IT', 'Developer', '2020-10-15'),
(13, 'Olivia Scott', 'Marketing', 'Coordinator', '2021-01-05'),
(14, 'Benjamin Hall', 'Finance', 'Analyst', '2023-07-20'),
(15, 'Ava King', 'HR', 'Manager', '2020-02-14'),
(16, 'Charlotte Young', 'IT', 'Tester', '2022-08-18'),
(17, 'Elijah Adams', 'Marketing', 'Strategist', '2023-09-10'),
(18, 'Amelia Turner', 'Finance', 'Analyst', '2020-07-25'),
(19, 'Noah Collins', 'HR', 'Coordinator', '2021-11-03'),
(20, 'Lucas Wright', 'Marketing', 'Director', '2019-04-09'),
(21, 'Mia Baker', 'IT', 'System Admin', '2021-03-01'),
(22, 'Harper Phillips', 'Finance', 'Accountant', '2022-06-10'),
(23, 'Ella Green', 'Marketing', 'Designer', '2023-04-25'),
(24, 'William Parker', 'IT', 'Developer', '2020-09-01'),
(25, 'Ethan Roberts', 'HR', 'Trainer', '2019-07-15');

CREATE TABLE Work_Hours (
    Employee_ID INT,
    Date DATE,
    Hours_Worked INT,
    PRIMARY KEY (Employee_ID, Date),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

INSERT INTO Work_Hours (Employee_ID, Date, Hours_Worked) VALUES
(1, '2023-12-01', 8),
(2, '2023-12-01', 7),
(3, '2023-12-01', 6),
(1, '2023-12-02', 9),
(2, '2023-12-02', 8),
(3, '2023-12-02', 5);

CREATE TABLE Projects (
    Project_ID VARCHAR(10) PRIMARY KEY,
    Employee_ID INT,
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

INSERT INTO Projects (Project_ID, Employee_ID, Start_Date, End_Date, Status) VALUES
('P001', 1, '2023-11-01', '2023-12-01', 'Completed'),
('P002', 2, '2023-10-15', '2023-11-15', 'Completed'),
('P003', 3, '2023-11-01', '2023-12-15', 'In Progress');

CREATE TABLE Productivity_Metrics (
    Employee_ID INT,
    Month VARCHAR(7),
    Tasks_Completed INT,
    Errors INT,
    PRIMARY KEY (Employee_ID, Month),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

INSERT INTO Productivity_Metrics (Employee_ID, Month, Tasks_Completed, Errors) VALUES
(1, '2023-12', 20, 1),
(2, '2023-12', 18, 2),
(3, '2023-12', 15, 0),
(4, '2023-12', 12, 1),
(5, '2023-12', 22, 0);

-- Query 1: Average hours worked by department

SELECT e.Department, AVG(wh.Hours_Worked) AS Avg_Hours
FROM Employees e
JOIN Work_Hours wh ON e.Employee_ID = wh.Employee_ID
GROUP BY e.Department;

-- Query 2: Employees with highest productivity

SELECT e.Name, pm.Tasks_Completed
FROM Employees e
JOIN Productivity_Metrics pm ON e.Employee_ID = pm.Employee_ID
WHERE pm.Tasks_Completed = (SELECT MAX(Tasks_Completed) FROM Productivity_Metrics);

-- Query 3: Project completion rates by department

SELECT e.Department, COUNT(p.Project_ID) AS Total_Projects,
       SUM(CASE WHEN p.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Projects
FROM Employees e
JOIN Projects p ON e.Employee_ID = p.Employee_ID
GROUP BY e.Department;

-- Query 4: Productivity trends (tasks completed vs errors)

SELECT pm.Month, e.Department, SUM(pm.Tasks_Completed) AS Total_Tasks, SUM(pm.Errors) AS Total_Errors
FROM Productivity_Metrics pm
JOIN Employees e ON pm.Employee_ID = e.Employee_ID
GROUP BY pm.Month, e.Department;
