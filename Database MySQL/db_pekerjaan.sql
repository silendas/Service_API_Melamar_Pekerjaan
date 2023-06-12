-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2023 at 06:17 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pekerjaan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `c_melamar` (IN `p_id` VARCHAR(30), IN `p_loker` INT)  SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi, a.tgl_melamar from melamar a, pelamar b, loker c 
WHERE a.id_pelamar = p_id and a.id_loker = p_loker AND a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_admin` (IN `sp_id` INT(11))  BEGIN
DELETE FROM admin WHERE id_admin=sp_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_hrd` (IN `sp_id` INT(11))  BEGIN
DELETE FROM hrd WHERE id_hrd=sp_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_loker` (IN `sp_id` INT(11), IN `p_status` VARCHAR(20))  BEGIN
    UPDATE loker
    SET
        `status`= p_status
    WHERE id_loker = sp_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_pnddkn` (IN `p_id` INT(11))  BEGIN	
DELETE from p_pnddkn WHERE id_pendidikan=p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_pnglmn` (IN `p_id` INT(11))  BEGIN	
DELETE from p_pnglmn WHERE id_pengalaman=p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_test` (IN `p_id` INT(11))  delete from test where test.id_test = p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_admin` (IN `p_nama` VARCHAR(100), IN `p_username` VARCHAR(20), IN `p_password` VARCHAR(20))  BEGIN
insert into admin VALUES (null,p_nama,p_username,p_password);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_hrd` (IN `p_nama` VARCHAR(100), IN `p_cabang` VARCHAR(20), IN `p_nohp` VARCHAR(25), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(20))  BEGIN
INSERT INTO hrd VALUES (null,p_nama,p_cabang,p_nohp,p_email,p_password);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_loker` (IN `p_posisi` VARCHAR(50), IN `p_cabang` VARCHAR(20), IN `p_deskripsi` TEXT, IN `p_gaji` VARCHAR(22))  BEGIN
INSERT INTO loker VALUES (NULL,p_posisi,p_cabang,p_deskripsi,p_gaji,'Aktif',CURRENT_DATE);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_melamar` (IN `p_id_pelamar` INT(11), IN `p_id_loker` INT(11))  BEGIN
INSERT INTO melamar VALUES (NULL,p_id_loker,p_id_pelamar,"Administrasi", 0,CURRENT_DATE);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_pelamar` (IN `p_nik` VARCHAR(25), IN `p_nama` VARCHAR(50), IN `p_jk` VARCHAR(2), IN `p_tgl_lahir` DATE, IN `p_nohp` VARCHAR(25), IN `p_alamat` TEXT, IN `p_email` VARCHAR(50), IN `p_password` VARCHAR(20))  BEGIN
 INSERT INTO pelamar VALUES (null, p_nik, p_nama, p_jk, p_tgl_lahir, p_nohp, p_alamat, p_email, p_password, CURRENT_DATE);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_pnddkn` (IN `p_id` INT(11), IN `p_sklh` VARCHAR(50), IN `p_jurusan` VARCHAR(30), IN `p_nlai` VARCHAR(11), IN `p_tgl_lulus` DATE)  BEGIN
