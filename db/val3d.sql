-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 27 août 2021 à 14:52
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `val3d`
--

-- --------------------------------------------------------

--
-- Structure de la table `bim`
--

DROP TABLE IF EXISTS `bim`;
CREATE TABLE IF NOT EXISTS `bim` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(512) NOT NULL,
  `Description` varchar(4096) NOT NULL,
  `Path` varchar(512) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `bim`
--

INSERT INTO `bim` (`Id`, `Name`, `Description`, `Path`) VALUES
(1, 'Gymnase Marc Valentin', 'Adresse: X rue Xxxxxxx\r\n94000\r\nCreteil\r\nArchitecte: ------', 'data\\Projet_BIM\\test'),
(2, 'La Tour Eiffel', 'Hauteur: 300m\r\nAdresse: Champs de Mars, PARIS\r\nAchivement: 31 mars 1889', 'data\\Projet_BIM\\eiffel-tower');

-- --------------------------------------------------------

--
-- Structure de la table `layer`
--

DROP TABLE IF EXISTS `layer`;
CREATE TABLE IF NOT EXISTS `layer` (
  `ID` int(8) NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Path` varchar(256) NOT NULL,
  `Type` varchar(32) NOT NULL,
  `Display` varchar(8) NOT NULL,
  `Groupe` varchar(32) NOT NULL,
  `Meta` varchar(1024) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `layer`
--

INSERT INTO `layer` (`ID`, `Name`, `Path`, `Type`, `Display`, `Groupe`, `Meta`) VALUES
(1, 'Creteil', 'data\\Photomaillage\\Creteil\\tileset.json', '3dtiles', 'false', 'Photomaillage', ''),
(2, 'Espaces verts 94', 'data\\Parc et Jardin\\Espaces_Verts_2154.json', 'vectS', 'false', 'Parcs et Jardins', '{\"style\":{\"type\":\"uniq\",\"fill_color\":{\"red\":0,\"green\":150,\"blue\":0,\"alpha\":0.8}}}'),
(3, 'Limites de communes', 'data\\Administratif\\COMMUNES_3264_2D.geojson', 'vectL', 'false', 'Administratif', '{\"style\":{\"type\":\"uniq\",\"stroke_color\":{\"red\":255,\"green\":0,\"blue\":0},\"stroke_width\":2,\"fill_color\":{\"red\":0,\"green\":0,\"blue\":0,\"alpha\":0}}}'),
(4, 'Colleges du 94', 'data\\Administratif\\Eq_Adm_Coll_2154.json', 'vectS', 'false', 'Education', '{\"style\":{\"type\":\"uniq\",\"fill_color\":{\"red\":0,\"green\":150,\"blue\":150,\"alpha\":0.8}}}'),
(5, 'MNT', '483604', 'imageryIon', 'false', 'Orthophotographies', ''),
(6, 'OpenStreetMap', 'https://a.tile.openstreetmap.org/', 'imageryOsm', 'false', 'Plan', ''),
(7, 'Val-de-Marne', 'data\\Photomaillage\\Val-de-Marne\\tileset.json', '3dtiles', 'true', 'Photomaillage', ''),
(8, 'Beau jour', 'data\\Skybox\\sunny_day\\Sky.jpg', 'skybox', 'true', 'SkyBox', ''),
(9, 'Orthophotographie IGN', 'http://wxs.ign.fr/mzlfqya412sbel1kzydo7ze2/geoportail/wmts', 'imageryGeoP', 'false', 'Orthophotographies', '{\"WMTS\":{}}'),
(11, 'Cassini', 'https://geo.valdemarne.fr/mapcache/', 'imageryVdm', 'false', 'Plan', '{\"WMTS\":{\"layer\":\"CASSINI3\",\"format\":\"image/png\"}}'),
(12, 'OSM Buildings', '', 'buildingOSM', 'false', 'Batiments', ''),
(13, 'Elevations IGN', 'http://wxs.ign.fr/mzlfqya412sbel1kzydo7ze2/geoportail/wmts', 'imageryGeoP', 'false', 'Orthophotographies', '{\"WMTS\":{\"layer\":\"ELEVATION.SLOPES\"}}'),
(14, 'Parcellaire', 'http://wxs.ign.fr/mzlfqya412sbel1kzydo7ze2/geoportail/wmts', 'imageryGeoP', 'false', 'Plan', '{\"WMTS\":{\"layer\":\"CADASTRALPARCELS.PARCELLAIRE_EXPRESS\", \"format\":\"image/png\", \"legend\":\"https://wxs.ign.fr/static/legends/CADASTRALPARCELS.PARCELLAIRE_EXPRESS.png\"}}'),
(15, 'Plan IGN', 'http://wxs.ign.fr/mzlfqya412sbel1kzydo7ze2/geoportail/wmts', 'imageryGeoP', 'false', 'Plan', '{\"WMTS\":{\"layer\":\"GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2\",\"format\":\"image/png\",\"legend\":\"https://wxs.ign.fr/static/legends/LEGEND.jpg\"}}');

-- --------------------------------------------------------

--
-- Structure de la table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
CREATE TABLE IF NOT EXISTS `plugin` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Access` varchar(32) NOT NULL,
  `Path` varchar(1024) NOT NULL,
  `Code` varchar(512) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plugin`
--

INSERT INTO `plugin` (`Id`, `Name`, `Access`, `Path`, `Code`) VALUES
(1, 'Couches', 'ADMIN;ADVANCED;BASIC;', './scripts/layers.js', 'layers'),
(2, 'Style', 'ADMIN;ADVANCED;BASIC;', './scripts/style.js', 'styles'),
(3, 'Rechercher', 'ADMIN;ADVANCED;', './scripts/geocoder.js', 'geocoder'),
(5, 'Mesurer', 'ADMIN;ADVANCED;', './scripts/mesure.js', 'mesure'),
(6, 'BIM', 'ADMIN;', './scripts/bim.js', 'bim'),
(4, 'POI', 'ADMIN;ADVANCED;', './scripts/poi.js', 'poi');

-- --------------------------------------------------------

--
-- Structure de la table `poi`
--

DROP TABLE IF EXISTS `poi`;
CREATE TABLE IF NOT EXISTS `poi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Path` varchar(256) NOT NULL,
  `Nom` varchar(256) NOT NULL,
  `Meta` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `poi`
--

INSERT INTO `poi` (`id`, `Path`, `Nom`, `Meta`) VALUES
(1, 'data\\POI\\College du 94', 'Colleges du Val-de-Marne', '{\r\n    \"style\": {\r\n        \"image\":\"https://img.icons8.com/officel/2x/school.png\",\r\n        \"image_scale\":0.15\r\n    },\r\n    \"height\":150\r\n}');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `class` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`ID`, `email`, `password`, `class`) VALUES
(1, 'admin@valdemarne.fr', 'Azerty123', 'ADMIN'),
(2, 'advance@valdemarne.fr', 'Azerty123', 'ADVANCED');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
