-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2018 at 04:41 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test1`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addfriend` (IN `p1` INT(11) UNSIGNED, IN `p2` INT(11) UNSIGNED)  NO SQL
BEGIN
	INSERT INTO friends(userid,friendid) VALUES(p1,p2);
    INSERT INTO friends(userid,friendid) VALUES(p2,p1);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `ilce` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `ilce`, `city`, `country`) VALUES
(1, 'Bornova', 'Izmir', 'Turkiye'),
(2, 'Cankaya', 'Ankara', 'Turkiye'),
(3, 'Buca', 'Izmir', 'Turkiye'),
(4, 'Urla', 'Izmir', 'Turkiye'),
(5, 'Merkez', 'Erzincan', 'Turkiye'),
(6, 'Kasgar', 'Kasgar', 'Cin'),
(7, 'Cigli', 'Izmir', 'Turkiye'),
(8, 'Karsiyaka', 'Izmir', 'Turkiye');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `phone` bigint(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `userid`, `email`, `phone`) VALUES
(5, 30, 'capcicapci@gmail.com', 5555555555),
(2, 10, 'egesahpaz@gmail.com', 5550000000),
(1, 28, 'ozgurbariskas@gmail.com', 5550001111),
(4, 10, 'sahpazogul@gmail.com', 5550001100);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `profileid` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `kategori` varchar(30) NOT NULL,
  `location` varchar(30) DEFAULT NULL,
  `frequency` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `profileid`, `name`, `kategori`, `location`, `frequency`) VALUES
(1, 23, 'Sozluk Festivali', 'festival', 'izmir', 'her yil'),
(2, 18, 'Balik Tutma senligi', 'balik', 'izmir', 'Her ay'),
(3, 37, 'BAHAR senliyi', 'senlik', 'kampus', 'Her yil'),
(4, 20, 'dogum gunu festivali', 'fest', 'ev', 'her yil');

-- --------------------------------------------------------

--
-- Table structure for table `facebookprofile`
--