INSERT into p_pnddkn VALUES (null, p_id, p_sklh, p_jurusan, p_nlai, p_tgl_lulus);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_pnglmn` (IN `p_id` INT(11), IN `p_prshan` VARCHAR(50), IN `p_posisi` VARCHAR(30), IN `p_f` DATE, IN `p_l` DATE, IN `p_des` TEXT)  BEGIN
INSERT into p_pnglmn VALUES (null, p_id, p_prshan, p_posisi, p_f, p_l, p_des);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `i_test` (IN `p_prtnyn` TEXT, IN `p_a` VARCHAR(100), IN `p_b` VARCHAR(100), IN `p_c` VARCHAR(100), IN `p_jwbn` VARCHAR(5), IN `p_pss` VARCHAR(20))  INSERT INTO test VALUES (null,p_prtnyn,p_a,p_b,p_c,p_jwbn,p_pss)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `k_melamar` (IN `p_kualifikasi` VARCHAR(20))  begin 
SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi,a.nilai_tst, a.tgl_melamar from melamar a, pelamar b, loker c 
WHERE a.kualifikasi = p_kualifikasi AND a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `l_melamar` (IN `p_k` VARCHAR(20), IN `p_c` VARCHAR(20))  begin 
SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi,a.nilai_tst, a.tgl_melamar from melamar a, pelamar b, loker c 
WHERE a.kualifikasi = p_k and c.cabang = p_c AND a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `saa_loker` ()  begin 
SELECT * from loker ORDER BY id_loker ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sal_loker` ()  BEGIN
SELECT * FROM `loker` WHERE loker.status="Aktif" ORDER BY rand() LIMIT 4;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_admin` ()  BEGIN
SELECT * from admin  ORDER BY id_admin ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_cabang` ()  begin
SELECT DISTINCT cabang as l_cabang from loker ORDER by loker.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_hmlmr` ()  BEGIN
SELECT a.id_histori, d.nik, d.nama, c.posisi, c.cabang, a.kualifikasi, a.nilai_tst, a.aksi, a.tgl_histori from h_mlmr a, melamar b, loker c, pelamar d WHERE
a.id_melamar = b.id_melamar and
b.id_loker = c.id_loker and b.id_pelamar = d.id_pelamar
ORDER BY a.id_histori ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_hrd` ()  BEGIN
    SELECT * FROM hrd  ORDER BY id_hrd ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_loker` ()  begin 
SELECT * from loker WHERE loker.status="Aktif" ORDER BY id_loker ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_melamar` ()  begin 
SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi, a.nilai_tst, a.tgl_melamar from melamar a, pelamar b, loker c WHERE a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker  ORDER BY id_melamar ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_pelamar` ()  BEGIN
    SELECT * FROM pelamar ORDER BY id_pelamar ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_posisi` ()  begin
