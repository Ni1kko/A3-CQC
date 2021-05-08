-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2021 at 04:48 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `a3cqc`
--
CREATE DATABASE IF NOT EXISTS `a3cqc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `a3cqc`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `10MilWarpointLimit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `10MilWarpointLimit` ()  BEGIN
  UPDATE `Warpoints` SET  `Balance` = 9000000 WHERE `Balance` > 10000000;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `ID` int(12) NOT NULL,
  `ProfileName` varchar(32) NOT NULL,
  `KnownNames` text NOT NULL,
  `steamID` varchar(64) NOT NULL,
  `Money` int(100) NOT NULL DEFAULT 0,
  `Gear` text NOT NULL,
  `AdminRank` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `DonatorRank` enum('0','1') NOT NULL DEFAULT '0',
  `Joined` timestamp NOT NULL DEFAULT current_timestamp(),
  `LastActive` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`ID`, `ProfileName`, `KnownNames`, `steamID`, `Money`, `Gear`, `AdminRank`, `DonatorRank`, `Joined`, `LastActive`) VALUES(2, 'Nikko', '\"[`Nikko`]\"', '76561199109931625', 0, '\"[]\"', '0', '1', '2021-05-08 10:40:32', '2021-05-08 10:54:39');

-- --------------------------------------------------------

--
-- Table structure for table `warpoints`
--

DROP TABLE IF EXISTS `warpoints`;
CREATE TABLE `warpoints` (
  `uid` int(11) NOT NULL,
  `SteamID` varchar(32) DEFAULT NULL,
  `Balance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `steamID` (`steamID`),
  ADD KEY `ProfileName` (`ProfileName`);

--
-- Indexes for table `warpoints`
--
ALTER TABLE `warpoints`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warpoints`
--
ALTER TABLE `warpoints`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
