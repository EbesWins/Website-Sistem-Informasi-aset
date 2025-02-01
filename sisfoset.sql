-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2025 at 02:41 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sisfoset`
--

-- --------------------------------------------------------

--
-- Table structure for table `akses`
--

CREATE TABLE `akses` (
  `idAkses` char(25) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` enum('yes','no') NOT NULL,
  `idLevel` char(5) DEFAULT NULL,
  `tglBuat` datetime DEFAULT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) DEFAULT NULL,
  `idUpdate` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `akses`
--

INSERT INTO `akses` (`idAkses`, `nama`, `username`, `password`, `status`, `idLevel`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('G9xgXPu-r', 'Mamad', 'petugas', '$2b$10$2ZPoLJmyuvrM4Zue48cNp.OXVadRprnBFzItv2jnFZT0qOjq6AtaO', 'yes', 'LyPiw', '2024-11-26 18:12:28', '2024-11-26 18:12:28', 'Vlqddk_sk', 'Vlqddk_sk'),
('Vlqddk_sk', 'Dev', 'Zidan', '$2b$10$TriaKOd5opf5xmiz2Btcw.Ui4J5TsV3xA2Dje.De6HPtPThI2TRwa', 'yes', 'q92R8', '2024-11-26 13:45:22', '2024-11-26 13:45:22', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `idKategori` char(5) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) DEFAULT NULL,
  `idUpdate` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`idKategori`, `nama`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('KATe7', 'Handpone', '2024-12-21 14:41:27', '2024-12-21 14:41:27', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `idLevel` char(5) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tanggalBuat` datetime NOT NULL,
  `tanggalUpdate` datetime NOT NULL,
  `idBuat` varchar(25) DEFAULT NULL,
  `idUpdate` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`idLevel`, `nama`, `tanggalBuat`, `tanggalUpdate`, `idBuat`, `idUpdate`) VALUES
('LyPiw', 'Admin', '2024-11-26 14:23:39', '2024-11-26 14:40:25', 'Vlqddk_sk', 'Vlqddk_sk'),
('q92R8', 'Petugas', '2024-11-26 13:25:49', '2024-11-26 13:25:49', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `masteraset`
--

CREATE TABLE `masteraset` (
  `idMasteraset` char(25) NOT NULL,
  `tipe` varchar(50) NOT NULL,
  `spesifikasi` text NOT NULL,
  `deskripsi` text NOT NULL,
  `idKategori` char(5) DEFAULT NULL,
  `idMerk` char(5) DEFAULT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `masteraset`
--

INSERT INTO `masteraset` (`idMasteraset`, `tipe`, `spesifikasi`, `deskripsi`, `idKategori`, `idMerk`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('AST1d216d', 'E-998', 'Ram 6GB', 'Xiamoni', 'KATe7', 'MRK95', '2024-12-16 23:14:44', '2024-12-21 14:42:04', 'Vlqddk_sk', 'Vlqddk_sk'),
('AST5763ca', 'E-888', 'Ram 4GB EDIT', 'Punya zidan', 'KATe7', 'MRK95', '2024-12-16 20:22:47', '2024-12-21 14:42:14', 'Vlqddk_sk', 'Vlqddk_sk'),
('ASTa7c1e7', 'Ram 4GB', 'RM-988', 'Tidak ada', 'KATe7', 'MRK95', '2024-12-16 19:33:03', '2024-12-21 14:42:22', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `merk`
--

CREATE TABLE `merk` (
  `idMerk` char(5) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `merk`
--

INSERT INTO `merk` (`idMerk`, `nama`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('MRK17', 'XIAOMII', '2024-12-16 23:46:27', '2024-12-16 23:46:38', 'Vlqddk_sk', 'Vlqddk_sk'),
('MRK95', 'SAMSUNG', '2024-12-15 00:39:09', '2024-12-15 00:39:09', 'Vlqddk_sk', 'Vlqddk_sk'),
('MRKdc', 'PANASONIC', '2024-12-15 00:42:16', '2024-12-15 00:42:16', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `pencatatan`
--

CREATE TABLE `pencatatan` (
  `idPencatatan` char(25) NOT NULL,
  `idMasteraset` char(25) NOT NULL,
  `idPerolehan` char(25) NOT NULL,
  `harga` double NOT NULL,
  `tglPerolehan` date NOT NULL,
  `keterangan` text NOT NULL,
  `status` enum('yes','no') NOT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pencatatan`
--

INSERT INTO `pencatatan` (`idPencatatan`, `idMasteraset`, `idPerolehan`, `harga`, `tglPerolehan`, `keterangan`, `status`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('PCT173e14255c', 'ASTa7c1e7', 'PRLbf47c6d0e5', 7000000, '2024-12-17', 'Aset Pertama', 'yes', '2024-12-17 11:03:02', '2024-12-17 11:03:02', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `perolehan`
--

CREATE TABLE `perolehan` (
  `idPerolehan` char(25) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `keterangan` text NOT NULL,
  `tanggalBuat` datetime NOT NULL,
  `tanggalUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `perolehan`
--

INSERT INTO `perolehan` (`idPerolehan`, `nama`, `keterangan`, `tanggalBuat`, `tanggalUpdate`, `idBuat`, `idUpdate`) VALUES
('PRLbf47c6d0e5', 'Milik Warga', 'Asset milik warga', '2024-12-17 04:49:52', '2024-12-17 04:49:52', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat`
--

CREATE TABLE `riwayat` (
  `idRiwayat` char(25) NOT NULL,
  `idPencatatan` char(25) NOT NULL,
  `kondisi` enum('baik','rusak ringan','rusak berat','hilang') NOT NULL,
  `idRuang` char(25) NOT NULL,
  `tglAudit` datetime NOT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ruang`
--

CREATE TABLE `ruang` (
  `idRuang` char(25) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `idUnit` char(25) NOT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ruang`
--

INSERT INTO `ruang` (`idRuang`, `nama`, `idUnit`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('RNG154b20', 'Ruangan Bendaharaa', 'UNT539bbd', '2024-12-17 00:25:12', '2024-12-17 00:36:52', 'Vlqddk_sk', 'Vlqddk_sk');

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `idUnit` char(25) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tglBuat` datetime NOT NULL,
  `tglUpdate` datetime NOT NULL,
  `idBuat` varchar(25) NOT NULL,
  `idUpdate` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`idUnit`, `nama`, `tglBuat`, `tglUpdate`, `idBuat`, `idUpdate`) VALUES
('UNT27a1bf', 'Pengeloaan', '2024-12-17 02:02:00', '2024-12-17 02:02:00', 'Vlqddk_sk', 'Vlqddk_sk'),
('UNT539bbd', 'Keuangan', '2024-12-16 23:56:31', '2024-12-17 00:01:32', 'Vlqddk_sk', 'Vlqddk_sk');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akses`
--
ALTER TABLE `akses`
  ADD PRIMARY KEY (`idAkses`),
  ADD KEY `idLevel` (`idLevel`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`idKategori`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`idLevel`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `masteraset`
--
ALTER TABLE `masteraset`
  ADD PRIMARY KEY (`idMasteraset`),
  ADD KEY `idKategori` (`idKategori`),
  ADD KEY `idMerk` (`idMerk`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `merk`
--
ALTER TABLE `merk`
  ADD PRIMARY KEY (`idMerk`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `pencatatan`
--
ALTER TABLE `pencatatan`
  ADD PRIMARY KEY (`idPencatatan`),
  ADD KEY `idmAset` (`idMasteraset`),
  ADD KEY `idPerolehan` (`idPerolehan`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `perolehan`
--
ALTER TABLE `perolehan`
  ADD PRIMARY KEY (`idPerolehan`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `riwayat`
--
ALTER TABLE `riwayat`
  ADD PRIMARY KEY (`idRiwayat`),
  ADD KEY `idPencatatan` (`idPencatatan`),
  ADD KEY `idRuang` (`idRuang`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `ruang`
--
ALTER TABLE `ruang`
  ADD PRIMARY KEY (`idRuang`),
  ADD KEY `idUnit` (`idUnit`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`idUnit`),
  ADD KEY `idBuat` (`idBuat`),
  ADD KEY `idUpdate` (`idUpdate`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `akses`
--
ALTER TABLE `akses`
  ADD CONSTRAINT `akses_ibfk_1` FOREIGN KEY (`idLevel`) REFERENCES `level` (`idLevel`),
  ADD CONSTRAINT `akses_ibfk_2` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `akses_ibfk_3` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `kategori`
--
ALTER TABLE `kategori`
  ADD CONSTRAINT `kategori_ibfk_1` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `kategori_ibfk_2` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `level`
--
ALTER TABLE `level`
  ADD CONSTRAINT `level_ibfk_1` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `level_ibfk_2` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `masteraset`
--
ALTER TABLE `masteraset`
  ADD CONSTRAINT `masteraset_ibfk_1` FOREIGN KEY (`idKategori`) REFERENCES `kategori` (`idKategori`),
  ADD CONSTRAINT `masteraset_ibfk_2` FOREIGN KEY (`idMerk`) REFERENCES `merk` (`idMerk`),
  ADD CONSTRAINT `masteraset_ibfk_3` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `masteraset_ibfk_4` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `merk`
--
ALTER TABLE `merk`
  ADD CONSTRAINT `merk_ibfk_1` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `merk_ibfk_2` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `pencatatan`
--
ALTER TABLE `pencatatan`
  ADD CONSTRAINT `pencatatan_ibfk_1` FOREIGN KEY (`idMasteraset`) REFERENCES `masteraset` (`idMasteraset`),
  ADD CONSTRAINT `pencatatan_ibfk_2` FOREIGN KEY (`idPerolehan`) REFERENCES `perolehan` (`idPerolehan`),
  ADD CONSTRAINT `pencatatan_ibfk_3` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `pencatatan_ibfk_4` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `perolehan`
--
ALTER TABLE `perolehan`
  ADD CONSTRAINT `perolehan_ibfk_1` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `perolehan_ibfk_2` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `riwayat`
--
ALTER TABLE `riwayat`
  ADD CONSTRAINT `riwayat_ibfk_1` FOREIGN KEY (`idPencatatan`) REFERENCES `pencatatan` (`idPencatatan`),
  ADD CONSTRAINT `riwayat_ibfk_2` FOREIGN KEY (`idRuang`) REFERENCES `ruang` (`idRuang`),
  ADD CONSTRAINT `riwayat_ibfk_3` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `riwayat_ibfk_4` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `ruang`
--
ALTER TABLE `ruang`
  ADD CONSTRAINT `ruang_ibfk_1` FOREIGN KEY (`idUnit`) REFERENCES `unit` (`idUnit`),
  ADD CONSTRAINT `ruang_ibfk_2` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `ruang_ibfk_3` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);

--
-- Constraints for table `unit`
--
ALTER TABLE `unit`
  ADD CONSTRAINT `unit_ibfk_1` FOREIGN KEY (`idBuat`) REFERENCES `akses` (`idAkses`),
  ADD CONSTRAINT `unit_ibfk_2` FOREIGN KEY (`idUpdate`) REFERENCES `akses` (`idAkses`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
