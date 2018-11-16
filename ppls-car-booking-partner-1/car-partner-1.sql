-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 14, 2018 at 04:24 PM
-- Server version: 5.7.24-0ubuntu0.16.04.1
-- PHP Version: 7.0.32-3+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `car-partner-1`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) NOT NULL,
  `transaction_id` int(10) NOT NULL,
  `drop_location` int(10) NOT NULL,
  `pick_location` int(10) NOT NULL,
  `drop_time` datetime NOT NULL,
  `pick_time` datetime NOT NULL,
  `fare` int(255) NOT NULL,
  `additional_fee` int(255) NOT NULL,
  `discount` int(255) NOT NULL,
  `total_amount` int(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `transaction_id`, `drop_location`, `pick_location`, `drop_time`, `pick_time`, `fare`, `additional_fee`, `discount`, `total_amount`, `created_at`, `edited_at`) VALUES
(1, 1, 1, 1, '2018-11-12 10:00:00', '2018-11-11 00:00:00', 300000, 0, 0, 300000, '2018-11-11 13:32:52', NULL),
(2, 2, 1, 1, '2018-11-13 00:00:00', '2018-11-11 00:00:00', 400000, 0, 0, 400000, '2018-11-11 14:00:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `id` int(10) NOT NULL,
  `model` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `seat` int(10) NOT NULL,
  `gear` int(1) NOT NULL,
  `have_ac` int(1) NOT NULL,
  `fare` int(255) NOT NULL,
  `status` int(11) NOT NULL,
  `checkpoint_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `model`, `type`, `seat`, `gear`, `have_ac`, `fare`, `status`, `checkpoint_id`) VALUES
(1, 'Daihatsu', 'Xenia', 5, 4, 1, 300000, 1, 1),
(2, 'Car Model', 'Yamaha', 4, 0, 1, 200000, 1, 1),
(3, 'Car Model 2', 'Honda', 3, 4, 1, 100000, 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `address`, `city`) VALUES
(1, 'JKT 1', 'CGK', 'Jakarta'),
(2, 'JKT 2', 'Halim', 'Jakarta'),
(3, 'BDG 1', 'Stasiun Bandung', 'Bandung'),
(4, 'BGD 2 ', 'Stasiun Ciara Condong', 'Bandung');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) NOT NULL,
  `car_id` int(10) NOT NULL,
  `status` int(10) NOT NULL,
  `buyer_name` varchar(255) NOT NULL,
  `buyer_email` varchar(255) NOT NULL,
  `invoiced_id` varchar(255) NOT NULL,
  `total_amount` int(255) NOT NULL,
  `expired_time` datetime NOT NULL,
  `booked_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `issued_at` timestamp NULL DEFAULT NULL,
  `cancel_at` timestamp NULL DEFAULT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `car_id`, `status`, `buyer_name`, `buyer_email`, `invoiced_id`, `total_amount`, `expired_time`, `booked_at`, `issued_at`, `cancel_at`, `failed_at`, `expired_at`) VALUES
(1, 1, 0, 'condro', 'condro', '212123123', 300000, '2018-11-12 00:00:00', '2018-11-11 13:32:03', NULL, NULL, NULL, NULL),
(2, 2, 0, 'condro', 'condro', '2123123', 400000, '2018-11-13 00:00:00', '2018-11-11 13:59:22', NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
