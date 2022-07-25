SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `match_id` int(64) NOT NULL,
  `host_team` int(64) NOT NULL,
  `guest_team` int(64) NOT NULL,
  `host_goals` int(64) NOT NULL,
  `guest_goals` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`id`, `match_id`, `host_team`, `guest_team`, `host_goals`, `guest_goals`) VALUES
(1, 1, 10, 20, 3, 0),
(2, 2, 30, 10, 2, 2),
(3, 3, 10, 50, 5, 1),
(4, 4, 20, 30, 1, 0),
(5, 5, 50, 30, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
select*from matches;

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `team_id` int(64) NOT NULL,
  `team_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `team_id`, `team_name`) VALUES
(1, 10, 'FC Barcelona'),
(2, 20, 'NewYork FC'),
(3, 30, 'Atlanta FC'),
(4, 40, 'Chicago FC'),
(5, 50, 'Toronto FC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;
select*from teams;
-- ANSWER--
select team_id, team_name, num_points from (select Teams.team_id, Teams.team_name, sum(case when Teams.team_id = Matches.host_team then
case when Matches.host_goals > Matches.guest_goals then 3
when Matches.host_goals = Matches.guest_goals then 1
else 0
end
when Teams.team_id = Matches.guest_team then
case
when Matches.host_goals < Matches.guest_goals then 3
when Matches.host_goals = Matches.guest_goals then 1
else 0
end
else 0
end) as num_points from Teams left join Matches
on Teams.team_id = Matches.host_team or Teams.team_id = Matches.guest_team
group by Teams.team_id
) result
order by result.num_points desc, result.team_id;