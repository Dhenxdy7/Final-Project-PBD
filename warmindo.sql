-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 20 Jul 2023 pada 16.59
-- Versi Server: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `warmindo`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_total_harga_pesanan` ()  BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pesanan_id INT;
    DECLARE total_harga DECIMAL(10, 2);

        DECLARE cur CURSOR FOR SELECT id FROM pesanan;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO pesanan_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

                SET total_harga = hitung_total_harga_pesanan(pesanan_id);

                SELECT CONCAT('Pesanan ID ', pesanan_id, ': Total Harga = ', total_harga);
    END LOOP;

    CLOSE cur;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_total_harga_pesanan` (`pesanan_id` INT) RETURNS DECIMAL(10,2) BEGIN
    DECLARE total_harga DECIMAL(10, 2);
    SELECT SUM(menu.harga * pesanan_menu.jumlah) INTO total_harga
    FROM pesanan_menu
    JOIN menu ON pesanan_menu.menu_id = menu.id
    WHERE pesanan_menu.pesanan_id = pesanan_id;
    RETURN total_harga;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nama_menu` varchar(255) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `warmindo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `menu`
--

INSERT INTO `menu` (`id`, `nama_menu`, `harga`, `warmindo_id`) VALUES
(1, 'Nasi Goreng', '25000.00', 1),
(2, 'Ayam Bakar', '30000.00', 1),
(3, 'Mie Ayam', '20000.00', 2),
(4, 'Soto Ayam', '22000.00', 2),
(5, 'Nasi Uduk', '18000.00', 3),
(6, 'Ikan Bakar', '35000.00', 3),
(7, 'Mie Goreng', '23000.00', 4),
(8, 'Bakso', '15000.00', 4),
(9, 'Nasi Kuning', '20000.00', 5),
(10, 'Rendang', '28000.00', 5),
(11, 'Sate Ayam', '18000.00', 6),
(12, 'Soto Betawi', '22000.00', 6),
(13, 'Soto Lamongan', '21000.00', 7),
(14, 'Rawon', '25000.00', 7),
(15, 'Nasi Goreng Special', '28000.00', 8),
(16, 'Ayam Geprek', '25000.00', 8),
(17, 'Kwetiau Goreng', '22000.00', 9),
(18, 'Sop Buntut', '30000.00', 9),
(19, 'Gado-gado', '18000.00', 10);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelayan`
--

CREATE TABLE `pelayan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `warmindo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pelayan`
--

