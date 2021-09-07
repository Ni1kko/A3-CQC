/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

CREATE DATABASE IF NOT EXISTS `a3cqc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `a3cqc`;

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `ID` int(12) NOT NULL,
  `ProfileName` varchar(32) NOT NULL,
  `KnownNames` text NOT NULL,
  `steamID` varchar(64) NOT NULL,
  `Gear` text NOT NULL,
  `AdminRank` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `HasDonated` enum('0','1') NOT NULL DEFAULT '0',
  `characterType` varchar(255) NOT NULL DEFAULT 'C_man_polo_4_F',
  `Joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LastActive` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `clients`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `steamID` (`steamID`),
  ADD KEY `ProfileName` (`ProfileName`);
 
ALTER TABLE `clients`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;
COMMIT;