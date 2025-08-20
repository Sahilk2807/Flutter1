-- GP SIR EDUCATION Database Schema
-- Run this script to create the required tables

CREATE DATABASE IF NOT EXISTS gp_sir_education CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gp_sir_education;

-- Users table
CREATE TABLE gpe_users (
    firebase_uid VARCHAR(64) PRIMARY KEY,
    email VARCHAR(255) NULL,
    name VARCHAR(120) NULL,
    mobile VARCHAR(20) NULL,
    address TEXT NULL,
    class VARCHAR(50) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_class (class),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Admins table
CREATE TABLE gpe_admins (
    firebase_uid VARCHAR(64) PRIMARY KEY,
    note VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (firebase_uid) REFERENCES gpe_users(firebase_uid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Contact messages table
CREATE TABLE gpe_contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- FCM tokens table (for push notifications)
CREATE TABLE gpe_fcm_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firebase_uid VARCHAR(64) NOT NULL,
    token VARCHAR(255) NOT NULL,
    device_type ENUM('android', 'ios', 'web') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY unique_user_token (firebase_uid, token),
    FOREIGN KEY (firebase_uid) REFERENCES gpe_users(firebase_uid) ON DELETE CASCADE,
    INDEX idx_firebase_uid (firebase_uid),
    INDEX idx_device_type (device_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Courses table (for future expansion)
CREATE TABLE gpe_courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) DEFAULT 0.00,
    duration_months INT DEFAULT 1,
    class VARCHAR(50),
    subject VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_class (class),
    INDEX idx_subject (subject),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Lectures table (for future expansion)
CREATE TABLE gpe_lectures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    video_url VARCHAR(500),
    duration_minutes INT DEFAULT 0,
    is_free BOOLEAN DEFAULT TRUE,
    order_index INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (course_id) REFERENCES gpe_courses(id) ON DELETE SET NULL,
    INDEX idx_course_id (course_id),
    INDEX idx_is_free (is_free),
    INDEX idx_order_index (order_index)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- User course enrollments (for future expansion)
CREATE TABLE gpe_user_enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firebase_uid VARCHAR(64) NOT NULL,
    course_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    progress_percentage DECIMAL(5,2) DEFAULT 0.00,
    
    UNIQUE KEY unique_user_course (firebase_uid, course_id),
    FOREIGN KEY (firebase_uid) REFERENCES gpe_users(firebase_uid) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES gpe_courses(id) ON DELETE CASCADE,
    INDEX idx_firebase_uid (firebase_uid),
    INDEX idx_course_id (course_id),
    INDEX idx_progress (progress_percentage)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default admin (replace with actual Firebase UID)
INSERT INTO gpe_users (firebase_uid, email, name) VALUES 
('admin_firebase_uid_here', 'admin@gpsireducation.com', 'Admin User');

INSERT INTO gpe_admins (firebase_uid, note) VALUES 
('admin_firebase_uid_here', 'Super Admin');

-- Insert sample courses
INSERT INTO gpe_courses (title, description, price, duration_months, class, subject) VALUES
('Complete Mathematics Course', 'Master all mathematics concepts for MP Board', 999.00, 6, 'Class 12', 'Mathematics'),
('Physics Fundamentals', 'Complete physics course with practical examples', 799.00, 4, 'Class 12', 'Physics'),
('Chemistry Mastery', 'Comprehensive chemistry course for board exams', 899.00, 5, 'Class 12', 'Chemistry');

-- Insert sample lectures
INSERT INTO gpe_lectures (course_id, title, description, duration_minutes, is_free) VALUES
(1, 'Quadratic Equations - Part 1', 'Introduction to quadratic equations', 45, TRUE),
(1, 'Quadratic Equations - Part 2', 'Solving quadratic equations', 50, FALSE),
(2, 'Laws of Motion', 'Newton\'s laws of motion explained', 38, TRUE),
(3, 'Periodic Table', 'Understanding the periodic table', 52, TRUE);

