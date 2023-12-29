-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE
);

-- Create Tasks table
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    UserID INT,
    Status VARCHAR(20) DEFAULT 'To-Do',
    Deadline DATE,
    CONSTRAINT fk_user FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Insert sample data into Users table
INSERT INTO Users (UserID, UserName, Email) VALUES
(1, 'JohnDoe', 'john.doe@email.com'),
(2, 'JaneSmith', 'jane.smith@email.com');

-- Insert sample data into Tasks table
INSERT INTO Tasks (TaskID, Title, Description, UserID, Deadline) VALUES
(101, 'Complete Project Proposal', 'Write a proposal for the new project.', 1, '2023-01-10'),
(102, 'Review Code Changes', 'Review and provide feedback on recent code changes.', 2, '2023-01-15'),
(103, 'Prepare Presentation', 'Prepare slides for the team meeting.', 1, NULL);

-- Sample Queries
-- 1. List all tasks with their assigned users
SELECT Tasks.Title, Users.UserName
FROM Tasks
JOIN Users ON Tasks.UserID = Users.UserID;

-- 2. Find tasks with a specific status
SELECT Title, Status
FROM Tasks
WHERE Status = 'To-Do';

-- 3. Count the number of tasks assigned to each user
SELECT Users.UserName, COUNT(Tasks.TaskID) AS TaskCount
FROM Users
LEFT JOIN Tasks ON Users.UserID = Tasks.UserID
GROUP BY Users.UserName;

-- 4. Find tasks with a deadline before a specific date
SELECT Title, Deadline
FROM Tasks
WHERE Deadline < '2023-01-12';

-- 5. Update the status of a specific task
UPDATE Tasks
SET Status = 'In Progress'
WHERE TaskID = 101;

-- 6. List tasks assigned to a specific user with a specific status
SELECT Title, Status
FROM Tasks
WHERE UserID = 1 AND Status = 'To-Do';

-- 7. Delete a specific task
DELETE FROM Tasks
WHERE TaskID = 102;

-- 8. Find users who have not been assigned any tasks
SELECT UserName
FROM Users
LEFT JOIN Tasks ON Users.UserID = Tasks.UserID
WHERE Tasks.TaskID IS NULL;

-- 9. List tasks without a deadline
SELECT Title
FROM Tasks
WHERE Deadline IS NULL;

-- 10. Count the number of tasks in each status category
SELECT Status, COUNT(TaskID) AS TaskCount
FROM Tasks
GROUP BY Status;
