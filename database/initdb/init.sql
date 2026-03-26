-- Ensure the database exists and use it
CREATE DATABASE IF NOT EXISTS IS436;
USE IS436;

-- Step 1: Create the Customer table
CREATE TABLE Customer (
    CustId INT NOT NULL PRIMARY KEY,
    CustName VARCHAR(150),
    CustCode VARCHAR(20),
    CustMailId VARCHAR(30)
);

-- Step 2: Create the `Order` table with CustId as a foreign key
CREATE TABLE `Order` (
    OrderId INT NOT NULL PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustId INT NOT NULL,
    OrderAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustId) REFERENCES Customer(CustId)
        ON DELETE CASCADE -- Optional: Define the action on delete, you can adjust this
);

-- Insert records into the Customer table
INSERT INTO Customer (CustId, CustName, CustCode, CustMailId) 
VALUES 
(1, 'John Doe', 'C123', 'johndoe@example.com'),
(2, 'Jane Smith', 'C124', 'janesmith@example.com'),
(3, 'Michael Brown', 'C125', 'michaelbrown@example.com');

-- Insert records into the `Order` table
INSERT INTO `Order` (OrderId, OrderDate, CustId, OrderAmount) 
VALUES 
(101, '2024-10-10', 1, 150.75),
(102, '2024-10-11', 2, 200.50),
(103, '2024-10-12', 1, 99.99),
(104, '2024-10-13', 3, 250.00);

--------------------------------------------------------------------------------------------
-- Step 1: Create the Author table
CREATE TABLE Author (
    AuthorId INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(150) NOT NULL
);

-- Step 2: Create the Book table with a foreign key reference to the Author table
CREATE TABLE Book (
    BookId INT AUTO_INCREMENT PRIMARY KEY,
    BookTitle VARCHAR(255) NOT NULL,
    PublishedYear INT,
    AuthorId INT,
    FOREIGN KEY (AuthorId) REFERENCES Author(AuthorId)
        ON DELETE SET NULL -- Optional: Define the action on delete, you can adjust this
);

-- Insert authors into the Author table
INSERT INTO Author (AuthorName) 
VALUES 
('George Orwell'),
('Jane Austen'),
('Mark Twain');

-- Insert books into the Book table with the corresponding AuthorId
INSERT INTO Book (BookTitle, PublishedYear, AuthorId) 
VALUES 
('1984', 1949, 1),
('Animal Farm', 1945, 1),
('Pride and Prejudice', 1813, 2),
('Adventures of Huckleberry Finn', 1884, 3),
('The Adventures of Tom Sawyer', 1876, 3);

------------------------------------------------------------------------------------------------------------------
-- Step 1: Modify the Book table by removing the AuthorId column (BookMany)
CREATE TABLE BookMany (
    BookId INT AUTO_INCREMENT PRIMARY KEY,
    BookTitle VARCHAR(255) NOT NULL,
    PublishedYear INT
);

-- Author table remains the same (AuthorMany)
CREATE TABLE AuthorMany (
    AuthorId INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(150) NOT NULL
);

-- Step 3: Create the junction table AuthorBook to establish many-to-many relationship
CREATE TABLE AuthorBookMany (
    AuthorId INT,
    BookId INT,
    PRIMARY KEY (AuthorId, BookId),
    FOREIGN KEY (AuthorId) REFERENCES AuthorMany(AuthorId),
    FOREIGN KEY (BookId) REFERENCES BookMany(BookId)
);

-- Insert authors into the AuthorMany table
INSERT INTO AuthorMany (AuthorName) 
VALUES 
('George Orwell'),
('Jane Austen'),
('Mark Twain');

-- Insert books into the BookMany table
INSERT INTO BookMany (BookTitle, PublishedYear) 
VALUES 
('1984', 1949),
('Animal Farm', 1945),
('Pride and Prejudice', 1813),
('Adventures of Huckleberry Finn', 1884),
('The Adventures of Tom Sawyer', 1876);

-- Link authors to books in the AuthorBookMany junction table
INSERT INTO AuthorBookMany (AuthorId, BookId) 
VALUES 
(1, 1),  -- George Orwell wrote 1984
(1, 2),  -- George Orwell wrote Animal Farm
(2, 3),  -- Jane Austen wrote Pride and Prejudice
(3, 4),  -- Mark Twain wrote Adventures of Huckleberry Finn
(3, 5);  -- Mark Twain wrote The Adventures of Tom Sawyer