CREATE TABLE `facebookprofile` (
  `profileid` int(11) NOT NULL,
  `type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facebookprofile`
--

INSERT INTO `facebookprofile` (`profileid`, `type`) VALUES
(18, 'users'),
(20, 'users'),
(21, 'users'),
(23, 'page'),
(24, 'page'),
(27, 'users'),
(28, 'users'),
(34, 'users'),
(37, 'page'),
(38, 'users'),
(39, 'groups'),
(40, 'groups'),
(41, 'groups'),
(42, 'groups');

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `userid` int(11) NOT NULL,
  `friendid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`userid`, `friendid`) VALUES
(10, 28),
(10, 30),
(10, 34),
(28, 10),
(28, 30),
(30, 10),
(30, 28),
(30, 31),
(31, 30),
(32, 33),
(32, 34),
(33, 32),
(34, 10),
(34, 32);

-- --------------------------------------------------------

--
-- Table structure for table `groupadmins`
--

CREATE TABLE `groupadmins` (
  `userid` int(11) NOT NULL,
  `groupname` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groupadmins`
--

INSERT INTO `groupadmins` (`userid`, `groupname`) VALUES
(10, 'proje grubu'),
(28, 'Berberler'),
(28, 'proje grubu'),
(30, 'proje grubu'),
(31, 'Guzeller'),
(33, 'Ege universitesi grubu');

--
-- Triggers `groupadmins`
--
DELIMITER $$
CREATE TRIGGER `ai_groupadmins` AFTER INSERT ON `groupadmins` FOR EACH ROW INSERT INTO groupusers(userid,groupname) VALUES(New.userid,New.groupname)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `name` varchar(30) NOT NULL,
  `profileid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`name`, `profileid`) VALUES
('Berberler', 39),
('Guzeller', 40),
('Ege universitesi grubu', 41),
('proje grubu', 42);

--
-- Triggers `groups`
--
DELIMITER $$
CREATE TRIGGER `bi_groups` BEFORE INSERT ON `groups` FOR EACH ROW BEGIN
	INSERT INTO facebookprofile(profileid,type) VALUES('','groups');
	SET New.profileid = (SELECT profileid FROM facebookprofile ORDER BY profileid DESC LIMIT 1);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `groupusers`
--

CREATE TABLE `groupusers` (
  `userid` int(11) NOT NULL,
  `groupname` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groupusers`
--

INSERT INTO `groupusers` (`userid`, `groupname`) VALUES
(10, 'Ege universitesi grubu'),
(10, 'proje grubu'),
(28, 'Berberler'),
(28, 'Ege universitesi grubu'),
(28, 'proje grubu'),
(30, 'Ege universitesi grubu'),
(30, 'proje grubu'),
(31, 'Guzeller'),
(33, 'Ege universitesi grubu'),
(33, 'proje grubu'),
(34, 'Guzeller');

-- --------------------------------------------------------

--
-- Table structure for table `highscholl`
--

CREATE TABLE `highscholl` (
  `name` varchar(30) NOT NULL,
  `userid` int(11) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date DEFAULT NULL,
  `addressid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `highscholl`
--

INSERT INTO `highscholl` (`name`, `userid`, `startdate`, `enddate`, `addressid`) VALUES
('Ege University Lisesi', 10, '2010-09-01', NULL, 1),
('Haluk leven lisesi', 30, '1998-09-01', NULL, 5),
('Kasgar Lisesi', 33, '1040-01-01', '1049-01-01', 6),
('Mustafa Dogan AL', 28, '2011-09-01', '2015-06-01', 5);

--
-- Triggers `highscholl`
--
DELIMITER $$
CREATE TRIGGER `bi_highscholl(checkconstraint)` BEFORE INSERT ON `highscholl` FOR EACH ROW If( (New.startdate > CURRENT_DATE()) OR  (New.enddate != NULL AND New.startdate > New.enddate) )
	THEN
		SIGNAL SQLSTATE '02000'
        	SET MESSAGE_TEXT = 'Invalid dates for highscholl!!!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hobbies`
--

CREATE TABLE `hobbies` (
  `userid` int(11) NOT NULL,
  `hobby` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hobbies`
--

INSERT INTO `hobbies` (`userid`, `hobby`) VALUES
(10, 'kitap okumak'),
(28, 'bilgisayar oyunu oynamak'),
(28, 'masa tenisi oynamak'),
(28, 'siir yazmak'),
(28, 'yemek yemek'),
(30, 'bisiklet surmek'),
(30, 'dondurma yalamak'),
(30, 'kitap okumak'),
(31, 'comlek yapmak'),
(32, 'comlek yapmak'),
(33, 'at surmek'),
(33, 'kitap okumak'),
(33, 'kitap yazmak'),
(33, 'sozluk yazmak'),
(34, 'orgu ormek'),
(34, 'semazen donusu');

-- --------------------------------------------------------

--
-- Table structure for table `joinedevents`
--

CREATE TABLE `joinedevents` (
  `userid` int(11) NOT NULL,
  `eventid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `joinedevents`
--

INSERT INTO `joinedevents` (`userid`, `eventid`) VALUES
(10, 2),
(28, 2),
(30, 2),
(30, 3),
(31, 2),
(32, 2),
(33, 1),
(33, 4),
(34, 4);

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `userid` int(11) NOT NULL,
  `languages` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`userid`, `languages`) VALUES
(10, 'Ingilizce'),
(10, 'Turkce'),
(28, 'Ingilizce'),
(28, 'Turkce'),
(30, 'Ingilizce'),
(30, 'Turkce'),
(31, 'Almanca'),
(31, 'Ingilizce'),
(31, 'Turkce'),
(32, 'Almanca'),
(32, 'Turkce'),
(33, 'Arapca'),
(33, 'Cince'),
(33, 'Farsca'),
(33, 'Latince'),
(33, 'Turkce'),
(34, 'Flamenkce');

-- --------------------------------------------------------

--
-- Table structure for table `livedin`
--

CREATE TABLE `livedin` (
  `userid` int(11) NOT NULL,
  `addressid` int(11) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `livedin`
--

INSERT INTO `livedin` (`userid`, `addressid`, `startdate`, `enddate`) VALUES
(10, 1, '2014-01-01', NULL),
(28, 5, '1997-02-11', '2015-06-01'),
(30, 5, '2010-01-01', '2014-01-01'),
(30, 8, '2014-01-01', NULL),
(33, 6, '1029-01-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `gonderenid` int(11) NOT NULL,
  `alanid` int(11) NOT NULL,
  `content` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`gonderenid`, `alanid`, `content`) VALUES
(30, 28, 'Merhaba bugun beni al'),
(30, 33, 'Merhaba bana sozluk oyretir');

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE `page` (
  `name` varchar(30) NOT NULL,
  `category` varchar(30) NOT NULL,
  `profileid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `page`
--

INSERT INTO `page` (`name`, `category`, `profileid`) VALUES
('Ege University', 'TOPluluk', 37),
('Oracle', 'isletme', 23),
('Tureng', 'isletme', 24);

--
-- Triggers `page`
--
DELIMITER $$
CREATE TRIGGER `bi_page` BEFORE INSERT ON `page` FOR EACH ROW BEGIN
	INSERT INTO facebookprofile(profileid,type) VALUES('','page');
	SET New.profileid = (SELECT profileid FROM facebookprofile ORDER BY profileid DESC LIMIT 1);
    
    
    IF( New.category != 'isletme' AND New.category != 'topluluk' )
    THEN
    SIGNAL SQLSTATE '02000'
        	SET MESSAGE_TEXT = 'category isletme veya topluluk olmali';         END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pageadmins`
--

CREATE TABLE `pageadmins` (
  `userid` int(11) NOT NULL,
  `pagename` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pageadmins`
--

INSERT INTO `pageadmins` (`userid`, `pagename`) VALUES
(28, 'Ege University'),
(28, 'Tureng'),
(30, 'Oracle'),
(33, 'Tureng');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `profileid` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `content` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `profileid`, `type`, `content`) VALUES
(1, 18, 'Text', 'Bugun hastayim'),
(2, 27, 'Video', 'Kucuk Kediler'),
(3, 34, 'Fotograf', 'Kitabin kapagi');

-- --------------------------------------------------------

--
-- Table structure for table `university`
--

CREATE TABLE `university` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date DEFAULT NULL,
  `department` varchar(30) NOT NULL,
  `degree` varchar(30) NOT NULL,
  `genelortalama` float DEFAULT NULL,
  `addressid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `university`
--

INSERT INTO `university` (`id`, `userid`, `name`, `startdate`, `enddate`, `department`, `degree`, `genelortalama`, `addressid`) VALUES
(1, 10, 'Ege University', '2015-06-01', NULL, 'Computer Engineering', 'Lisans', 3.2, 1),
(1, 28, 'Ege University', '2015-09-01', '2017-06-01', 'Muhasebe', 'On Lisans', 4, 1),
(1, 30, 'Ege University', '2016-09-01', NULL, 'Computer Engineering', 'Lisans', 3, 1),
(1, 31, 'Katip Celebi Universitesi', '2005-09-01', '2009-06-01', 'Insaat Muhendisligi', 'Lisans', 2.3, 7),
(1, 32, 'IYTE', '2011-09-01', '2014-06-01', 'Mimarlik', 'Graduate', 2, 4),
(1, 34, 'Ankara Universitesi', '1998-09-01', '2015-06-01', 'Hemsirelik', 'Lisans', 2, 2),
(2, 28, 'Ege University', '2015-09-01', NULL, 'Computer Engineering', 'Lisans', 3.5, 1),
(2, 32, 'Ege University', '2016-09-01', NULL, 'Insaat Muhendisligi', 'Yuksek Lisans', 2, 1);

--
-- Triggers `university`
--
DELIMITER $$
CREATE TRIGGER `bi_university(checkconstraint)` BEFORE INSERT ON `university` FOR EACH ROW If( (New.startdate > CURRENT_DATE()) OR  (New.enddate != NULL AND New.startdate > New.enddate) )
	THEN
		SIGNAL SQLSTATE '02000'
        	SET MESSAGE_TEXT = 'Invalid dates for university!!!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `userlikespage`
--

CREATE TABLE `userlikespage` (
  `userid` int(11) NOT NULL,
  `pagename` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userlikespage`
--

INSERT INTO `userlikespage` (`userid`, `pagename`) VALUES
(10, 'Ege University'),
(10, 'Tureng'),
(28, 'Ege University'),
(30, 'Ege University'),
(30, 'Oracle'),
(31, 'Tureng'),
(32, 'Tureng'),
(33, 'Oracle'),
(33, 'Tureng'),
(34, 'Ege University');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `birthdate` date NOT NULL,
  `sex` varchar(30) NOT NULL,
  `hometown` varchar(30) DEFAULT NULL,
  `profileid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `lastname`, `firstname`, `birthdate`, `sex`, `hometown`, `profileid`) VALUES
(10, 'sahpaz', 'ege', '2018-12-19', 'erkek', 'izmir', 18),
(28, 'kas', 'ozgur', '1997-02-11', 'erkek', 'erzincan', 20),
(30, 'Capci', 'Cankurt', '1996-01-01', 'erkek', 'istanbul', 21),
(31, 'Toprak', 'Ayse', '1980-01-01', 'Kadin', 'istanbul', 27),
(32, 'Toprak', 'Adem', '1978-01-01', 'erkek', 'Edirne', 28),
(33, 'Mahmut', 'Kasgarli', '1029-01-01', 'erkek', 'Kasgar', 34),
(34, 'Yandan', 'Dondu', '1900-01-01', 'kadin', '.Vardar', 38);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `bi_user` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
	INSERT INTO facebookprofile(profileid,type) VALUES('','users');
	SET New.profileid = (SELECT profileid FROM facebookprofile ORDER BY profileid DESC LIMIT 1);
    IF( New.sex != 'erkek' AND New.sex != 'kadin' )
    THEN
    SIGNAL SQLSTATE '02000'
        	SET MESSAGE_TEXT = 'Sex must be erkek or kadin';
            
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bu_user(checkconstraint)` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
	IF( New.sex != 'erkek' AND New.sex != 'kadin' )
    THEN
    SIGNAL SQLSTATE '02000'
        	SET MESSAGE_TEXT = 'Sex must be erkek or kadin';
            
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `userskills`
--

CREATE TABLE `userskills` (
  `userid` int(11) NOT NULL,
  `skill` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userskills`
--

INSERT INTO `userskills` (`userid`, `skill`) VALUES
(10, 'C programlama'),
(10, 'HTML programlama'),
(28, 'C# programlama'),
(28, 'Java programlama'),
(30, 'C programlama'),
(30, 'Java programlama'),
(31, 'Profesyonel yuzucu'),
(32, 'Profesyonel kaleci'),
(33, 'Cevirmen'),
(34, 'Orgu');

-- --------------------------------------------------------

--
-- Table structure for table `works`
--

CREATE TABLE `works` (
  `userid` int(11) NOT NULL,
  `addressid` int(11) NOT NULL,
  `companyname` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `works`
--

INSERT INTO `works` (`userid`, `addressid`, `companyname`, `position`, `startdate`, `enddate`) VALUES
(10, 3, 'Guleryuz Cay Ocagi', 'Garson', '2009-09-01', '2010-01-01'),
(10, 8, 'Karsiyaka Bilisim', 'Stajyer', '2010-01-01', '2015-01-01'),
(30, 2, 'Cankaya Bilisim', 'Stajyer', '2015-01-01', '2015-03-01'),
(31, 1, 'Topraktan Insaat', 'Hammal', '2014-01-01', NULL),
(33, 6, 'Kasgar Matbaa', 'Mudur', '1050-01-01', '1102-01-01'),
(34, 4, 'Urla Terzicisi', 'Cirak', '1990-01-01', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`,`userid`),
  ADD UNIQUE KEY `email` (`email`,`phone`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`,`profileid`),
  ADD KEY `profileid` (`profileid`);

--
-- Indexes for table `facebookprofile`
--
ALTER TABLE `facebookprofile`
  ADD PRIMARY KEY (`profileid`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`userid`,`friendid`),
  ADD KEY `friendid` (`friendid`);

--
-- Indexes for table `groupadmins`
--
ALTER TABLE `groupadmins`
  ADD PRIMARY KEY (`userid`,`groupname`),
  ADD KEY `groupname` (`groupname`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`name`),
  ADD KEY `profileid` (`profileid`);

--
-- Indexes for table `groupusers`
--
ALTER TABLE `groupusers`
  ADD PRIMARY KEY (`userid`,`groupname`),
  ADD KEY `groupname` (`groupname`);

--
-- Indexes for table `highscholl`
--
ALTER TABLE `highscholl`
  ADD PRIMARY KEY (`name`,`userid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `addressid` (`addressid`);

--
-- Indexes for table `hobbies`
--
ALTER TABLE `hobbies`
  ADD PRIMARY KEY (`userid`,`hobby`);

--
-- Indexes for table `joinedevents`
--
ALTER TABLE `joinedevents`
  ADD PRIMARY KEY (`userid`,`eventid`),
  ADD KEY `eventid` (`eventid`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`userid`,`languages`);

--
-- Indexes for table `livedin`
--
ALTER TABLE `livedin`
  ADD PRIMARY KEY (`userid`,`addressid`),
  ADD KEY `addressid` (`addressid`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`gonderenid`,`alanid`),
  ADD KEY `alanid` (`alanid`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`name`),
  ADD KEY `profileid` (`profileid`);

--
-- Indexes for table `pageadmins`
--
ALTER TABLE `pageadmins`
  ADD PRIMARY KEY (`userid`,`pagename`),
  ADD KEY `pagename` (`pagename`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`,`profileid`),
  ADD KEY `profileid` (`profileid`);

--
-- Indexes for table `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`id`,`userid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `addressid` (`addressid`);

--
-- Indexes for table `userlikespage`
--
ALTER TABLE `userlikespage`
  ADD PRIMARY KEY (`userid`,`pagename`),
  ADD KEY `pagename` (`pagename`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profileid` (`profileid`);

--
-- Indexes for table `userskills`
--
ALTER TABLE `userskills`
  ADD PRIMARY KEY (`userid`,`skill`);

--
-- Indexes for table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`userid`,`addressid`),
  ADD KEY `companyname` (`companyname`),
  ADD KEY `works_ibfk_2` (`addressid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `facebookprofile`
--
ALTER TABLE `facebookprofile`
  MODIFY `profileid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `facebookprofile` (`profileid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friendid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groupadmins`
--
ALTER TABLE `groupadmins`
  ADD CONSTRAINT `groupadmins_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `groupadmins_ibfk_2` FOREIGN KEY (`groupname`) REFERENCES `groups` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `facebookprofile` (`profileid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groupusers`
--
ALTER TABLE `groupusers`
  ADD CONSTRAINT `groupusers_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `groupusers_ibfk_2` FOREIGN KEY (`groupname`) REFERENCES `groups` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `highscholl`
--
ALTER TABLE `highscholl`
  ADD CONSTRAINT `highscholl_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `highscholl_ibfk_2` FOREIGN KEY (`addressid`) REFERENCES `address` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `hobbies`
--
ALTER TABLE `hobbies`
  ADD CONSTRAINT `hobbies_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `joinedevents`
--
ALTER TABLE `joinedevents`
  ADD CONSTRAINT `joinedevents_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `joinedevents_ibfk_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `languages`
--
ALTER TABLE `languages`
  ADD CONSTRAINT `languages_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `livedin`
--
ALTER TABLE `livedin`
  ADD CONSTRAINT `livedin_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `livedin_ibfk_2` FOREIGN KEY (`addressid`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`gonderenid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`alanid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `page`
--
ALTER TABLE `page`
  ADD CONSTRAINT `page_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `facebookprofile` (`profileid`);

--
-- Constraints for table `pageadmins`
--
ALTER TABLE `pageadmins`
  ADD CONSTRAINT `pageadmins_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pageadmins_ibfk_2` FOREIGN KEY (`pagename`) REFERENCES `page` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `facebookprofile` (`profileid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `university`
--
ALTER TABLE `university`
  ADD CONSTRAINT `university_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `university_ibfk_2` FOREIGN KEY (`addressid`) REFERENCES `address` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `userlikespage`
--
ALTER TABLE `userlikespage`
  ADD CONSTRAINT `userlikespage_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userlikespage_ibfk_2` FOREIGN KEY (`pagename`) REFERENCES `page` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `facebookprofile` (`profileid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userskills`
--
ALTER TABLE `userskills`
  ADD CONSTRAINT `userskills_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `works`
--
ALTER TABLE `works`
  ADD CONSTRAINT `works_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `works_ibfk_2` FOREIGN KEY (`addressid`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