SELECT DISTINCT posisi as l_posisi from loker ORDER by loker.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sa_test` ()  SELECT * from test order by id_test$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spi_melamar` (IN `sp_id` INT)  begin 
SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi,a.nilai_tst, a.tgl_melamar from melamar a, pelamar b, loker c 
WHERE a.id_melamar = sp_id AND a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spi_pelamar` (IN `p_id` INT(11))  BEGIN
SELECT * FROM pelamar where pelamar.id_pelamar = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spl_admin` (IN `p_username` VARCHAR(20), IN `p_pass` VARCHAR(20))  begin 
SELECT * from admin a where a.username = p_username and  a.password = p_pass;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spl_hrd` (IN `p_email` VARCHAR(100), IN `p_pass` VARCHAR(20))  begin 
SELECT * from hrd where hrd.email = p_email AND hrd.password = p_pass;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spl_loker` (IN `p_cabang` VARCHAR(30))  BEGIN
SELECT * from loker a where a.cabang=p_cabang and a.status="Aktif"; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spl_melamar` (IN `sp_nik` VARCHAR(25))  begin 
SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi,a.nilai_tst, a.tgl_melamar from melamar a, pelamar b, loker c 
WHERE b.nik = sp_nik AND a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spl_pelamar` (IN `p_email` VARCHAR(100), IN `p_pass` VARCHAR(20))  begin 
SELECT * from pelamar where pelamar.email = p_email AND pelamar.password = p_pass;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spl_test` (IN `sp_id` INT(11))  begin
SELECT * from test where test.id_test = sp_id order by id_test;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spn_hrd` (IN `p_nama` VARCHAR(100))  BEGIN
SELECT * from hrd where hrd.nama = p_nama;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin` (IN `sp_nama` VARCHAR(100))  BEGIN
SELECT * from admin where admin.nama =sp_nama;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_hmlmr` (IN `p_id` INT(11))  BEGIN
SELECT a.id_histori, d.nik, d.nama, c.posisi, c.cabang, a.kualifikasi, a.nilai_tst, a.aksi, a.tgl_histori from h_mlmr a, melamar b, loker c, pelamar d WHERE
a.id_melamar = b.id_melamar and b.id_loker = c.id_loker and b.id_pelamar = d.id_pelamar and a.id_histori = p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_hrd` (IN `sp_id` INT(11))  BEGIN
SELECT * from hrd where id_hrd = sp_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_loker` (IN `p_id_loker` INT(11))  BEGIN
    SELECT * FROM loker WHERE id_loker = p_id_loker;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_melamar` (IN `p_id` INT(11))  begin 
SELECT a.id_melamar,a.id_loker,a.id_pelamar,b.nik, b.nama, c.posisi, c.cabang, a.kualifikasi,a.nilai_tst, a.tgl_melamar from melamar a, pelamar b, loker c 
WHERE a.id_pelamar = p_id AND a.id_pelamar = b.id_pelamar AND a.id_loker = c.id_loker;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pelamar` (IN `sp_nik` VARCHAR(25))  BEGIN
SELECT * FROM pelamar where pelamar.nik = sp_nik;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pnddkn` (IN `p_id` INT(11))  begin 
SELECT * from p_pnddkn WHERE p_pnddkn.id_pelamar = p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pnglmn` (IN `p_id` INT(11))  begin 
SELECT * from p_pnglmn WHERE p_pnglmn.id_pelamar = p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test` (IN `p_posisi` VARCHAR(30))  begin
SELECT * from test where test.posisi = p_posisi order by id_test;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_admin` (IN `p_id` INT(11), IN `p_nama` VARCHAR(100), IN `p_username` VARCHAR(20), IN `p_password` VARCHAR(20))  begin 
update admin set 
nama=p_nama, username=p_username, `password`=p_password 
where id_admin = p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_hrd` (IN `p_id_hrd` INT(11), IN `p_nama` VARCHAR(100), IN `p_cabang` VARCHAR(20), IN `p_nohp` VARCHAR(25), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(20))  BEGIN
    UPDATE hrd
    SET nama = p_nama,
        cabang = p_cabang,
        nohp = p_nohp,
        email = p_email,
        password = p_password
    WHERE id_hrd = p_id_hrd;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_kualifikasi` (IN `p_id_melamar` INT(11), IN `p_kualifikasi` VARCHAR(20))  BEGIN
    UPDATE melamar
    SET 
        kualifikasi = p_kualifikasi
    WHERE id_melamar = p_id_melamar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_loker` (IN `p_id_loker` INT(11), IN `p_posisi` VARCHAR(50), IN `p_cabang` VARCHAR(20), IN `p_deskripsi` TEXT, IN `p_gaji` VARCHAR(22), IN `p_status` VARCHAR(20))  BEGIN
    UPDATE loker
    SET
        posisi = p_posisi,
        cabang = p_cabang,
        deskripsi = p_deskripsi,
        gaji = p_gaji,
        `status` = p_status
    WHERE id_loker = p_id_loker;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_nilai` (IN `p_id` INT(11), IN `p_nilai` INT(3))  BEGIN
UPDATE melamar SET
melamar.nilai_tst = p_nilai
WHERE melamar.id_melamar = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_pelamar` (IN `p_id_pelamar` INT(11), IN `p_nik` VARCHAR(25), IN `p_nama` VARCHAR(50), IN `p_jk` VARCHAR(2), IN `p_tgl_lahir` DATE, IN `p_nohp` VARCHAR(25), IN `p_alamat` TEXT, IN `p_email` VARCHAR(50), IN `p_password` VARCHAR(20))  BEGIN
    UPDATE pelamar
    SET nik = p_nik,
        nama = p_nama,
        jk = p_jk,
        tgl_lhr = p_tgl_lahir,
        nohp = p_nohp,
        alamat = p_alamat,
        email = p_email,
        `password` = p_password
    WHERE id_pelamar = p_id_pelamar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_pnddkn` (IN `p_id` INT(11), IN `p_sklh` VARCHAR(50), IN `p_jurusan` VARCHAR(30), IN `p_nlai` VARCHAR(11), IN `p_tgl_lulus` DATE)  BEGIN
