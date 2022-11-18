CREATE DATABASE  IF NOT EXISTS `btl1`;
USE `btl1`;
--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
INSERT INTO `role` VALUES (1,'ROLE_USER');
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_role_roleid_idx` (`role_id`),
  CONSTRAINT `fk_user_role_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `book`;
CREATE TABLE Book
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    author        VARCHAR(255)          NULL,
    title         VARCHAR(255)          NULL,
    `description` VARCHAR(255)          NULL,
    publishedDate datetime              NULL,
    pages         INT                   NOT NULL,
    type          VARCHAR(255)          NULL,
    CONSTRAINT pk_book PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `fileattachdocument`;
CREATE TABLE FileAttachDocument
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    OBJECT_ID BIGINT                NULL,
    FILE_NAME VARCHAR(150)          NULL,
    FILE_PATH VARCHAR(1000)         NULL,
    FILE_SIZE BIGINT                NULL,
    CONSTRAINT pk_fileattachdocument PRIMARY KEY (id)
);