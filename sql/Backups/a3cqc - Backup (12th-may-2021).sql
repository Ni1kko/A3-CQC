-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3308
-- Generation Time: May 12, 2021 at 12:29 PM
-- Server version: 5.7.34-log
-- PHP Version: 8.0.0

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
  `Gear` text NOT NULL,
  `AdminRank` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `HasDonated` enum('0','1') NOT NULL DEFAULT '0',
  `characterType` varchar(255) NOT NULL DEFAULT 'C_man_polo_4_F',
  `Joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LastActive` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`ID`, `ProfileName`, `KnownNames`, `steamID`, `Gear`, `AdminRank`, `HasDonated`, `characterType`, `Joined`, `LastActive`) VALUES
(1, 'bobs', '\"[`xlax`,`bobs`]\"', '76561199110944525', '\"[[`srifle_DMR_03_khaki_F`,`muzzle_snds_B`,`acc_flashlight`,`optic_Arco_blk_F`,[`20Rnd_762x51_Mag`,20],[],``],[],[],[`U_O_V_Soldier_Viper_F`,[]],[`V_PlateCarrierSpec_blk`,[]],[`B_AssaultPack_blk`,[[`20Rnd_762x51_Mag`,3,20],[`20Rnd_762x51_Mag`,1,8],[`20Rnd_762x51_Mag`,1,4],[`20Rnd_762x51_Mag`,1,19],[`20Rnd_762x51_Mag`,1,17],[`20Rnd_762x51_Mag`,1,1],[`20Rnd_762x51_Mag`,1,9],[`20Rnd_762x51_Mag`,1,12]]],`H_HelmetO_ViperSP_ghex_F`,`G_AirPurifyingRespirator_01_F`,[`Rangefinder`,``,``,``,[],[],``],[`ItemMap`,`ItemGPS`,`ItemRadio`,`ItemCompass`,`ItemWatch`,``]]\"', '4', '1', 'C_man_polo_4_F', '2021-05-10 09:16:07', '2021-05-12 04:59:40'),
(2, 'AlecW', '\"[]\"', '76561198048125586', '\"[]\"', '4', '1', 'C_man_polo_4_F', '2021-05-10 19:07:41', '2021-05-10 19:09:50'),
(3, 'Nikko', '\"[`Nikko`]\"', '76561199109931625', '\"[[`srifle_DMR_03_F`,``,``,`optic_Hamr`,[`10Rnd_Mk14_762x51_Mag`,10],[],`bipod_03_F_blk`],[],[`hgun_Pistol_heavy_01_green_F`,``,``,`optic_MRD_black`,[`11Rnd_45ACP_Mag`,11],[],``],[`U_I_C_Soldier_Para_1_F`,[]],[`V_TacVestIR_blk`,[[`11Rnd_45ACP_Mag`,1,11]]],[`B_ViperHarness_blk_F`,[[`10Rnd_Mk14_762x51_Mag`,1,10],[`11Rnd_45ACP_Mag`,10,11],[`10Rnd_Mk14_762x51_Mag`,1,2],[`10Rnd_Mk14_762x51_Mag`,1,4],[`10Rnd_Mk14_762x51_Mag`,1,5]]],`H_ShemagOpen_tan`,``,[`Rangefinder`,``,``,``,[],[],``],[`ItemMap`,`ItemGPS`,`ItemRadio`,`ItemCompass`,`ItemWatch`,`NVGoggles_tna_F`]]\"', '4', '0', 'C_man_polo_4_F', '2021-05-08 10:40:32', '2021-05-12 01:58:10'),
(4, 'SuperStreet | Shawnfin59', '\"[`Versus  | Shawnfin59`,`SuperStreet | Shawnfin59`]\"', '76561198124030122', '\"[[`arifle_MSBS65_UBS_F`,``,``,`optic_Holosight_blk_F`,[`30Rnd_65x39_caseless_msbs_mag`,30],[`6Rnd_12Gauge_Pellets`,2],``],[],[`hgun_Pistol_heavy_01_green_F`,``,``,`optic_MRD_black`,[`11Rnd_45ACP_Mag`,11],[],``],[`U_I_L_Uniform_01_tshirt_sport_F`,[[`11Rnd_45ACP_Mag`,5,11]]],[`V_PlateCarrierGL_blk`,[[`11Rnd_45ACP_Mag`,7,11],[`30Rnd_65x39_caseless_msbs_mag`,3,30],[`6Rnd_12Gauge_Pellets`,3,6]]],[`B_ViperHarness_ghex_F`,[[`11Rnd_45ACP_Mag`,14,11],[`6Rnd_12Gauge_Pellets`,2,6]]],`H_CrewHelmetHeli_O`,`G_Balaclava_combat`,[],[`ItemMap`,`I_E_UavTerminal`,``,`ItemCompass`,`ItemWatch`,`NVGoggles_INDEP`]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-10 00:01:12', '2021-05-12 12:11:11'),
(5, 'SuperStreeT | Tekashi69', '\"[`SuperStreeT | Tekashi69`]\"', '76561199135521586', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:01:30', '2021-05-10 00:24:39'),
(6, 'Ben Askren', '\"[`Ben Askren`]\"', '76561198286758213', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:04:07', '2021-05-11 16:34:32'),
(7, 'sour.hour', '\"[`sour.hour`]\"', '76561199122798000', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:07:54', '2021-05-12 16:58:06'),
(8, 'jorg.krieger.', '\"[]\"', '76561198147768455', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:10:12', '2021-05-10 00:10:12'),
(9, 'rapstar #FreeTheBoys', '\"[`rapstar`,`rapstar #FreeTheBoys`]\"', '76561198060235649', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:13:24', '2021-05-11 02:48:20'),
(10, '17025', '\"[`17025`]\"', '76561199156079239', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:14:12', '2021-05-10 00:14:12'),
(11, 'Chipotle #FreeRapstar', '\"[`Chipotle #FreeRapstar`]\"', '76561198796530241', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:14:28', '2021-05-11 02:46:15'),
(12, 'BUSHMAN', '\"[`BUSHMAN`]\"', '76561198404343125', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:14:33', '2021-05-10 00:17:31'),
(13, 'R4T', '\"[`R4T`]\"', '76561198069407511', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:15:21', '2021-05-10 00:15:21'),
(14, 'Spider', '\"[`Spider`]\"', '76561198146335995', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:16:44', '2021-05-10 00:19:52'),
(15, 'NE0N', '\"[]\"', '76561198984360909', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:16:46', '2021-05-10 00:16:46'),
(16, 'Bera', '\"[]\"', '76561198037042231', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:17:47', '2021-05-10 00:17:47'),
(17, 'StudMuffin23', '\"[]\"', '76561198189904229', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:18:08', '2021-05-10 00:18:08'),
(18, 'poggers', '\"[]\"', '76561198063987361', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:21:27', '2021-05-10 00:21:27'),
(19, 'Teamplayers | J A C K R', '\"[`Teamplayers | J A C K R`]\"', '76561199138598420', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 00:31:15', '2021-05-10 04:13:14'),
(20, 'chris', '\"[]\"', '76561198309303420', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:08:25', '2021-05-10 01:08:25'),
(21, 'panda', '\"[]\"', '76561198981452848', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:13:27', '2021-05-10 01:13:27'),
(22, 'bop it', '\"[]\"', '76561198130027324', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:27:05', '2021-05-10 01:27:05'),
(23, 'TV Salesman', '\"[]\"', '76561198145407902', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:27:22', '2021-05-10 01:27:22'),
(24, 'Ian-Kendall', '\"[]\"', '76561198108068978', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:29:14', '2021-05-10 01:29:14'),
(25, 'damia', '\"[]\"', '76561198940460029', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:33:55', '2021-05-10 01:33:55'),
(26, 'Jmedi', '\"[]\"', '76561199151240904', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 01:35:33', '2021-05-10 01:35:33'),
(27, 'water fiji', '\"[`water fiji`]\"', '76561198339636384', '\"[]\"', '4', '1', 'C_man_polo_4_F', '2021-05-10 01:51:07', '2021-05-10 01:54:06'),
(28, 'halal meat', '\"[`Arma last`,`halal meat`]\"', '76561199089637134', '\"[[`srifle_DMR_03_F`,``,``,`optic_Arco`,[`20Rnd_762x51_Mag`,20],[],`bipod_01_F_blk`],[],[],[`U_BG_Guerilla1_1`,[[`20Rnd_762x51_Mag`,1,20],[`20Rnd_762x51_Mag`,1,3]]],[`V_PlateCarrier2_blk`,[[`20Rnd_762x51_Mag`,11,20]]],[`B_AssaultPack_blk`,[[`20Rnd_762x51_Mag`,13,20]]],`H_Cap_red`,``,[],[`ItemMap`,``,``,`ItemCompass`,`ItemWatch`,``]]\"', '3', '0', 'C_man_polo_4_F', '2021-05-10 01:58:12', '2021-05-12 02:39:51'),
(29, 'Special K', '\"[]\"', '76561198071553873', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 02:00:43', '2021-05-10 02:00:43'),
(30, 'mOE', '\"[`pepe`,`mOE`]\"', '76561199141134832', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 02:03:41', '2021-05-11 13:21:12'),
(31, 'ben', '\"[`ben`]\"', '76561198398910916', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 02:04:05', '2021-05-10 02:06:09'),
(32, 'chant', '\"[]\"', '76561199100760084', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 02:05:33', '2021-05-10 02:05:33'),
(33, 'Mints', '\"[`Mints`]\"', '76561198403816229', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 02:06:12', '2021-05-10 02:09:12'),
(34, 'CougerHater', '\"[]\"', '76561199132651538', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 02:19:58', '2021-05-10 02:19:58'),
(35, 'Reece.', '\"[`Reece.`]\"', '76561198011953438', '\"[]\"', '2', '1', 'C_man_polo_4_F', '2021-05-10 02:28:23', '2021-05-10 02:28:59'),
(36, 'Kanye East', '\"[`Kanye East`]\"', '76561198270967902', '\"[[`srifle_DMR_03_F`,``,``,`optic_Arco_blk_F`,[`20Rnd_762x51_Mag`,20],[],``],[],[],[`U_O_Wetsuit`,[[`20Rnd_762x51_Mag`,1,15],[`20Rnd_762x51_Mag`,1,13],[`20Rnd_762x51_Mag`,1,8],[`20Rnd_762x51_Mag`,1,11],[`20Rnd_762x51_Mag`,1,16],[`20Rnd_762x51_Mag`,1,5]]],[`V_PlateCarrier2_blk`,[[`20Rnd_762x51_Mag`,1,15],[`20Rnd_762x51_Mag`,1,7],[`20Rnd_762x51_Mag`,1,12],[`20Rnd_762x51_Mag`,1,3],[`20Rnd_762x51_Mag`,1,5],[`20Rnd_762x51_Mag`,1,11],[`20Rnd_762x51_Mag`,1,14],[`20Rnd_762x51_Mag`,1,4],[`20Rnd_762x51_Mag`,1,1],[`20Rnd_762x51_Mag`,1,6],[`20Rnd_762x51_Mag`,1,19]]],[`B_FieldPack_green_F`,[[`20Rnd_762x51_Mag`,1,16],[`20Rnd_762x51_Mag`,1,14],[`20Rnd_762x51_Mag`,4,20],[`20Rnd_762x51_Mag`,1,2],[`20Rnd_762x51_Mag`,1,19],[`20Rnd_762x51_Mag`,1,15],[`20Rnd_762x51_Mag`,1,12],[`20Rnd_762x51_Mag`,1,8],[`20Rnd_762x51_Mag`,1,13],[`20Rnd_762x51_Mag`,1,9],[`20Rnd_762x51_Mag`,1,7]]],`H_HelmetLeaderO_ghex_F`,`G_Bandanna_beast`,[],[`ItemMap`,``,`ItemRadio`,`ItemCompass`,`ItemWatch`,``]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-10 04:12:48', '2021-05-12 08:21:46'),
(37, 'trapstar', '\"[`trap`,`trapstar`]\"', '76561199034504598', '\"[[`arifle_ARX_hex_F`,`muzzle_snds_65_TI_blk_F`,``,`optic_Arco_blk_F`,[`30Rnd_65x39_caseless_green`,30],[`10Rnd_50BW_Mag_F`,10],`bipod_02_F_hex`],[],[],[`U_O_PilotCoveralls`,[[`30Rnd_65x39_caseless_green`,1,14],[`30Rnd_65x39_caseless_green`,1,5],[`30Rnd_65x39_caseless_green`,1,1],[`10Rnd_50BW_Mag_F`,1,4],[`30Rnd_65x39_caseless_green`,1,17]]],[`V_PlateCarrier1_blk`,[[`10Rnd_50BW_Mag_F`,1,6],[`30Rnd_65x39_caseless_green`,2,30],[`30Rnd_65x39_caseless_green`,2,11],[`30Rnd_65x39_caseless_green`,1,3],[`30Rnd_65x39_caseless_green`,1,12],[`30Rnd_65x39_caseless_green`,2,5],[`30Rnd_65x39_caseless_green`,1,9],[`30Rnd_65x39_caseless_green`,1,6],[`30Rnd_65x39_caseless_green`,1,10]]],[`B_AssaultPack_cbr`,[[`10Rnd_50BW_Mag_F`,2,10],[`30Rnd_65x39_caseless_green`,10,30],[`30Rnd_65x39_caseless_green`,1,16],[`30Rnd_65x39_caseless_green`,1,11]]],`H_Hat_brown`,``,[`Rangefinder`,``,``,``,[],[],``],[`ItemMap`,`ItemGPS`,`ItemRadio`,`ItemCompass`,`ItemWatch`,``]]\"', '4', '1', 'C_man_polo_4_F', '2021-05-10 04:20:48', '2021-05-12 16:41:57'),
(38, 'SuperStreeT | kuku', '\"[`SuperStreeT | kuku`]\"', '76561199163376861', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 04:38:23', '2021-05-10 04:39:39'),
(39, 'lol', '\"[`woooOOOoohhH`,`huncho x chad`,`instagrammediaconsumer23`,`lol`]\"', '76561198972326191', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 04:56:24', '2021-05-12 08:52:47'),
(40, 'Weedog', '\"[]\"', '76561198337168144', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 07:55:18', '2021-05-10 07:55:18'),
(42, '#Free.Max', '\"[`Britney`,`Eye Lhike Chock`,`#Free.Max`]\"', '76561198387894795', '\"[[`srifle_DMR_03_F`,``,`acc_flashlight`,`optic_Arco_blk_F`,[`20Rnd_762x51_Mag`,20],[],`bipod_01_F_blk`],[],[],[`U_O_Wetsuit`,[[`20Rnd_762x51_Mag`,6,20]]],[`V_PlateCarrier2_blk`,[[`20Rnd_762x51_Mag`,11,20]]],[`B_FieldPack_blk`,[[`20Rnd_762x51_Mag`,16,20]]],`H_HelmetSpecB_paint1`,`G_Balaclava_lowprofile`,[],[`ItemMap`,``,``,`ItemCompass`,`ItemWatch`,``]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-10 16:32:36', '2021-05-11 20:50:26'),
(43, 'i n v i c t u s', '\"[`i n v i c t u s`]\"', '76561198098289994', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 16:37:49', '2021-05-10 21:40:32'),
(44, '46735', '\"[]\"', '76561198200418918', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 17:21:41', '2021-05-10 17:21:41'),
(45, 'Ken', '\"[]\"', '76561199002369355', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 18:45:46', '2021-05-10 18:45:46'),
(47, 'Erik Hallerstrom', '\"[]\"', '76561199025710222', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 19:15:14', '2021-05-10 19:15:14'),
(48, 'Joe Kelly', '\"[`Joe Kelly`]\"', '76561199011127274', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 19:57:48', '2021-05-10 19:57:48'),
(49, 'frick', '\"[`frick`]\"', '76561198211922731', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 19:59:38', '2021-05-11 04:43:27'),
(50, 'mr swag boss', '\"[]\"', '76561198012272139', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 20:01:20', '2021-05-10 20:01:20'),
(51, 'Gagss', '\"[`Gagss`]\"', '76561198202574468', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 20:25:52', '2021-05-11 04:52:17'),
(52, 'Drich', '\"[`Drich`]\"', '76561198799285090', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 21:25:05', '2021-05-10 21:45:47'),
(53, 'Stephen Allen', '\"[`Stephen Allen`]\"', '76561198844813270', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 21:33:10', '2021-05-10 21:33:46'),
(54, 'no sirr', '\"[`no sirr`]\"', '76561198321098387', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 21:43:45', '2021-05-10 21:45:06'),
(55, 'LAYOO', '\"[`LAYOO`]\"', '76561198021266045', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 22:09:29', '2021-05-10 22:14:46'),
(56, '.RoidRage', '\"[`.RoidRage`]\"', '76561198147337307', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 22:16:43', '2021-05-10 22:17:41'),
(57, '19045', '\"[]\"', '76561198264633517', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 22:26:37', '2021-05-10 22:26:37'),
(58, 'sebas', '\"[]\"', '76561199099385275', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 22:30:00', '2021-05-10 22:30:00'),
(59, 'Teamplayers | JMONEY', '\"[`Teamplayers | JMONEY`]\"', '76561198260711886', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 22:35:01', '2021-05-10 22:37:21'),
(60, 'yurd', '\"[`yurd`]\"', '76561198370337837', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 22:36:02', '2021-05-10 22:36:52'),
(61, 'Juan Salas', '\"[]\"', '76561199116775632', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-10 23:33:29', '2021-05-10 23:33:29'),
(62, 'TallTeddyMan', '\"[]\"', '76561199089285334', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 00:20:03', '2021-05-11 00:20:03'),
(63, 'spongebob', '\"[`spongebob`]\"', '76561199068255643', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:03:56', '2021-05-11 02:06:07'),
(64, 'SuperStreeT| Scoutta', '\"[`SuperStreeT| Scoutta`]\"', '76561197989231996', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:13:42', '2021-05-11 02:13:42'),
(65, 'Patrick', '\"[`Patrick`]\"', '76561198271991102', '\"[]\"', '0', '1', 'C_man_polo_4_F', '2021-05-11 02:14:38', '2021-05-11 02:23:27'),
(66, 'forne', '\"[]\"', '76561198328290059', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:14:40', '2021-05-11 02:14:40'),
(67, 'In there like swimwear', '\"[`In there like swimwear`]\"', '76561198134558140', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:24:43', '2021-05-11 02:27:11'),
(68, 'Woofter', '\"[`Woofter`]\"', '76561198155783181', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:26:28', '2021-05-11 02:29:09'),
(69, '[] Lil_Calzone.', '\"[`[] Lil_Calzone.`]\"', '76561198440522347', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:49:40', '2021-05-11 02:53:11'),
(70, 'Isaiah', '\"[]\"', '76561199163771806', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:53:56', '2021-05-11 02:53:56'),
(71, 'shmolty', '\"[`Mateo Kapri`,`shmolty`]\"', '76561199079328578', '\"[]\"', '0', '1', 'C_man_polo_4_F', '2021-05-11 02:57:23', '2021-05-11 03:07:11'),
(72, 'Chapo Guzman', '\"[`Chapo Guzman`]\"', '76561197967682950', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 02:58:08', '2021-05-11 03:02:08'),
(73, 'oppa stoppa', '\"[`᲼᲼᲼᲼᲼  `,`oppa stoppa`]\"', '76561198942538304', '\"[[`srifle_DMR_03_F`,`muzzle_snds_B_snd_F`,`acc_flashlight`,`optic_Arco`,[`20Rnd_762x51_Mag`,20],[],`bipod_01_F_snd`],[],[],[`U_I_G_Story_Protagonist_F`,[[`20Rnd_762x51_Mag`,1,4],[`20Rnd_762x51_Mag`,1,13],[`20Rnd_762x51_Mag`,1,15]]],[`V_PlateCarrier2_rgr_noflag_F`,[[`20Rnd_762x51_Mag`,7,20],[`20Rnd_762x51_Mag`,1,10]]],[`B_LegStrapBag_olive_F`,[]],`H_Cap_oli`,`G_Balaclava_TI_G_blk_F`,[`Rangefinder`,``,``,``,[],[],``],[`ItemMap`,`ItemGPS`,`ItemRadio`,`ItemCompass`,`ItemWatch`,``]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-11 03:14:21', '2021-05-12 01:33:33'),
(74, 'braya', '\"[`braya`]\"', '76561198363238696', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 03:25:57', '2021-05-11 03:43:19'),
(82, 'Trinity | Logitech G502', '\"[`Trinity | Logitech G502`]\"', '76561198162984691', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 05:18:08', '2021-05-11 05:18:08'),
(88, 'o7 Doctor Doom', '\"[`!dooooooooooooooooooooom`,`V I B E S :)`,`o7 Sovereign`,`o7 Doctor Doom`]\"', '76561198073556138', '\"[[`LMG_Mk200_F`,`muzzle_snds_H_SW`,`acc_flashlight`,`optic_Arco`,[`200Rnd_65x39_cased_Box_Tracer`,200],[],`bipod_01_F_snd`],[],[],[`U_I_CBRN_Suit_01_AAF_F`,[[`20Rnd_762x51_Mag`,1,3],[`20Rnd_762x51_Mag`,1,18]]],[`V_PlateCarrier1_wdl`,[[`200Rnd_65x39_cased_Box_Tracer`,2,200]]],[`B_AssaultPack_dgtl`,[[`200Rnd_65x39_cased_Box_Tracer`,3,200]]],`H_CrewHelmetHeli_I`,`G_Balaclava_oli`,[`Rangefinder`,``,``,``,[],[],``],[`ItemMap`,`ItemGPS`,`ItemRadio`,`ItemCompass`,`ItemWatch`,`NVGoggles_INDEP`]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-11 05:45:48', '2021-05-12 08:17:06'),
(94, 'User', '\"[`User`]\"', '76561199031690690', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 05:52:30', '2021-05-11 05:52:31'),
(96, 'shadow', '\"[`shadow`]\"', '76561198240934460', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 06:38:41', '2021-05-11 06:38:41'),
(102, 'Blanco Sanchez', '\"[`Blanco Sanchez`]\"', '76561199100504249', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 06:52:55', '2021-05-11 06:52:55'),
(103, 'Teamplayers | Walt', '\"[`Teamplayers | Walt`]\"', '76561198131355339', '\"[[`LMG_Mk200_F`,`muzzle_snds_H_MG_blk_F`,`acc_flashlight`,`optic_Arco`,[`200Rnd_65x39_cased_Box_Tracer`,200],[],`bipod_01_F_snd`],[],[],[`U_I_Wetsuit`,[[`200Rnd_65x39_cased_Box_Tracer`,1,200]]],[`V_PlateCarrierIAGL_oli`,[[`200Rnd_65x39_cased_Box_Tracer`,2,200]]],[`B_AssaultPack_dgtl`,[[`200Rnd_65x39_cased_Box_Tracer`,3,200]]],`H_Cap_Black_IDAP_F`,``,[],[`ItemMap`,``,`ItemRadio`,`ItemCompass`,`ItemWatch`,``]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-11 06:59:12', '2021-05-12 09:29:10'),
(106, 'rustyyy', '\"[`ocean`,`rustyyy`]\"', '76561198086600532', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 07:15:55', '2021-05-12 08:54:30'),
(110, 'Benny', '\"[`Benny`]\"', '76561199010042214', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 07:21:06', '2021-05-11 07:21:06'),
(113, 'Owner', '\"[`Owner`]\"', '76561199141458993', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 07:23:05', '2021-05-11 07:23:05'),
(119, 'Brattan Rattan', '\"[`Brattan Rattan`]\"', '76561199047910520', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 07:34:52', '2021-05-11 07:34:52'),
(120, 'fright', '\"[`fright`]\"', '76561198083954586', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 07:45:33', '2021-05-11 07:45:33'),
(124, 'Jonas Beac', '\"[`Jonas Beac`]\"', '76561199017957843', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 08:34:33', '2021-05-11 08:34:33'),
(125, '|Fallen| Corza', '\"[`|Fallen| Corza`]\"', '76561198069107093', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 10:03:28', '2021-05-11 10:03:28'),
(128, 'Bloodsport', '\"[`Charlie wors`,`Bloodsport`]\"', '76561198271089352', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 10:50:58', '2021-05-11 20:28:39'),
(135, 'Metal Fragments', '\"[`Metal Fragments`]\"', '76561198079763262', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 16:45:19', '2021-05-11 16:45:19'),
(136, '{LT} ronald', '\"[`{LT} ronald`]\"', '76561198092758461', '\"[]\"', '3', '0', 'C_man_polo_4_F', '2021-05-11 17:39:26', '2021-05-11 23:06:23'),
(137, 'Handle Braincells', '\"[`Handle Braincells`]\"', '76561198132884120', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 17:40:01', '2021-05-11 17:40:01'),
(138, 'ben', '\"[`ben`]\"', '76561198083212508', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 17:45:07', '2021-05-11 17:45:07'),
(139, 'josh', '\"[`josh`]\"', '76561198094314157', '\"[[`LMG_Mk200_F`,`muzzle_snds_H_MG`,`acc_flashlight`,`optic_Arco`,[`200Rnd_65x39_cased_Box_Tracer`,194],[],`bipod_01_F_snd`],[],[],[`U_B_CombatUniform_mcam_worn`,[]],[`V_PlateCarrier1_rgr`,[[`200Rnd_65x39_cased_Box_Tracer`,1,126],[`200Rnd_65x39_cased_Box_Tracer`,1,63]]],[`B_FieldPack_ocamo`,[[`200Rnd_65x39_cased_Box_Tracer`,1,192],[`200Rnd_65x39_cased_Box_Tracer`,1,180],[`200Rnd_65x39_cased_Box_Tracer`,1,151],[`200Rnd_65x39_cased_Box_Tracer`,1,163]]],`H_Booniehat_khk_hs`,`G_Balaclava_blk`,[],[`ItemMap`,``,``,`ItemCompass`,`ItemWatch`,``]]\"', '0', '1', 'C_man_polo_4_F', '2021-05-11 17:51:44', '2021-05-12 16:48:07'),
(140, 'Trioxide', '\"[`Trioxide`]\"', '76561199098485754', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 18:39:55', '2021-05-11 18:39:55'),
(141, 'Dylan Stephensons', '\"[`Dylan Stephensons`]\"', '76561198357829878', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 20:23:40', '2021-05-11 20:23:40'),
(142, 'smh', '\"[`smh`]\"', '76561198880342796', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 20:23:41', '2021-05-11 20:23:41'),
(143, 'yeezys_', '\"[`yeezys_`]\"', '76561198340557589', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 20:25:14', '2021-05-11 20:25:14'),
(144, 'watermelon', '\"[`watermelon`]\"', '76561198355226375', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 20:41:15', '2021-05-11 20:41:15'),
(145, 'Little', '\"[`Little`]\"', '76561198169146689', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 20:47:18', '2021-05-11 20:47:18'),
(146, '87 [LT]', '\"[`87 [LT]`]\"', '76561198174798250', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 20:58:23', '2021-05-11 20:58:23'),
(147, 'isaia', '\"[`isaia`]\"', '76561199091328818', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-11 21:48:42', '2021-05-11 21:48:42'),
(148, 'lilsl', '\"[`lilsl`]\"', '76561199117905288', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 00:41:09', '2021-05-12 00:41:09'),
(149, 'Santi', '\"[`Santi`]\"', '76561198330946196', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 00:41:26', '2021-05-12 00:41:26'),
(150, 'Caio', '\"[`Caio`]\"', '76561199077671383', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 01:36:05', '2021-05-12 01:36:05'),
(151, 'Roland', '\"[`Roland`]\"', '76561199169030618', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 01:37:33', '2021-05-12 01:37:33'),
(152, 'NoginRipper', '\"[`NoginRipper`]\"', '76561198940720868', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 01:46:32', '2021-05-12 01:46:32'),
(153, 'Capin', '\"[`Capin`]\"', '76561198119642738', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 01:50:23', '2021-05-12 01:50:23'),
(154, 'nithie', '\"[`nithie`]\"', '76561198325676783', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 01:52:18', '2021-05-12 01:52:18'),
(155, 'arman', '\"[`arman`]\"', '76561198122374083', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 02:38:50', '2021-05-12 02:38:50'),
(156, 'Figleton', '\"[`Figleton`]\"', '76561198807799832', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 02:59:38', '2021-05-12 02:59:38'),
(157, 'ricky', '\"[`ricky`]\"', '76561199113433088', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 03:13:24', '2021-05-12 03:13:24'),
(158, 'kwyat', '\"[`kwyat`]\"', '76561199161407564', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 03:46:13', '2021-05-12 03:46:13'),
(159, 'Maxthedoggo', '\"[`Maxthedoggo`]\"', '76561198796204075', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 04:15:14', '2021-05-12 04:15:14'),
(160, 'Oafike', '\"[`Oafike`]\"', '76561198157510953', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 04:17:41', '2021-05-12 04:17:41'),
(161, 'NJarl', '\"[`NJarl`]\"', '76561199106587866', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 05:03:57', '2021-05-12 05:03:57'),
(162, 'jonathanmatabreychail384', '\"[`jonathanmatabreychail384`]\"', '76561198820091968', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 05:26:47', '2021-05-12 05:26:47'),
(163, 'Venom', '\"[`Venom`]\"', '76561198169931994', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 05:59:53', '2021-05-12 05:59:53'),
(164, 'destr0yer', '\"[`destr0yer`]\"', '76561198000646572', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 07:43:47', '2021-05-12 07:43:47'),
(165, 'HooDi', '\"[`HooDi`]\"', '76561198135657789', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 07:48:24', '2021-05-12 07:48:24'),
(166, 'Mason :)', '\"[`Mason :)`]\"', '76561198157118837', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 09:16:19', '2021-05-12 09:16:19'),
(167, 'NeverEnding', '\"[`NeverEnding`]\"', '76561198152239541', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 12:55:39', '2021-05-12 12:55:39'),
(168, 'GaijinSMASH', '\"[`GaijinSMASH`]\"', '76561198020482757', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 12:56:34', '2021-05-12 12:56:34'),
(169, 'Hypersomnia', '\"[`Hypersomnia`]\"', '76561198349212799', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 16:06:24', '2021-05-12 16:06:24'),
(170, 'P | ....', '\"[`P | ....`]\"', '76561198930235567', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 16:54:54', '2021-05-12 16:54:54'),
(171, 'Frankie', '\"[`Frankie`]\"', '76561199110574142', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 16:58:50', '2021-05-12 16:58:50'),
(172, 'randy', '\"[`randy`]\"', '76561199024647453', '\"[]\"', '0', '0', 'C_man_polo_4_F', '2021-05-12 18:33:58', '2021-05-12 18:33:58');

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;