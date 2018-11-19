-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 19, 2018 at 12:31 PM
-- Server version: 5.7.24-0ubuntu0.16.04.1
-- PHP Version: 7.0.32-4+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carbooking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) NOT NULL,
  `transaction_id` int(10) NOT NULL,
  `drop_location` varchar(100) NOT NULL,
  `pick_location` varchar(100) NOT NULL,
  `drop_time` datetime NOT NULL,
  `pick_time` datetime NOT NULL,
  `fare` int(255) NOT NULL,
  `additional_fee` int(255) NOT NULL,
  `discount` int(255) NOT NULL,
  `total_amount` int(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `transaction_id`, `drop_location`, `pick_location`, `drop_time`, `pick_time`, `fare`, `additional_fee`, `discount`, `total_amount`, `created_at`, `updated_at`) VALUES
(1, 1, '1', '1', '2018-11-12 10:00:00', '2018-11-11 00:00:00', 300000, 0, 0, 300000, '2018-11-11 13:32:52', NULL),
(2, 2, '1', '1', '2018-11-13 00:00:00', '2018-11-11 00:00:00', 400000, 0, 0, 400000, '2018-11-11 14:00:37', NULL),
(3, 15, 'JKT 2', 'null', '2018-11-23 17:00:00', '2018-11-22 17:00:00', 300000, 0, 0, 300000, '2018-11-19 05:29:28', '2018-11-19 05:29:28');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `address`, `city`, `created_at`, `updated_at`) VALUES
(1, 'JKT 1', 'CGK', 'Jakarta', '2018-11-12 00:28:34', NULL),
(2, 'JKT 2', 'Halim', 'Jakarta', '2018-11-12 00:28:34', NULL),
(3, 'BDG 1', 'Stasiun Bandung', 'Bandung', '2018-11-12 00:28:34', NULL),
(4, 'BGD 2 ', 'Stasiun Ciara Condong', 'Bandung', '2018-11-12 00:28:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` int(10) NOT NULL,
  `additional_fee` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partners`
--

INSERT INTO `partners` (`id`, `name`, `active`, `additional_fee`, `created_at`, `updated_at`) VALUES
(1, 'Car Partner 1', 1, 0, '2018-11-11 23:34:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `partners_location`
--

CREATE TABLE `partners_location` (
  `id` int(10) NOT NULL,
  `location_id` int(10) NOT NULL,
  `partner_id` int(10) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partners_location`
--

INSERT INTO `partners_location` (`id`, `location_id`, `partner_id`, `code`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '', '2018-11-12 00:39:29', NULL),
(2, 2, 1, '', '2018-11-12 00:39:29', NULL),
(3, 3, 1, '', '2018-11-12 00:39:29', NULL),
(4, 4, 1, '', '2018-11-12 00:39:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pessengers`
--

CREATE TABLE `pessengers` (
  `id` int(10) NOT NULL,
  `identity_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `age` int(10) NOT NULL,
  `address` varchar(255) NOT NULL,
  `booking_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pessengers`
--

INSERT INTO `pessengers` (`id`, `identity_id`, `name`, `email`, `phone`, `age`, `address`, `booking_id`, `created_at`, `updated_at`) VALUES
(1, '3315042912960002', 'Condro Wiyono', 'condro@outlook.co.id', '08998816627', 20, 'Sd Luhur', 1, '2018-11-12 00:50:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) NOT NULL,
  `partner_id` int(10) NOT NULL,
  `car_info` text NOT NULL,
  `status` int(10) NOT NULL,
  `buyer_name` varchar(255) NOT NULL,
  `buyer_email` varchar(255) NOT NULL,
  `invoice_id` varchar(255) NOT NULL,
  `total_amount` int(255) NOT NULL,
  `expired_time` datetime NOT NULL,
  `booked_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `issued_at` timestamp NULL DEFAULT NULL,
  `cancel_at` timestamp NULL DEFAULT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `partner_id`, `car_info`, `status`, `buyer_name`, `buyer_email`, `invoice_id`, `total_amount`, `expired_time`, `booked_at`, `issued_at`, `cancel_at`, `failed_at`, `expired_at`, `created_at`, `updated_at`) VALUES
(1, 1, '', 1, 'condro', 'condro', '212123123', 300000, '2018-11-12 00:00:00', '2018-11-11 13:32:03', NULL, NULL, NULL, NULL, '2018-11-12 00:17:17', NULL),
(2, 2, '', 1, 'condro', 'condro', '2123123', 400000, '2018-11-13 00:00:00', '2018-11-11 13:59:22', NULL, NULL, NULL, NULL, '2018-11-12 00:17:17', NULL),
(3, 1, '1', 0, 'Co', 'cp@so.co', '850', 10000, '2018-11-19 06:58:51', '2018-11-19 03:58:51', '2018-11-19 03:58:51', NULL, NULL, NULL, '2018-11-19 03:58:51', '2018-11-19 03:58:51'),
(4, 1, '2', 1, 'C222', 'cp@so', '159', 10000, '2018-11-19 07:07:07', '2018-11-19 04:38:09', '2018-11-19 04:07:07', NULL, '2018-11-19 04:44:46', NULL, '2018-11-19 04:07:07', '2018-11-19 04:44:46'),
(5, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 0, 'Condro', 'condro@outlook.co.id', '468', 300000, '2018-11-19 07:13:12', '2018-11-19 04:13:12', '2018-11-19 04:13:12', NULL, NULL, NULL, '2018-11-19 04:13:12', '2018-11-19 04:13:12'),
(6, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 0, 'Condro', 'condro@outlook.co.id', '266', 300000, '2018-11-19 08:00:47', '2018-11-19 05:00:47', '2018-11-19 05:00:47', NULL, NULL, NULL, '2018-11-19 05:00:47', '2018-11-19 05:00:47'),
(7, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 0, 'Condro', 'condro@outlook.co.id', '299', 300000, '2018-11-19 08:00:53', '2018-11-19 05:00:53', '2018-11-19 05:00:53', NULL, NULL, NULL, '2018-11-19 05:00:53', '2018-11-19 05:00:53'),
(8, 1, '1', 0, 'Co', 'co@cco', '382', 900000, '2018-11-19 08:04:06', '2018-11-19 05:04:06', '2018-11-19 05:04:06', NULL, NULL, NULL, '2018-11-19 05:04:06', '2018-11-19 05:04:06'),
(9, 1, '{"id":2,"model":"Car Model","type":"Yamaha","seat":4,"gear":0,"have_ac":1,"fare":200000,"status":1,"checkpoint_id":1}', 0, 'Condro', 'condro@outlook.co.id', '100', 400000, '2018-11-19 08:06:28', '2018-11-19 05:06:28', '2018-11-19 05:06:28', NULL, NULL, NULL, '2018-11-19 05:06:28', '2018-11-19 05:06:28'),
(10, 1, '{"id":2,"model":"Car Model","type":"Yamaha","seat":4,"gear":0,"have_ac":1,"fare":200000,"status":1,"checkpoint_id":1}', 0, 'Condro', 'condro@outlook.co.id', '646', 200000, '2018-11-19 08:13:06', '2018-11-19 05:13:06', '2018-11-19 05:13:06', NULL, NULL, NULL, '2018-11-19 05:13:06', '2018-11-19 05:13:06'),
(11, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 11, 'Condr', 'condro@outlook.co.id', '764', 600000, '2018-11-19 08:14:39', '2018-11-19 05:14:39', '2018-11-19 05:14:39', NULL, '2018-11-19 05:14:45', NULL, '2018-11-19 05:14:39', '2018-11-19 05:14:45'),
(12, 1, '{"id":2,"model":"Car Model","type":"Yamaha","seat":4,"gear":0,"have_ac":1,"fare":200000,"status":1,"checkpoint_id":1}', 12, 'Condro', 'condro@outlook.co.id', '140', 200000, '2018-11-19 08:16:30', '2018-11-19 05:16:30', '2018-11-19 05:16:30', NULL, '2018-11-19 05:16:33', NULL, '2018-11-19 05:16:30', '2018-11-19 05:16:33'),
(13, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 13, 'Condro', 'condro@outlook.co.id', '646', 300000, '2018-11-19 08:19:30', '2018-11-19 05:19:30', '2018-11-19 05:19:30', NULL, '2018-11-19 05:19:36', NULL, '2018-11-19 05:19:30', '2018-11-19 05:19:36'),
(14, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 14, 'Condro', 'condro@outlook.co.id', '639', 300000, '2018-11-19 08:22:47', '2018-11-19 05:22:47', '2018-11-19 05:22:47', NULL, '2018-11-19 05:24:11', NULL, '2018-11-19 05:22:47', '2018-11-19 05:24:11'),
(15, 1, '{"id":1,"model":"Daihatsu","type":"Xenia","seat":5,"gear":4,"have_ac":1,"fare":300000,"status":1,"checkpoint_id":1}', 1, 'Condro', 'condro@outlook.co.id', '235', 300000, '2018-11-19 08:26:33', '2018-11-19 05:26:33', '2018-11-19 05:26:33', NULL, '2018-11-19 05:29:28', NULL, '2018-11-19 05:26:33', '2018-11-19 05:29:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `drop_location` (`drop_location`),
  ADD KEY `pick_location` (`pick_location`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `partners_location`
--
ALTER TABLE `partners_location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `partner_id` (`partner_id`);

--
-- Indexes for table `pessengers`
--
ALTER TABLE `pessengers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_id` (`partner_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `partners_location`
--
ALTER TABLE `partners_location`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `pessengers`
--
ALTER TABLE `pessengers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `partners_location`
--
ALTER TABLE `partners_location`
  ADD CONSTRAINT `partners_location_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `partners_location_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`);

--
-- Constraints for table `pessengers`
--
ALTER TABLE `pessengers`
  ADD CONSTRAINT `pessengers_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners_location` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
