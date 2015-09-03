-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 03, 2015 at 03:38 PM
-- Server version: 5.5.44
-- PHP Version: 5.4.44-0+deb7u1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `inmonitor`
--
CREATE DATABASE `inmonitor` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `inmonitor`;

-- --------------------------------------------------------

--
-- Table structure for table `data`
--

CREATE TABLE IF NOT EXISTS `data` (
  `device_id` tinyint(3) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float(3,1) DEFAULT NULL,
  `humidity` float(3,1) DEFAULT NULL,
  `pressure` float(4,1) DEFAULT NULL,
  `illuminance` float(4,0) DEFAULT NULL,
  `condensed` tinyint(4) NOT NULL,
  PRIMARY KEY (`device_id`,`timestamp`),
  KEY `timestamp` (`timestamp`),
  KEY `device_id` (`device_id`),
  KEY `condensed` (`condensed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE IF NOT EXISTS `devices` (
  `ID` tinyint(3) unsigned NOT NULL COMMENT 'inmonitor-x',
  `password` char(32) NOT NULL COMMENT 'used for data storage only',
  `last_ip` varchar(15) DEFAULT NULL COMMENT 'the ip this device was seen with last time',
  `last_conn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'last time this device was seen',
  `private_ip` varchar(255) DEFAULT NULL COMMENT 'the device''s internal ip address',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
