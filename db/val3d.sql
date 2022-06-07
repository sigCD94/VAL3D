-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 07 juin 2022 à 07:16
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
  `Access` varchar(2048) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `bim`
--

INSERT INTO `bim` (`Id`, `Name`, `Description`, `Path`, `Access`) VALUES
(1, 'Gymnase Marc Valentin', 'Adresse: X rue Xxxxxxx\r\n94000\r\nCreteil\r\nArchitecte: ------', 'data\\Projet_BIM\\test', 'ADMIN;'),
(2, 'La Tour Eiffel', 'Hauteur: 300m\r\nAdresse: Champs de Mars, PARIS\r\nAchivement: 31 mars 1889', 'data\\Projet_BIM\\eiffel-tower', 'BASIC;ADMIN;'),
(3, 'Projet Eiffel', 'Adresse: X rue Xxxxxxx\r\n94000\r\nCreteil\r\nArchitecte: ------', 'data\\Projet_BIM\\eiffel', 'ADMIN;');

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
  `Access` varchar(2048) NOT NULL,
  `Meta` varchar(1024) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `layer`
--

INSERT INTO `layer` (`ID`, `Name`, `Path`, `Type`, `Display`, `Groupe`, `Access`, `Meta`) VALUES
(24, 'Parcellaire', 'https://wxs.ign.fr/parcellaire/geoportail/wmts', 'imageryGeoP', 'false', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"CADASTRALPARCELS.PARCELLAIRE_EXPRESS\",\"format\":\"image/png\"}}'),
(6, 'Departementales', 'data\\Road\\v3d_departementale.geojson', 'vectL', 'false', 'Voies', 'BASIC;ADVANCED;ADMIN;', '{\"style\":{\"type\":\"uniq\",\"stroke_color\":{\"red\":55,\"green\":210,\"blue\":240},\"stroke_width\":4,\"fill_color\":{\"red\":0,\"green\":0,\"blue\":0,\"alpha\":0.5}}}\r\n'),
(5, 'Nationales', 'data\\Road\\v3d_nationale.geojson', 'vectL', 'false', 'Voies', 'BASIC;ADVANCED;ADMIN;', '{\"style\":{\"type\":\"uniq\",\"stroke_color\":{\"red\":55,\"green\":210,\"blue\":240},\"stroke_width\":4,\"fill_color\":{\"red\":0,\"green\":0,\"blue\":0,\"alpha\":0.5}}}\r\n'),
(4, 'Autoroutes', 'data\\Road\\v3d_autoroute.geojson', 'vectL', 'false', 'Voies', 'NONE;', '{\"style\":{\"type\":\"uniq\",\"stroke_color\":{\"red\":239,\"green\":31,\"blue\":31},\"stroke_width\":8,\"fill_color\":{\"red\":0,\"green\":0,\"blue\":0,\"alpha\":0.5}}}\r\n'),
(2, 'Limites des communes', 'data\\Administratif\\v3d_communes_vdm.geojson', 'vectC', 'false', 'Administratif', 'BASIC;ADVANCED;ADMIN;', '{\"style\":{\"type\":\"uniq\",\"stroke_color\":{\"red\":255,\"green\":255,\"blue\":0},\"stroke_width\":6,\"fill_color\":{\"red\":38,\"green\":236,\"blue\":245,\"alpha\":0.5}}}'),
(1, 'Val-de-Marne', 'data\\Photomaillage\\Val-de-Marne\\tileset.json', '3dtiles', 'true', 'Photomaillage', 'NONE;', ''),
(10, 'Test', 'data\\Administratif\\test.geojson', 'vectV', 'false', 'Statistiques', 'ADMIN;BASIC;', '{ \"style\": { \"height_field\": \"POPULATION_BDTOPO2017\", \"type\": \"uniq\", \"stroke_color\": { \"red\": 255, \"green\": 255, \"blue\":0, \"alpha\": 1 }, \"stroke_width\": 3, \"fill_color\": { \"red\": 255, \"green\": 0, \"blue\": 255, \"alpha\": 1 } } }'),
(21, 'Plan', 'https://wxs.ign.fr/decouverte/geoportail/wmts', 'imageryGeoP', 'false', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2\"}}'),
(22, 'Ortho', 'https://wxs.ign.fr/decouverte/geoportail/wmts', 'imageryGeoP', 'true', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"ORTHOIMAGERY.ORTHOPHOTOS\",\"format\":\"image/jpeg\"}}'),
(25, 'Route', 'https://wxs.ign.fr/topographie/geoportail/wmts', 'imageryGeoP', 'false', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"TRANSPORTNETWORKS.ROADS\",\"format\":\"image/png\"}}'),
(26, 'Batiments', 'https://wxs.ign.fr/topographie/geoportail/wmts', 'imageryGeoP', 'false', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"BUILDINGS.BUILDINGS\",\"format\":\"image/png\"}}'),
(27, 'Hydrographie', 'https://wxs.ign.fr/topographie/geoportail/wmts', 'imageryGeoP', 'false', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"HYDROGRAPHY.HYDROGRAPHY\",\"format\":\"image/png\"}}'),
(28, 'Administratif', 'https://wxs.ign.fr/administratif/geoportail/wmts', 'imageryGeoP', 'false', 'IGN', 'BASIC;ADVANCED;ADMIN;', '{\"WMTS\":{\"layer\":\"LIMITES_ADMINISTRATIVES_EXPRESS.LATEST\",\"format\":\"image/png\"}}'),
(29, 'Plan', '', 'imageryOSM', 'false', 'OSM', 'BASIC;ADVANCED;ADMIN;', ''),
(32, 'Espace vert', 'data/Parc et Jardin/Espaces_Verts_2154.json', 'vectS', 'false', 'Espaces Verts', 'BASIC;ADMIN;ADVANCED;', '{\r\n    \"style\": {\r\n        \"type\": \"uniq\",\r\n        \"fill_color\": {\r\n            \"red\": 0,\r\n            \"green\": 255,\r\n            \"blue\": 0,\r\n            \"alpha\": 0.5\r\n        }\r\n    }\r\n}'),
(34, 'OSM Buildings', '', 'buildingOSM', 'false', 'Batiments', 'BASIC;ADMIN;ADVANCED;', ''),
(33, 'Communes', 'data\\Administratif\\v3d_communes_vdm.geojson', 'vectV', 'false', 'Statistiques', 'BASIC;ADVANCED;ADMIN;', '{\"style\":{\"height_field\": \"POPULATION_BDTOPO2017\"}}');

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
  `Access` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `poi`
--

INSERT INTO `poi` (`id`, `Path`, `Nom`, `Meta`, `Access`) VALUES
(1, 'data\\POI\\College du 94', 'Colleges du Val-de-Marne', '{\r\n    \"style\": {\r\n        \"image\":\"https://img.icons8.com/officel/2x/school.png\",\r\n        \"image_scale\":0.15\r\n    },\r\n    \"height_relativ\":15\r\n}', 'ADMIN;');

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
(1, 'admin@valdemarne.fr', 'a6ab311c073831733669d24615ce8df987e2bdb24dc154881c70298f5a3b7c66', 'ADMIN'),
(2, 'advance@valdemarne.fr', 'a6ab311c073831733669d24615ce8df987e2bdb24dc154881c70298f5a3b7c66', 'ADVANCED');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