INSERT INTO `pelayan` (`id`, `nama`, `telepon`, `warmindo_id`) VALUES
(1, 'Budi', '08123456789', 1),
(2, 'Siti', '08234567890', 2),
(3, 'Joko', '08345678901', 3),
(4, 'Rini', '08456789012', 4),
(5, 'Ahmad', '08567890123', 5),
(6, 'Dewi', '08678901234', 6),
(7, 'Rudi', '08789012345', 7),
(8, 'Lina', '08890123456', 8),
(9, 'Eko', '08901234567', 9),
(10, 'Sinta', '08912345678', 10),
(11, 'Fajar', '08923456789', 11),
(12, 'Rina', '08934567890', 12),
(13, 'Andi', '08945678901', 13),
(14, 'Ratna', '08956789012', 14),
(15, 'Hadi', '08967890123', 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesanan`
--

CREATE TABLE `pesanan` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `meja` int(11) NOT NULL,
  `jumlah_tamu` int(11) NOT NULL,
  `warmindo_id` int(11) NOT NULL,
  `pelayan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pesanan`
--

INSERT INTO `pesanan` (`id`, `tanggal`, `meja`, `jumlah_tamu`, `warmindo_id`, `pelayan_id`) VALUES
(1, '2023-07-20', 1, 4, 1, 1),
(2, '2023-07-20', 2, 2, 2, 2),
(3, '2023-07-21', 3, 6, 3, 3),
(4, '2023-07-21', 4, 5, 4, 4),
(5, '2023-07-22', 5, 8, 5, 5),
(6, '2023-07-22', 6, 3, 6, 6),
(7, '2023-07-23', 7, 7, 7, 7),
(8, '2023-07-23', 8, 4, 8, 8),
(9, '2023-07-24', 9, 5, 9, 9),
(10, '2023-07-24', 10, 3, 10, 10),
(11, '2023-07-25', 11, 6, 11, 11),
(12, '2023-07-25', 12, 2, 12, 12),
(13, '2023-07-26', 13, 4, 13, 13),
(14, '2023-07-26', 14, 7, 14, 14),
(15, '2023-07-27', 15, 5, 15, 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesanan_menu`
--

CREATE TABLE `pesanan_menu` (
  `id` int(11) NOT NULL,
  `pesanan_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pesanan_menu`
--

INSERT INTO `pesanan_menu` (`id`, `pesanan_id`, `menu_id`, `jumlah`) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 3, 4, 3),
(5, 3, 5, 2),
(6, 4, 7, 2),
(7, 5, 10, 1),
(8, 6, 12, 3),
(9, 7, 15, 2),
(10, 8, 17, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `warmindo`
--

CREATE TABLE `warmindo` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `telepon` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `warmindo`
--

INSERT INTO `warmindo` (`id`, `nama`, `alamat`, `telepon`) VALUES
(1, 'Warmindo Jakarta', 'Jalan Raya No. 123', '08123456789'),
(2, 'Warmindo Surabaya', 'Jalan Utama No. 456', '08234567890'),
(3, 'Warmindo Bandung', 'Jalan Tengah No. 789', '08345678901'),
(4, 'Warmindo Medan', 'Jalan Baru No. 246', '08456789012'),
(5, 'Warmindo Semarang', 'Jalan Lama No. 135', '08567890123'),
(6, 'Warmindo Yogyakarta', 'Jalan Sudirman No. 246', '08678901234'),
(7, 'Warmindo Makassar', 'Jalan Thamrin No. 357', '08789012345'),
(8, 'Warmindo Palembang', 'Jalan Pahlawan No. 468', '08890123456'),
(9, 'Warmindo Malang', 'Jalan Diponegoro No. 579', '08901234567'),
(10, 'Warmindo Bekasi', 'Jalan Gajah Mada No. 680', '08912345678'),
(11, 'Warmindo Bogor', 'Jalan Surya Kencana No. 791', '08923456789'),
(12, 'Warmindo Tangerang', 'Jalan Merdeka No. 802', '08934567890'),
(13, 'Warmindo Padang', 'Jalan Anggrek No. 913', '08945678901'),
(14, 'Warmindo Denpasar', 'Jalan Kembang No. 24', '08956789012'),
(15, 'Warmindo Samarinda', 'Jalan Melati No. 35', '08967890123'),
(16, 'Warmindo Pekanbaru', 'Jalan Mawar No. 46', '08978901234'),
(17, 'Warmindo Cimahi', 'Jalan Kenanga No. 57', '08989012345'),
(18, 'Warmindo Balikpapan', 'Jalan Dahlia No. 68', '08990123456'),
(19, 'Warmindo Jambi', 'Jalan Sakura No. 79', '08901234567'),
(20, 'Warmindo Depok', 'Jalan Flamboyan No. 80', '08912345678'),
(21, 'Warmindo Makassar', 'Jalan Anggrek No. 91', '08923456789'),
(22, 'Warmindo Pontianak', 'Jalan Cempaka No. 102', '08934567890'),
(23, 'Warmindo Surakarta', 'Jalan Lily No. 113', '08945678901'),
(24, 'Warmindo Banjarmasin', 'Jalan Tulip No. 124', '08956789012'),
(25, 'Warmindo Bekasi', 'Jalan Rose No. 235', '08967890123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warmindo_id` (`warmindo_id`);

--
-- Indexes for table `pelayan`
--
ALTER TABLE `pelayan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `warmindo_id` (`warmindo_id`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warmindo_id` (`warmindo_id`),
  ADD KEY `pelayan_id` (`pelayan_id`);

--
-- Indexes for table `pesanan_menu`
--
ALTER TABLE `pesanan_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pesanan_id` (`pesanan_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `warmindo`
--
ALTER TABLE `warmindo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `pelayan`
--
ALTER TABLE `pelayan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `pesanan_menu`
--
ALTER TABLE `pesanan_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `warmindo`
--
ALTER TABLE `warmindo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`warmindo_id`) REFERENCES `warmindo` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pelayan`
--
ALTER TABLE `pelayan`
  ADD CONSTRAINT `pelayan_ibfk_1` FOREIGN KEY (`warmindo_id`) REFERENCES `warmindo` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`warmindo_id`) REFERENCES `warmindo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`pelayan_id`) REFERENCES `pelayan` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pesanan_menu`
--
ALTER TABLE `pesanan_menu`
  ADD CONSTRAINT `pesanan_menu_ibfk_1` FOREIGN KEY (`pesanan_id`) REFERENCES `pesanan` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanan_menu_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
