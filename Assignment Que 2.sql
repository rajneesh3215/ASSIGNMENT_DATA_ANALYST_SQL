
CREATE TABLE `employee` (
  `employee_id` int(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `experience_years` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `name`, `experience_years`) VALUES
(1, 'Suraj', 3),
(2, 'Anurag', 2),
(3, 'John', 3),
(4, 'Nikhil', 2);
COMMIT;
CREATE TABLE `project` (
  `project_id` int(64) NOT NULL,
  `employee_id` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`project_id`, `employee_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);
COMMIT;
-- ANSWER---
select project_id, Project.employee_id from Project inner join Employee
on Project.employee_id = Employee.employee_id where (project_id, experience_years) in 
(select project_id, max(experience_years) as years
from Project inner join Employee
on Project.employee_id = Employee.employee_id
group by project_id);
    