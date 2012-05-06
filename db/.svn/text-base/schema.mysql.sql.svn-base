-- MySQL dump 10.10
--
-- Host: localhost    Database: ideas_development
-- ------------------------------------------------------
-- Server version	5.0.18-standard


--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
CREATE TABLE `channels` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `identifier` varchar(64) NOT NULL,
  `name` varchar(255) default NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `messages_count` int(11) unsigned NOT NULL default '0',
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `identifier` (`identifier`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `content` varchar(1000) default NULL,
  `channel_id` int(11) unsigned default NULL,
  `session_id` varchar(64) default NULL,
  `ratings_count` int(10) unsigned default '0',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`session_id`),
  KEY `session_id` (`session_id`),
  KEY `created_at` (`created_at`),
  CONSTRAINT `fk_channels_messages` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `session_id` varchar(64) default NULL,
  `created_at` datetime default NULL,
  `message_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `fk_messages_ratings` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;