UPDATE p_pnddkn a set a.sekolah=p_sklh, a.jurusan=p_jurusan, a.nilai=p_nlai, a.thn_lulus=p_tgl_lulus WHERE a.id_pendidikan = p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_pnglmn` (IN `p_id` INT(11), IN `p_prshan` VARCHAR(50), IN `p_posisi` VARCHAR(30), IN `p_f` DATE, IN `p_l` DATE, IN `p_des` TEXT)  BEGIN
UPDATE p_pnglmn a set a.perusahaan=p_prshan, a.posisi=p_posisi, a.f_date=p_f, a.l_date=p_l, a.deskrpsi=p_des WHERE a.id_pengalaman=p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `u_test` (IN `p_id` INT(11), IN `p_prtyn` TEXT, IN `p_a` VARCHAR(100), IN `p_b` VARCHAR(100), IN `p_c` VARCHAR(100), IN `p_jwbn` VARCHAR(5), IN `p_pss` VARCHAR(20))  UPDATE test a set a.pertanyaan = p_prtyn, a.a = p_a, a.b = p_b, a.c = p_c, a.jawaban = p_jwbn, a.posisi = p_pss WHERE a.id_test = p_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `nama`, `username`, `password`) VALUES
(1, 'Yasmin', 'iyas123', 'iyas123');

-- --------------------------------------------------------

--
-- Table structure for table `hrd`
--

CREATE TABLE `hrd` (
  `id_hrd` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `cabang` varchar(20) DEFAULT NULL,
  `nohp` varchar(25) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hrd`
--

INSERT INTO `hrd` (`id_hrd`, `nama`, `cabang`, `nohp`, `email`, `password`) VALUES
(1, 'Ina Asiah', 'Kota Bogor', '0888888', 'inaina@gmail.com', 'inaina123'),
(3, 'Muhamad Yasmin Nul Hakim', 'Jakarta', '0812931293', 'iyasiyas@gmail.com', 'iyas123');

-- --------------------------------------------------------

--
-- Table structure for table `h_mlmr`
--

