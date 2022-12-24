


CREATE DATABASE  IF NOT EXISTS `btl1`;
USE `btl1`;
--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
INSERT INTO `role` VALUES (1,'ROLE_USER');
INSERT INTO `role` VALUES (2,'ROLE_ADMIN');

UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
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
  `user_id` BIGINT NOT NULL,
  `role_id` BIGINT NOT NULL,
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
    pages         INT                   NULL,
    type          INT                   NULL,
    remain     INT                      NULL,
    price         BIGINT                NULL,
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

-- order_book
DROP TABLE IF EXISTS `order_book`;
CREATE TABLE order_book
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    book_id   BIGINT                NULL,
    user_id   BIGINT                NULL,
    quantity  INT                   NULL,
    total     BIGINT                   NULL,
    status    INT                   NULL,
    buy_date  datetime              NULL,
    address   VARCHAR(255)          NULL,
    phone    VARCHAR(255)          NULL,
    order_history_id VARCHAR(255)          NULL,
    CONSTRAINT pk_order_book PRIMARY KEY (id),
    CONSTRAINT fk_order_book_book_id FOREIGN KEY (book_id) REFERENCES book (id),
    CONSTRAINT fk_order_book_user_id FOREIGN KEY (user_id) REFERENCES user (id)
);

--vote
DROP TABLE IF EXISTS `vote`;
CREATE TABLE vote
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    book_id   BIGINT                NULL,
    user_id   BIGINT                NULL,
    vote      INT                   NULL,
    comment   VARCHAR(255)          NULL,
    voteDate  datetime              NULL,
    CONSTRAINT pk_vote PRIMARY KEY (id),
    CONSTRAINT fk_vote_book_id FOREIGN KEY (book_id) REFERENCES book (id),
    CONSTRAINT fk_vote_user_id FOREIGN KEY (user_id) REFERENCES user (id)
);