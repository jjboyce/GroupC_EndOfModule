CREATE DATABASE  IF NOT EXISTS `endofmod` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `endofmod`;
-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: endofmod
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Committee`
--

DROP TABLE IF EXISTS `Committee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Committee` (
  `Committee_name` varchar(50) NOT NULL,
  `area` varchar(200) NOT NULL,
  PRIMARY KEY (`Committee_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Committee`
--

LOCK TABLES `Committee` WRITE;
/*!40000 ALTER TABLE `Committee` DISABLE KEYS */;
INSERT INTO `Committee` VALUES ('Student Well Being','Health and care'),('Teaching Association','education and development');
/*!40000 ALTER TABLE `Committee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Committee_members`
--

DROP TABLE IF EXISTS `Committee_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Committee_members` (
  `Committee_name` varchar(50) NOT NULL,
  `member_id` varchar(200) NOT NULL,
  PRIMARY KEY (`Committee_name`,`member_id`),
  KEY `fk_committeeMembers` (`member_id`),
  CONSTRAINT `fk_committeeMembers` FOREIGN KEY (`member_id`) REFERENCES `Lecturers` (`Lecturer_id`),
  CONSTRAINT `fk_committeeName` FOREIGN KEY (`Committee_name`) REFERENCES `Committee` (`Committee_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Committee_members`
--

LOCK TABLES `Committee_members` WRITE;
/*!40000 ALTER TABLE `Committee_members` DISABLE KEYS */;
INSERT INTO `Committee_members` VALUES ('Student Well Being','5cd1ec6c-69f4-11f0-95f0-35315722a6d8'),('Teaching Association','5cd1ec6c-69f4-11f0-95f0-35315722a6d8'),('Student Well Being','602a3252-69f4-11f0-95f0-35315722a6d8'),('Teaching Association','602a3252-69f4-11f0-95f0-35315722a6d8'),('Student Well Being','60967778-69f4-11f0-95f0-35315722a6d8'),('Teaching Association','60967778-69f4-11f0-95f0-35315722a6d8'),('Teaching Association','61115970-69f4-11f0-95f0-35315722a6d8'),('Teaching Association','619a7b6a-69f4-11f0-95f0-35315722a6d8');
/*!40000 ALTER TABLE `Committee_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course_requirements`
--

DROP TABLE IF EXISTS `Course_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Course_requirements` (
  `course_code` varchar(50) NOT NULL,
  `program_name` varchar(200) NOT NULL,
  PRIMARY KEY (`course_code`,`program_name`),
  KEY `fk_courseProgram` (`program_name`),
  CONSTRAINT `fk_courseCode` FOREIGN KEY (`course_code`) REFERENCES `Courses` (`course_code`),
  CONSTRAINT `fk_courseProgram` FOREIGN KEY (`program_name`) REFERENCES `Programs` (`program_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course_requirements`
--

LOCK TABLES `Course_requirements` WRITE;
/*!40000 ALTER TABLE `Course_requirements` DISABLE KEYS */;
INSERT INTO `Course_requirements` VALUES ('CS101','Master of Science in Computer Science'),('CS102','Master of Science in Computer Science'),('CS103','Master of Science in Computer Science'),('CS50','Master of Science in Computer Science'),('CS101','Master of Science in Data Science'),('CS102','Master of Science in Data Science'),('CS103','Master of Science in Data Science'),('CS50','Master of Science in Data Science'),('DS101','Master of Science in Data Science');
/*!40000 ALTER TABLE `Course_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Courses`
--

DROP TABLE IF EXISTS `Courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Courses` (
  `course_code` varchar(50) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `department_name` varchar(200) NOT NULL,
  `prerequisites` varchar(200) DEFAULT NULL,
  `schedule` varchar(200) NOT NULL,
  PRIMARY KEY (`course_code`),
  KEY `fk_departmentCourses` (`department_name`),
  CONSTRAINT `fk_departmentCourses` FOREIGN KEY (`department_name`) REFERENCES `Departments` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Courses`
--

