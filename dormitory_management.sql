-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2024 at 06:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dormitory_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `dormitories`
--

CREATE TABLE `dormitories` (
  `dorm_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dormitories`
--

INSERT INTO `dormitories` (`dorm_id`, `name`, `location`) VALUES
(1, 'Ký túc xá Ngoại ngữ', '144 Xuân Thủy');

-- --------------------------------------------------------

--
-- Table structure for table `monthly_fees`
--

CREATE TABLE `monthly_fees` (
  `fee_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `ktx_fee` decimal(10,2) NOT NULL,
  `electricity_fee` decimal(10,2) NOT NULL,
  `water_fee` decimal(10,2) NOT NULL,
  `total_fee` decimal(10,2) GENERATED ALWAYS AS (`ktx_fee` + `electricity_fee` + `water_fee`) STORED,
  `status` enum('Chưa đóng','Đã đóng','Quá hạn') DEFAULT 'Chưa đóng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `monthly_fees`
--

INSERT INTO `monthly_fees` (`fee_id`, `room_id`, `ktx_fee`, `electricity_fee`, `water_fee`, `status`, `created_at`) VALUES
(3, 2, 200000.00, 150000.00, 350000.00, 'Chưa đóng', '2024-11-19 03:19:01'),
(7, 2, 200000.00, 101000.00, 150000.00, 'Đã đóng', '2024-10-19 05:13:01');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `dorm_id` int(11) NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `capacity` int(11) NOT NULL,
  `current_occupancy` int(11) DEFAULT 0,
  `staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `dorm_id`, `room_number`, `capacity`, `current_occupancy`, `staff_id`) VALUES
(1, 1, '101A', 6, 0, NULL),
(2, 1, '102A', 6, 2, NULL),
(3, 1, '103B', 6, 0, NULL),
(4, 1, '104B', 6, 0, NULL),
(5, 1, '105B', 6, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `user_id`, `full_name`, `phone`) VALUES
(1, 22, 'Nguyên Mạnh', '0823004392'),
(2, 23, 'Lê Văn C', '0903345678'),
(3, 14, 'Phạm Thị D', '0904456789'),
(4, 15, 'Hoàng Văn E', '0905567890');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `religion` varchar(50) DEFAULT NULL,
  `major` varchar(100) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT 0,
  `room_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `user_id`, `full_name`, `dob`, `gender`, `ethnicity`, `religion`, `major`, `class`, `phone`, `approved`, `room_id`) VALUES
(20, 16, 'Nguyen Van A', '2000-05-15', 'male', 'Kinh', 'None', 'Computer Science', 'K66CB', '0123456789', 1, 2),
(21, 17, 'Duong Duc Huy', '2003-05-15', 'male', 'Kinh', 'None', 'Computer Science', 'K66CB', '0123456789', 1, 2),
(25, 18, 'Dương Đức Minh', '2024-12-19', 'male', 'Kinh', 'Không ', 'CNTT', 'K66CB', '12312312312', 1, 1),
(26, 20, 'Nguyễn Thu Trang', '2024-12-12', 'female', 'Kinh', 'Không ', 'CNTT', 'K66CB', '029938348', 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `student_requests`
--

CREATE TABLE `student_requests` (
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `request_type` enum('Đổi phòng','Ra khỏi ký túc xá','Duyệt vào ký túc xá','Khác') NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('Chờ xử lý','Đã xử lý','Từ chối') DEFAULT 'Chờ xử lý',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_requests`
--

INSERT INTO `student_requests` (`request_id`, `user_id`, `staff_id`, `request_type`, `description`, `status`, `created_at`) VALUES
(1, 16, 1, 'Duyệt vào ký túc xá', 'Duyệt vào ký túc xá', 'Đã xử lý', '2024-12-09 05:23:52'),
(2, 17, 1, 'Duyệt vào ký túc xá', 'Duyệt vào ký túc xá', 'Đã xử lý', '2024-12-09 05:23:52'),
(3, 16, 1, 'Đổi phòng', 'Muốn ở cùng bạn', 'Từ chối', '2024-12-09 05:23:52'),
(4, 18, 1, 'Duyệt vào ký túc xá', 'Duyệt vào ký túc xá', 'Đã xử lý', '2024-12-09 05:29:27'),
(5, 20, 1, 'Duyệt vào ký túc xá', 'Duyệt vào ký túc xá', 'Đã xử lý', '2024-12-09 10:22:22'),
(6, 20, 1, 'Ra khỏi ký túc xá', 'Vì đã tốt nghiệp.', 'Đã xử lý', '2024-12-09 16:14:54'),
(7, 18, 1, 'Ra khỏi ký túc xá', 'vì muốn bảo lưu kết quả.', 'Từ chối', '2024-12-09 17:07:44'),
(8, 16, 1, 'Đổi phòng', 'Muốn đổi sang phòng 101A để ở với bạn, cùng học bài.', 'Đã xử lý', '2024-12-09 17:41:19'),
(9, 16, 1, 'Khác', 'Xin phép về muộn hôm t5 tuần sau vì bận đi sự kiện của trường.', 'Đã xử lý', '2024-12-09 17:51:18'),
(10, 18, 1, 'Đổi phòng', 'Muốn sang phòng 101A.', 'Đã xử lý', '2024-12-10 04:40:55'),
(11, 18, 1, 'Ra khỏi ký túc xá', 'vì sắp tốt nghiệp.', 'Đã xử lý', '2024-12-10 05:13:10'),
(12, 16, 1, 'Đổi phòng', 'đổi sang 102A', 'Đã xử lý', '2024-12-10 05:19:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','student','staff') NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `password`, `role`, `email`) VALUES
(7, '$2b$10$uCtU7b06Rln86HYXAhUY3.jjXqMtfZl535t8RUXngTx/8IgVXOy16', 'student', 'huy2@gmail.com'),
(8, '$2b$10$63sJvD1E/22O2f8b0HnpuuiY2296G8DGM.MjHL2sXS6L55t9ZhtUm', 'student', 'huy3@gmail.com'),
(10, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'admin', 'huy@gmail.com'),
(14, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'staff', 'user11@example.com'),
(15, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'staff', 'user12@example.com'),
(16, '$2b$10$ZXX9W3rXnSIwinIPslLwY.7qIQ7g8epgmhgpamhUJsugRTZ8gxwkG', 'student', 'nguyenvana@gmail.com'),
(17, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'student', 'user4@example.com'),
(18, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'student', 'user5@example.com'),
(19, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'student', 'user6@example.com'),
(20, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'student', 'user7@example.com'),
(21, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'student', 'user8@example.com'),
(22, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'staff', 'staff@gmail.com'),
(23, '$2b$10$jwWngqdf87bwX3ECYV2AbORnZSoWrXZ5IURR.WTVQEk2MedSACcl.', 'staff', 'user10@example.com'),
(27, '$2b$10$mjLd6P4sMpTqduV/kBJ9qutdnK6QY202V0HAq5OQAoAaK3eyqLAfe', 'student', 'new2@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dormitories`
--
ALTER TABLE `dormitories`
  ADD PRIMARY KEY (`dorm_id`);

--
-- Indexes for table `monthly_fees`
--
ALTER TABLE `monthly_fees`
  ADD PRIMARY KEY (`fee_id`),
  ADD KEY `fk_monthly_fee_room` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `dorm_id` (`dorm_id`),
  ADD KEY `fk_staff` (`staff_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `student_requests`
--
ALTER TABLE `student_requests`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dormitories`
--
ALTER TABLE `dormitories`
  MODIFY `dorm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `monthly_fees`
--
ALTER TABLE `monthly_fees`
  MODIFY `fee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `student_requests`
--
ALTER TABLE `student_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `monthly_fees`
--
ALTER TABLE `monthly_fees`
  ADD CONSTRAINT `fk_monthly_fee_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `fk_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`dorm_id`) REFERENCES `dormitories` (`dorm_id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
