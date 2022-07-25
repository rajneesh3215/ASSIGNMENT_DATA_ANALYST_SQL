CREATE TABLE `exams` (
  `exam_id` int(64) NOT NULL,
  `student_id` int(64) NOT NULL,
  `score` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exams`
--

INSERT INTO `exams` (`exam_id`, `student_id`, `score`) VALUES
(10, 1, 70),
(10, 2, 80),
(10, 3, 90),
(20, 1, 80),
(30, 1, 70),
(30, 3, 80),
(30, 4, 90),
(40, 1, 60),
(40, 2, 70),
(40, 4, 80);
COMMIT;

select*from exam;

CREATE TABLE `students` (
  `student_id` int(64) NOT NULL,
  `student_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_name`) VALUES
(1, 'Daniel'),
(2, 'Jade'),
(3, 'Stella'),
(4, 'Jonathan'),
(5, 'Will');
COMMIT;

select*from students;

select distinct students.*
from students inner join exams
on students.student_id = exams.student_id
where students.student_id not in 
(select e1.student_id
from exams as e1 inner join
(select exam_id, min(score) as min_score, max(score) as max_score from exams group by exam_id) as e2
on e1.exam_id = e2.exam_id
where e1.score = e2.min_score or e1.score = e2.max_score)
order by student_id