LOCK TABLES `Courses` WRITE;
/*!40000 ALTER TABLE `Courses` DISABLE KEYS */;
INSERT INTO `Courses` VALUES ('CS101','Introduction to Networking','Computer Science',NULL,'Tue 3pm'),('CS102','Introduction to Programming','Computer Science',NULL,'Tue 5pm'),('CS103','Introduction to Algorithm','Computer Science',NULL,'Wed 4pm'),('CS50','Introduction to Computer Science','Computer Science',NULL,'Mon 11am'),('DS101','Introduction to Machine Learning','Data Science',NULL,'Fri 4pm');
/*!40000 ALTER TABLE `Courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departments` (
  `department_name` varchar(50) NOT NULL,
  `faculty` varchar(50) NOT NULL,
  PRIMARY KEY (`department_name`),
  KEY `fk_faculty` (`faculty`),
  CONSTRAINT `fk_faculty` FOREIGN KEY (`faculty`) REFERENCES `Faculties` (`faculty_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departments`
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` VALUES ('History','Arts'),('Linguistics','Arts'),('Music','Arts'),('Philosophy','Arts'),('Computer Science','Engineering'),('Data Science','Engineering'),('Electronic Engineering','Engineering'),('PCLL','Law'),('Biology','Science'),('Physics','Science');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faculties`
--

DROP TABLE IF EXISTS `Faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Faculties` (
  `faculty_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`faculty_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculties`
--

LOCK TABLES `Faculties` WRITE;
/*!40000 ALTER TABLE `Faculties` DISABLE KEYS */;
INSERT INTO `Faculties` VALUES ('Arts','arts@liv.ac.uk'),('Engineering','engineering@liv.ac.uk'),('Law','law@liv.ac.uk'),('Science','science@liv.ac.uk');
/*!40000 ALTER TABLE `Faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lecturers`
--

DROP TABLE IF EXISTS `Lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lecturers` (
  `Lecturer_id` varchar(200) NOT NULL DEFAULT (uuid()),
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `department_name` varchar(200) NOT NULL,
  `research_area` varchar(200) NOT NULL,
  PRIMARY KEY (`Lecturer_id`),
  KEY `fk_departmentLecturers` (`department_name`),
  CONSTRAINT `fk_departmentLecturers` FOREIGN KEY (`department_name`) REFERENCES `departments` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lecturers`
--

LOCK TABLES `Lecturers` WRITE;
/*!40000 ALTER TABLE `Lecturers` DISABLE KEYS */;
INSERT INTO `Lecturers` VALUES ('5cd1ec6c-69f4-11f0-95f0-35315722a6d8','Alan','Turing','Computer Science','Cryptography'),('602a3252-69f4-11f0-95f0-35315722a6d8','Linus','Torvalds','Computer Science','Programming Languages'),('60967778-69f4-11f0-95f0-35315722a6d8','Bill','Gates','Computer Science','Software Engineering'),('61115970-69f4-11f0-95f0-35315722a6d8','Donald','Knuth','Computer Science','Algorithm'),('619a7b6a-69f4-11f0-95f0-35315722a6d8','James','Gosling','Computer Science','Programming Languages'),('a87682ca-6a1e-11f0-9e44-a70627b20609','Alan','Turing','Computer Science','Cryptography'),('a876ace6-6a1e-11f0-9e44-a70627b20609','Linus','Torvalds','Computer Science','Programming Languages'),('a876d41e-6a1e-11f0-9e44-a70627b20609','Bill','Gates','Computer Science','Software Engineering'),('a876f23c-6a1e-11f0-9e44-a70627b20609','Donald','Knuth','Computer Science','Algorithm'),('a8771104-6a1e-11f0-9e44-a70627b20609','James','Gosling','Computer Science','Programming Languages'),('ae63ede4-6a1e-11f0-9e44-a70627b20609','Alan','Turing','Computer Science','Cryptography'),('ae643dee-6a1e-11f0-9e44-a70627b20609','Linus','Torvalds','Computer Science','Programming Languages'),('ae648c5e-6a1e-11f0-9e44-a70627b20609','Bill','Gates','Computer Science','Software Engineering'),('ae64d09c-6a1e-11f0-9e44-a70627b20609','Donald','Knuth','Computer Science','Algorithm'),('ae6505b2-6a1e-11f0-9e44-a70627b20609','James','Gosling','Computer Science','Programming Languages');
/*!40000 ALTER TABLE `Lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Non_Academic_Staff`
--

DROP TABLE IF EXISTS `Non_Academic_Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Non_Academic_Staff` (
  `staff_id` varchar(200) NOT NULL DEFAULT (uuid()),
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `department_name` varchar(200) NOT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_departmentStaff` (`department_name`),
  CONSTRAINT `fk_departmentStaff` FOREIGN KEY (`department_name`) REFERENCES `departments` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Non_Academic_Staff`
--

LOCK TABLES `Non_Academic_Staff` WRITE;
/*!40000 ALTER TABLE `Non_Academic_Staff` DISABLE KEYS */;
INSERT INTO `Non_Academic_Staff` VALUES ('a875b746-6a1e-11f0-9e44-a70627b20609','Joe','Parmer','Computer Science'),('a875e414-6a1e-11f0-9e44-a70627b20609','Hilary','Terry','Computer Science'),('a8761164-6a1e-11f0-9e44-a70627b20609','Paul','Lee','Data Science'),('a8763072-6a1e-11f0-9e44-a70627b20609','Alex','Cole','Physics'),('a87655ca-6a1e-11f0-9e44-a70627b20609','Steve','Delap','Music'),('ae626bae-6a1e-11f0-9e44-a70627b20609','Joe','Parmer','Computer Science'),('ae62d44a-6a1e-11f0-9e44-a70627b20609','Hilary','Terry','Computer Science'),('ae6338cc-6a1e-11f0-9e44-a70627b20609','Paul','Lee','Data Science'),('ae637b16-6a1e-11f0-9e44-a70627b20609','Alex','Cole','Physics'),('ae63b342-6a1e-11f0-9e44-a70627b20609','Steve','Delap','Music'),('e45570e0-69f0-11f0-95f0-35315722a6d8','Joe','Parmer','Computer Science'),('e4dcfa42-69f0-11f0-95f0-35315722a6d8','Hilary','Terry','Computer Science'),('e54dc0b0-69f0-11f0-95f0-35315722a6d8','Paul','Lee','Data Science'),('e5bf5a0e-69f0-11f0-95f0-35315722a6d8','Alex','Cole','Physics'),('e639a700-69f0-11f0-95f0-35315722a6d8','Steve','Delap','Music');
/*!40000 ALTER TABLE `Non_Academic_Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Programs`
--

DROP TABLE IF EXISTS `Programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Programs` (
  `program_name` varchar(50) NOT NULL,
  PRIMARY KEY (`program_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Programs`
--

LOCK TABLES `Programs` WRITE;
/*!40000 ALTER TABLE `Programs` DISABLE KEYS */;
INSERT INTO `Programs` VALUES ('Master of Science in Computer Science'),('Master of Science in Data Science');
/*!40000 ALTER TABLE `Programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registered_courses`
--

DROP TABLE IF EXISTS `Registered_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registered_courses` (
  `course_code` varchar(50) NOT NULL,
  `lecturer_id` varchar(200) NOT NULL,
  `student_id` varchar(200) NOT NULL,
  `grade` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`course_code`,`lecturer_id`,`student_id`),
  KEY `fk_registeredStudent` (`student_id`),
  KEY `fk_registeredLecturer` (`lecturer_id`),
  CONSTRAINT `fk_registeredCourses` FOREIGN KEY (`course_code`) REFERENCES `Courses` (`course_code`),
  CONSTRAINT `fk_registeredLecturer` FOREIGN KEY (`lecturer_id`) REFERENCES `Lecturers` (`Lecturer_id`),
  CONSTRAINT `fk_registeredStudent` FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registered_courses`
--

LOCK TABLES `Registered_courses` WRITE;
/*!40000 ALTER TABLE `Registered_courses` DISABLE KEYS */;
INSERT INTO `Registered_courses` VALUES ('CS101','602a3252-69f4-11f0-95f0-35315722a6d8','6e7830cc-69fc-11f0-95f0-35315722a6d8',60.00),('CS101','602a3252-69f4-11f0-95f0-35315722a6d8','7e71e3f6-69fc-11f0-95f0-35315722a6d8',80.00),('CS101','602a3252-69f4-11f0-95f0-35315722a6d8','8ddedc90-69fc-11f0-95f0-35315722a6d8',70.00),('CS102','602a3252-69f4-11f0-95f0-35315722a6d8','6e7830cc-69fc-11f0-95f0-35315722a6d8',60.00),('CS102','602a3252-69f4-11f0-95f0-35315722a6d8','7e71e3f6-69fc-11f0-95f0-35315722a6d8',80.00),('CS102','602a3252-69f4-11f0-95f0-35315722a6d8','8ddedc90-69fc-11f0-95f0-35315722a6d8',70.00),('CS50','5cd1ec6c-69f4-11f0-95f0-35315722a6d8','6e7830cc-69fc-11f0-95f0-35315722a6d8',50.00),('CS50','5cd1ec6c-69f4-11f0-95f0-35315722a6d8','7e71e3f6-69fc-11f0-95f0-35315722a6d8',80.00),('CS50','5cd1ec6c-69f4-11f0-95f0-35315722a6d8','8ddedc90-69fc-11f0-95f0-35315722a6d8',80.00);
/*!40000 ALTER TABLE `Registered_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Students` (
  `student_id` varchar(200) NOT NULL DEFAULT (uuid()),
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `advisor` varchar(200) NOT NULL,
  `program_enroll_in` varchar(200) NOT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_studentAdvisor` (`advisor`),
  KEY `fk_studentProgram` (`program_enroll_in`),
  CONSTRAINT `fk_studentAdvisor` FOREIGN KEY (`advisor`) REFERENCES `Lecturers` (`Lecturer_id`),
  CONSTRAINT `fk_studentProgram` FOREIGN KEY (`program_enroll_in`) REFERENCES `Programs` (`program_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students` VALUES ('6e7830cc-69fc-11f0-95f0-35315722a6d8','Isaac','Newton','5cd1ec6c-69f4-11f0-95f0-35315722a6d8','Master of Science in Computer Science'),('7e71e3f6-69fc-11f0-95f0-35315722a6d8','Winsotn','Churchill','602a3252-69f4-11f0-95f0-35315722a6d8','Master of Science in Computer Science'),('8ddedc90-69fc-11f0-95f0-35315722a6d8','William','Shakespeare','60967778-69f4-11f0-95f0-35315722a6d8','Master of Science in Computer Science');
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-27 22:28:12
