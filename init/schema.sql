CREATE DATABASE  IF NOT EXISTS `sistema_voluntariado` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `sistema_voluntariado`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistema_voluntariado
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad` (
  `id_actividad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_actividad` varchar(150) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `id_beneficiario` int(11) DEFAULT NULL,
  `id_usuario_creador` int(11) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_actividad`),
  KEY `id_beneficiario` (`id_beneficiario`),
  KEY `id_usuario_creador` (`id_usuario_creador`),
  CONSTRAINT `actividad_ibfk_1` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiario` (`id_beneficiario`),
  CONSTRAINT `actividad_ibfk_2` FOREIGN KEY (`id_usuario_creador`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'Nombre','Descripción','2024-11-20','Pendiente',NULL,1,NULL),(2,'Nombre','Descripción','2024-09-25','Pendiente',NULL,1,NULL),(3,'Limpieza de Playa','Recoger plásticos','2024-12-01','Pendiente',NULL,1,NULL),(4,'Limpieza de Parques','Cuidar el medio ambiente','2025-10-25','Pendiente',NULL,1,NULL);
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividad_lugar`
--

DROP TABLE IF EXISTS `actividad_lugar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad_lugar` (
  `id_actividad_lugar` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) DEFAULT NULL,
  `id_lugar` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_actividad_lugar`),
  KEY `id_actividad` (`id_actividad`),
  KEY `id_lugar` (`id_lugar`),
  CONSTRAINT `actividad_lugar_ibfk_1` FOREIGN KEY (`id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `actividad_lugar_ibfk_2` FOREIGN KEY (`id_lugar`) REFERENCES `lugar` (`id_lugar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad_lugar`
--

LOCK TABLES `actividad_lugar` WRITE;
/*!40000 ALTER TABLE `actividad_lugar` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad_lugar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividad_recurso`
--

DROP TABLE IF EXISTS `actividad_recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad_recurso` (
  `id_actividad_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) DEFAULT NULL,
  `id_recurso` int(11) DEFAULT NULL,
  `cantidad_requerida` decimal(10,2) DEFAULT NULL,
  `cantidad_conseguida` decimal(10,2) DEFAULT NULL,
  `prioridad` varchar(20) DEFAULT NULL,
  `observacion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_actividad_recurso`),
  KEY `id_actividad` (`id_actividad`),
  KEY `id_recurso` (`id_recurso`),
  CONSTRAINT `actividad_recurso_ibfk_1` FOREIGN KEY (`id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `actividad_recurso_ibfk_2` FOREIGN KEY (`id_recurso`) REFERENCES `recurso` (`id_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad_recurso`
--

LOCK TABLES `actividad_recurso` WRITE;
/*!40000 ALTER TABLE `actividad_recurso` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad_recurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiario`
--

DROP TABLE IF EXISTS `beneficiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiario` (
  `id_beneficiario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `id_tipo_beneficiario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_beneficiario`),
  KEY `id_tipo_beneficiario` (`id_tipo_beneficiario`),
  CONSTRAINT `beneficiario_ibfk_1` FOREIGN KEY (`id_tipo_beneficiario`) REFERENCES `tipo_beneficiario` (`id_tipo_beneficiario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiario`
--

LOCK TABLES `beneficiario` WRITE;
/*!40000 ALTER TABLE `beneficiario` DISABLE KEYS */;
/*!40000 ALTER TABLE `beneficiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donacion`
--

DROP TABLE IF EXISTS `donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donacion` (
  `id_donacion` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id_tipo_donacion` int(11) DEFAULT NULL,
  `id_actividad` int(11) DEFAULT NULL,
  `id_usuario_registro` int(11) DEFAULT NULL,
  `registrado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_donacion`),
  KEY `id_tipo_donacion` (`id_tipo_donacion`),
  KEY `id_actividad` (`id_actividad`),
  KEY `id_usuario_registro` (`id_usuario_registro`),
  CONSTRAINT `donacion_ibfk_1` FOREIGN KEY (`id_tipo_donacion`) REFERENCES `tipo_donacion` (`id_tipo_donacion`),
  CONSTRAINT `donacion_ibfk_2` FOREIGN KEY (`id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `donacion_ibfk_3` FOREIGN KEY (`id_usuario_registro`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donacion`
--

LOCK TABLES `donacion` WRITE;
/*!40000 ALTER TABLE `donacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donacion_donante`
--

DROP TABLE IF EXISTS `donacion_donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donacion_donante` (
  `id_donacion_donante` int(11) NOT NULL AUTO_INCREMENT,
  `id_donacion` int(11) DEFAULT NULL,
  `id_donante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_donacion_donante`),
  KEY `id_donacion` (`id_donacion`),
  KEY `id_donante` (`id_donante`),
  CONSTRAINT `donacion_donante_ibfk_1` FOREIGN KEY (`id_donacion`) REFERENCES `donacion` (`id_donacion`),
  CONSTRAINT `donacion_donante_ibfk_2` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donacion_donante`
--

LOCK TABLES `donacion_donante` WRITE;
/*!40000 ALTER TABLE `donacion_donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `donacion_donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donante`
--

DROP TABLE IF EXISTS `donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donante` (
  `id_donante` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` enum('Persona','Empresa','Grupo') DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donante`
--

LOCK TABLES `donante` WRITE;
/*!40000 ALTER TABLE `donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lugar`
--

DROP TABLE IF EXISTS `lugar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lugar` (
  `id_lugar` int(11) NOT NULL AUTO_INCREMENT,
  `departamento` varchar(100) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `distrito` varchar(100) DEFAULT NULL,
  `direccion_referencia` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_lugar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lugar`
--

LOCK TABLES `lugar` WRITE;
/*!40000 ALTER TABLE `lugar` DISABLE KEYS */;
/*!40000 ALTER TABLE `lugar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participacion`
--

DROP TABLE IF EXISTS `participacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participacion` (
  `id_participacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_voluntario` int(11) DEFAULT NULL,
  `id_actividad` int(11) DEFAULT NULL,
  `id_rol_actividad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_participacion`),
  KEY `id_voluntario` (`id_voluntario`),
  KEY `id_actividad` (`id_actividad`),
  KEY `id_rol_actividad` (`id_rol_actividad`),
  CONSTRAINT `participacion_ibfk_1` FOREIGN KEY (`id_voluntario`) REFERENCES `voluntario` (`id_voluntario`),
  CONSTRAINT `participacion_ibfk_2` FOREIGN KEY (`id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `participacion_ibfk_3` FOREIGN KEY (`id_rol_actividad`) REFERENCES `rol_actividad` (`id_rol_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participacion`
--

LOCK TABLES `participacion` WRITE;
/*!40000 ALTER TABLE `participacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `participacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_permiso` varchar(80) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programacion_donacion`
--

DROP TABLE IF EXISTS `programacion_donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programacion_donacion` (
  `id_programacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_programada` date DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `id_donacion` int(11) DEFAULT NULL,
  `id_voluntario` int(11) DEFAULT NULL,
  `id_usuario_registro` int(11) DEFAULT NULL,
  `id_beneficiario` int(11) DEFAULT NULL,
  `id_lugar` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_programacion`),
  KEY `id_donacion` (`id_donacion`),
  KEY `id_voluntario` (`id_voluntario`),
  KEY `id_usuario_registro` (`id_usuario_registro`),
  KEY `id_beneficiario` (`id_beneficiario`),
  KEY `id_lugar` (`id_lugar`),
  CONSTRAINT `programacion_donacion_ibfk_1` FOREIGN KEY (`id_donacion`) REFERENCES `donacion` (`id_donacion`),
  CONSTRAINT `programacion_donacion_ibfk_2` FOREIGN KEY (`id_voluntario`) REFERENCES `voluntario` (`id_voluntario`),
  CONSTRAINT `programacion_donacion_ibfk_3` FOREIGN KEY (`id_usuario_registro`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `programacion_donacion_ibfk_4` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiario` (`id_beneficiario`),
  CONSTRAINT `programacion_donacion_ibfk_5` FOREIGN KEY (`id_lugar`) REFERENCES `lugar` (`id_lugar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programacion_donacion`
--

LOCK TABLES `programacion_donacion` WRITE;
/*!40000 ALTER TABLE `programacion_donacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `programacion_donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso`
--

DROP TABLE IF EXISTS `recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) DEFAULT NULL,
  `unidad_medida` varchar(30) DEFAULT NULL,
  `tipo_recurso` varchar(30) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso`
--

LOCK TABLES `recurso` WRITE;
/*!40000 ALTER TABLE `recurso` DISABLE KEYS */;
/*!40000 ALTER TABLE `recurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsable_beneficiario`
--

DROP TABLE IF EXISTS `responsable_beneficiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsable_beneficiario` (
  `id_responsable` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_beneficiario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_responsable`),
  KEY `id_beneficiario` (`id_beneficiario`),
  CONSTRAINT `responsable_beneficiario_ibfk_1` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiario` (`id_beneficiario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable_beneficiario`
--

LOCK TABLES `responsable_beneficiario` WRITE;
/*!40000 ALTER TABLE `responsable_beneficiario` DISABLE KEYS */;
/*!40000 ALTER TABLE `responsable_beneficiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_actividad`
--

DROP TABLE IF EXISTS `rol_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_actividad` (
  `id_rol_actividad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_rol_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_actividad`
--

LOCK TABLES `rol_actividad` WRITE;
/*!40000 ALTER TABLE `rol_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_permiso` (
  `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol_sistema` int(11) DEFAULT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_rol_permiso`),
  KEY `id_rol_sistema` (`id_rol_sistema`),
  KEY `id_permiso` (`id_permiso`),
  CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_rol_sistema`) REFERENCES `rol_sistema` (`id_rol_sistema`),
  CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_permiso`
--

LOCK TABLES `rol_permiso` WRITE;
/*!40000 ALTER TABLE `rol_permiso` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_sistema`
--

DROP TABLE IF EXISTS `rol_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_sistema` (
  `id_rol_sistema` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_rol_sistema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_sistema`
--

LOCK TABLES `rol_sistema` WRITE;
/*!40000 ALTER TABLE `rol_sistema` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_beneficiario`
--

DROP TABLE IF EXISTS `tipo_beneficiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_beneficiario` (
  `id_tipo_beneficiario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_beneficiario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_beneficiario`
--

LOCK TABLES `tipo_beneficiario` WRITE;
/*!40000 ALTER TABLE `tipo_beneficiario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_beneficiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_donacion`
--

DROP TABLE IF EXISTS `tipo_donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_donacion` (
  `id_tipo_donacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_donacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_donacion`
--

LOCK TABLES `tipo_donacion` WRITE;
/*!40000 ALTER TABLE `tipo_donacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `username` varchar(60) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `actualizado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Administrador','Principal','admin@prueba.com','admin','1234','Activo','2026-01-27 11:19:00',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_rol`
--

DROP TABLE IF EXISTS `usuario_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_rol` (
  `id_usuario_rol` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_rol_sistema` int(11) DEFAULT NULL,
  `asignado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario_rol`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_rol_sistema` (`id_rol_sistema`),
  CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`id_rol_sistema`) REFERENCES `rol_sistema` (`id_rol_sistema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_rol`
--

LOCK TABLES `usuario_rol` WRITE;
/*!40000 ALTER TABLE `usuario_rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voluntario`
--

DROP TABLE IF EXISTS `voluntario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voluntario` (
  `id_voluntario` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `carrera` varchar(100) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_voluntario`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `voluntario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voluntario`
--

LOCK TABLES `voluntario` WRITE;
/*!40000 ALTER TABLE `voluntario` DISABLE KEYS */;
INSERT INTO `voluntario` VALUES (1,'Josue Sebastian','Niño Silva','nsilvajosueseba@uss.edu.pe','948745909','Ingeniero de Sistemas','Activo',NULL),(2,'gerson','regalado','gerson123@gmail.com','959418014','Mecanico','Activo',NULL);
/*!40000 ALTER TABLE `voluntario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-01 19:45:06