CREATE TABLE `h_mlmr` (
  `id_histori` int(11) NOT NULL,
  `id_melamar` int(11) NOT NULL,
  `kualifikasi` varchar(20) DEFAULT NULL,
  `nilai_tst` int(3) NOT NULL,
  `aksi` varchar(20) DEFAULT NULL,
  `tgl_histori` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `h_mlmr`
--

INSERT INTO `h_mlmr` (`id_histori`, `id_melamar`, `kualifikasi`, `nilai_tst`, `aksi`, `tgl_histori`) VALUES
(10, 2, 'Administrasi', 0, 'ADD', '2023-06-08'),
(11, 2, 'Test', 0, 'UPDATE', '2023-06-08'),
(12, 2, 'Test', 80, 'UPDATE', '2023-06-08'),
(13, 3, 'Administrasi', 0, 'ADD', '2023-06-09'),
(14, 4, 'Administrasi', 0, 'ADD', '2023-06-09'),
(15, 4, 'Test', 0, 'UPDATE', '2023-06-09'),
(16, 4, 'Test', 100, 'UPDATE', '2023-06-09'),
(17, 2, 'Interview', 80, 'UPDATE', '2023-06-09'),
(18, 5, 'Administrasi', 0, 'ADD', '2023-06-09'),
(19, 5, 'Test', 0, 'UPDATE', '2023-06-09'),
(20, 2, 'Lolos', 80, 'UPDATE', '2023-06-09'),
(21, 3, 'Gagal', 0, 'UPDATE', '2023-06-09'),
(22, 4, 'Interview', 100, 'UPDATE', '2023-06-09'),
(23, 4, 'Lolos', 100, 'UPDATE', '2023-06-09'),
(24, 5, 'Gagal', 0, 'UPDATE', '2023-06-09'),
(25, 5, 'Administrasi', 0, 'UPDATE', '2023-06-09'),
(26, 5, 'Gagal', 0, 'UPDATE', '2023-06-09'),
(27, 5, 'Administrasi', 0, 'UPDATE', '2023-06-09'),
(28, 5, 'Test', 0, 'UPDATE', '2023-06-09'),
(29, 5, 'Interview', 0, 'UPDATE', '2023-06-09'),
(30, 5, 'Gagal', 0, 'UPDATE', '2023-06-09'),
(31, 5, 'Administrasi', 0, 'UPDATE', '2023-06-09'),
(32, 5, 'Test', 0, 'UPDATE', '2023-06-09'),
(33, 5, 'Gagal', 0, 'UPDATE', '2023-06-09'),
(34, 2, 'Administrasi', 0, 'UPDATE', '2023-06-09'),
(35, 3, 'Test', 0, 'UPDATE', '2023-06-09');

-- --------------------------------------------------------

--
-- Table structure for table `loker`
--

CREATE TABLE `loker` (
  `id_loker` int(11) NOT NULL,
  `posisi` varchar(50) DEFAULT NULL,
  `cabang` varchar(20) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `gaji` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `tgl_pblsh` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `loker`
--

INSERT INTO `loker` (`id_loker`, `posisi`, `cabang`, `deskripsi`, `gaji`, `status`, `tgl_pblsh`) VALUES
(1, 'Manager', 'Kota Bogor', 'Requierements:\n1. Berpenampilan Menarik\n2. Bersedia ditempatkan dicabang Kota Bogor\n3. Berpengalaman dibidang yang sama selama 2 tahun\n\nJob Desk:\n1. Memimpin toko\n2. Memberi arahan atau perintah\n3. Membuat Laporan\n4. Memberikan pelayanan yang baik kepada kostumer', '8.550.000', 'Aktif', '2023-05-20'),
(4, 'HRD', 'Kota Bogor', 'Requierements: \r\n1. Berpenampilan Menarik \r\n2. Bersedia ditempatkan di cabang Kota Bogor', '10.000.000', 'Aktif', '2023-05-24'),
(5, 'Store Crew', 'Jakarta', 'Requierements:\n1. Berpenampilan Menarik\n2. Bersedia ditempatkan didaerah Jakarta\n3. Min Lulusan SMA/K\n4. Fresgraduated dipersilahkan melamar', '4.500.000', 'Aktif', '2023-05-26'),
(6, 'Manager', 'Jakarta', 'Requierements:\r\n1. Berpenampilan Menarik\r\n2. Bersedia ditempatkan didaerah Jakarta\r\n3. Min Lulusan SMA/K\r\n4. Fresgraduated dipersilahkan melamar', '9.000.000', 'Aktif', '2023-05-26'),
(7, 'HRD', 'Jakarta', 'Requierements:\r\n1. Berpenampilan Menarik\r\n2. Bersedia ditempatkan didaerah Jakarta\r\n3. Min Lulusan SMA/K\r\n4. Fresgraduated dipersilahkan melamar', '7.000.000', 'Tidak Aktif', '2023-05-26'),
(8, 'Manager', 'Aceh', 'Requierements:\r\n1. Berpenampilan Menarik, Energik.\r\n2. Memiliki jiwa kepemimpinan.\r\n3. Memiliki pengalaman untuk posisi yang sama.\r\n4. Max umur 30 Tahun.\r\n5. Min SMA/K', '9.000.000', 'Aktif', '2023-06-04'),
(9, 'Kurir', 'Kota Bogor', 'Requierements: \n1. Berpenampilan Menarik \n2. Bersedia ditempatkan di cabang Kota Bogor', '4.500.000', 'Aktif', '2023-06-05'),
(10, 'Office Boy', 'Jakarta', 'Requierements:\n1.mampu bekerja dibawah tekanan', '4.500.000', 'Tidak Aktif', '2023-06-05'),
(14, 'Store Crew', 'Jogjakarta', 'Requirements:\n1. Berpenampilan Menarik dan energik\n2. Max umur 23 tahun\n3. Minimal lulusan SMA/K\n4. Freshgraduate dipersilahkan melamar\n5. Domisili Jogjakarta\n\nJob Desk:\n1. Menajaga Kasir\n2. Menata display produk\n3. Menjaga kebersihaan toko\n4. Melayani kostumer', '5.000.000', 'Tidak Aktif', '2023-06-07'),
(15, 'Boss', 'Republik Indonesia', 'Santai dulu ga sih? Ngopi dlu masbro', '1.000.000.000', 'Tidak Aktif', '2023-06-07'),
(16, 'Store Crew', 'Aceh', 'Requirements:\n1. Domisili Aceh\n2. Minimal SMA/K\n3. Umur Max 23 Tahun\n4. Bersedia ditempatkan di Cabang Aceh\n5. Freshgraduated dipersilahkan melamar\n\nJob Desk:\n1. Menata display barang\n2. Melayani kostumer\n3. Menjaga kebersihan toko\n4. Menjadi Kasir\n', '4.500.000', 'Aktif', '2023-06-09');

-- --------------------------------------------------------

--
-- Table structure for table `melamar`
--

CREATE TABLE `melamar` (
  `id_melamar` int(11) NOT NULL,
  `id_loker` int(11) NOT NULL,
  `id_pelamar` int(11) NOT NULL,
  `kualifikasi` varchar(20) DEFAULT NULL,
  `nilai_tst` int(3) DEFAULT NULL,
  `tgl_melamar` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `melamar`
--

INSERT INTO `melamar` (`id_melamar`, `id_loker`, `id_pelamar`, `kualifikasi`, `nilai_tst`, `tgl_melamar`) VALUES
(2, 6, 1, 'Administrasi', 0, '2023-06-08'),
(3, 6, 3, 'Test', 0, '2023-06-09'),
(4, 5, 3, 'Lolos', 100, '2023-06-09'),
(5, 15, 1, 'Gagal', 0, '2023-06-09');

--
-- Triggers `melamar`
--
DELIMITER $$
CREATE TRIGGER `ti_hmlmr` AFTER INSERT ON `melamar` FOR EACH ROW BEGIN
INSERT INTO h_mlmr VALUES (null, new.id_melamar, new.kualifikasi, new.nilai_tst, 'ADD', CURRENT_DATE);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tu_hmlmr` AFTER UPDATE ON `melamar` FOR EACH ROW BEGIN
INSERT INTO h_mlmr VALUES (null, new.id_melamar, new.kualifikasi,new.nilai_tst,'UPDATE', CURRENT_DATE);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pelamar`
--

CREATE TABLE `pelamar` (
  `id_pelamar` int(11) NOT NULL,
  `nik` varchar(25) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jk` varchar(2) DEFAULT NULL,
  `tgl_lhr` date DEFAULT NULL,
  `nohp` varchar(25) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `tgl_dftr` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelamar`
--

INSERT INTO `pelamar` (`id_pelamar`, `nik`, `nama`, `jk`, `tgl_lhr`, `nohp`, `alamat`, `email`, `password`, `tgl_dftr`) VALUES
(1, '3271039020001', 'Muhamad Yasmin Nul Hakim', 'L', '2002-08-03', '08953298123', 'Jalan Kebetulan Saja RT 1 RW 6, Kelurahan Zimbabue No 1', 'iyasiyas@gmail.com', 'iyas123', '2023-05-18'),
(2, '3271030308020002', 'Deliya Syafa', 'P', '2003-09-03', '089515352', 'Jalan Terlalu Jauh No.30, Kota Pejabat, Bali', 'deliyadeliya@gmail.com', 'deliya123', '2023-05-18'),
(3, '3271039020002', 'Ina Asiah', 'P', '2002-09-29', '8953298123', 'Jalan Terpanjang Didunia', 'ina@gmail.com', 'inaina123', '2002-09-09');

-- --------------------------------------------------------

--
-- Table structure for table `p_pnddkn`
--

CREATE TABLE `p_pnddkn` (
  `id_pendidikan` int(11) NOT NULL,
  `id_pelamar` int(11) DEFAULT NULL,
  `sekolah` varchar(50) DEFAULT NULL,
  `jurusan` varchar(30) DEFAULT NULL,
  `nilai` varchar(11) DEFAULT NULL,
  `thn_lulus` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `p_pnddkn`
--

INSERT INTO `p_pnddkn` (`id_pendidikan`, `id_pelamar`, `sekolah`, `jurusan`, `nilai`, `thn_lulus`) VALUES
(8, 1, 'Universitas Binaniaga', 'Teknik Informatika', '3.8', '2023-06-06'),
(10, 1, 'SMK Negeri 2 Kota Bogor', 'Otomotif', '81', '2020-06-17'),
(11, 3, 'Sekolah Lele', 'Matil', '100', '2023-06-07');

-- --------------------------------------------------------

--
-- Table structure for table `p_pnglmn`
--

CREATE TABLE `p_pnglmn` (
  `id_pengalaman` int(11) NOT NULL,
  `id_pelamar` int(11) NOT NULL,
  `perusahaan` varchar(50) NOT NULL,
  `posisi` varchar(60) NOT NULL,
  `f_date` date NOT NULL,
  `l_date` date NOT NULL,
  `deskrpsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `p_pnglmn`
--

INSERT INTO `p_pnglmn` (`id_pengalaman`, `id_pelamar`, `perusahaan`, `posisi`, `f_date`, `l_date`, `deskrpsi`) VALUES
(2, 2, 'Lele Lovers People', 'Petani Lele', '2020-08-20', '2023-04-29', 'Memanen Lele yang sudah besar'),
(4, 1, 'Nissan Datsun', 'Mekanik Magang', '2018-08-20', '2018-11-20', 'Melakukan perbaikan pada kendaraan ringan dan membantu mekanik berkonsultasi dengan costumer'),
(6, 1, 'Google Inc', 'Ads Programmer', '2023-06-03', '2023-06-03', 'Ngopi saat bekerja adalah wajib'),
(8, 3, 'Lele Enjoyer', 'Ternak Lele', '2021-03-02', '2023-05-04', 'Ternak lele dan memakan hasilnya');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id_test` int(11) NOT NULL,
  `pertanyaan` text DEFAULT NULL,
  `a` varchar(100) DEFAULT NULL,
  `b` varchar(100) DEFAULT NULL,
  `c` varchar(100) DEFAULT NULL,
  `jawaban` varchar(30) DEFAULT NULL,
  `posisi` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id_test`, `pertanyaan`, `a`, `b`, `c`, `jawaban`, `posisi`) VALUES
(1, 'Apa itu Makanan ?', 'Makanan adalah Makanan', 'Makanan adalah Food', 'Makanan adalah Kadaharan', 'a', 'Manager'),
(2, 'Apa itu Motor ?', 'Motor adalah Motor', 'Motor adalah Kendaraan', 'Motor adalah Benda bergerak', 'b', 'Manager'),
(3, 'Apa itu Gojek ?', 'Ojek Online', 'Nama Brand', 'Gatau apaan ya', 'b', 'Manager'),
(4, 'Kenapa kita perlu motor ?', 'Untuk lebih cepat sampai tujuan', 'Agar bisa dijual untuk beli IP', 'Agar bisa Hiling', 'b', 'Manager'),
(5, 'Apa yang sedang kamu lakukan ?', 'Main Game', 'Tidur', 'Melamar Kerja', 'c', 'Manager'),
(6, 'Apa yang anda lakukan jika costumer bertanya ?', 'Cuekin', 'Diam saja', 'Menceramahinya', 'c', 'Store Crew'),
(8, 'Untuk apa kamu tidur ?', 'Untuk bermimpi', 'Agar jadi orang kaya', 'Mengistirahatkan Tubuh', 'a', 'Store Crew'),
(9, 'Apa yang biasanya kucing lakukan ?', 'Tiduran', 'Mengeong', 'Minta Honda Civic Turbo', 'c', 'Store Crew');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `hrd`
--
ALTER TABLE `hrd`
  ADD PRIMARY KEY (`id_hrd`);

--
-- Indexes for table `h_mlmr`
--
ALTER TABLE `h_mlmr`
  ADD PRIMARY KEY (`id_histori`),
  ADD KEY `id_melamar` (`id_melamar`);

--
-- Indexes for table `loker`
--
ALTER TABLE `loker`
  ADD PRIMARY KEY (`id_loker`);

--
-- Indexes for table `melamar`
--
ALTER TABLE `melamar`
  ADD PRIMARY KEY (`id_melamar`),
  ADD KEY `id_loker` (`id_loker`),
  ADD KEY `id_pelamar` (`id_pelamar`);

--
-- Indexes for table `pelamar`
--
ALTER TABLE `pelamar`
  ADD PRIMARY KEY (`id_pelamar`);

--
-- Indexes for table `p_pnddkn`
--
ALTER TABLE `p_pnddkn`
  ADD PRIMARY KEY (`id_pendidikan`),
  ADD KEY `id_pelamar` (`id_pelamar`);

--
-- Indexes for table `p_pnglmn`
--
ALTER TABLE `p_pnglmn`
  ADD PRIMARY KEY (`id_pengalaman`),
  ADD KEY `id_pelamar` (`id_pelamar`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id_test`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrd`
--
ALTER TABLE `hrd`
  MODIFY `id_hrd` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `h_mlmr`
--
ALTER TABLE `h_mlmr`
  MODIFY `id_histori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `loker`
--
ALTER TABLE `loker`
  MODIFY `id_loker` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `melamar`
--
ALTER TABLE `melamar`
  MODIFY `id_melamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pelamar`
--
ALTER TABLE `pelamar`
  MODIFY `id_pelamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `p_pnddkn`
--
ALTER TABLE `p_pnddkn`
  MODIFY `id_pendidikan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `p_pnglmn`
--
ALTER TABLE `p_pnglmn`
  MODIFY `id_pengalaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id_test` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `h_mlmr`
--
ALTER TABLE `h_mlmr`
  ADD CONSTRAINT `h_mlmr_ibfk_1` FOREIGN KEY (`id_melamar`) REFERENCES `melamar` (`id_melamar`);

--
-- Constraints for table `melamar`
--
ALTER TABLE `melamar`
  ADD CONSTRAINT `melamar_ibfk_1` FOREIGN KEY (`id_loker`) REFERENCES `loker` (`id_loker`),
  ADD CONSTRAINT `melamar_ibfk_2` FOREIGN KEY (`id_pelamar`) REFERENCES `pelamar` (`id_pelamar`);

--
-- Constraints for table `p_pnddkn`
--
ALTER TABLE `p_pnddkn`
  ADD CONSTRAINT `p_pnddkn_ibfk_1` FOREIGN KEY (`id_pelamar`) REFERENCES `pelamar` (`id_pelamar`);

--
-- Constraints for table `p_pnglmn`
--
ALTER TABLE `p_pnglmn`
  ADD CONSTRAINT `p_pnglmn_ibfk_1` FOREIGN KEY (`id_pelamar`) REFERENCES `pelamar` (`id_pelamar`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
