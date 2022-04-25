
PRAGMA foreign_keys = ON;

-- Delete the tables if they already exist
drop table if exists Enroll;
drop table if exists Major;
drop table if exists Course;
drop table if exists Student;
drop table if exists Dept;
drop table if exists student_log;

-- Create the schema for our tables
create TABLE Dept(
        deptID TEXT CHECK(length(deptID) < 5) PRIMARY KEY,
        deptName TEXT NOT NULL UNIQUE,
        building TEXT
);
create TABLE Student(
        studentID INTEGER PRIMARY KEY,
        studentName TEXT NOT NULL,
        class TEXT CHECK(class = 'Freshman' or class = 'Sophomore' or class = 'Junior' or class = 'Senior'),
        gpa REAL CHECK(0 <= gpa AND gpa <= 4)
);
create TABLE Major(
        StudentID INTEGER,
        major TEXT,
        PRIMARY KEY(studentID, major),
        FOREIGN KEY(studentID) REFERENCES student(studentID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        FOREIGN KEY(major) REFERENCES Dept(deptID)
                ON UPDATE CASCADE
                ON DELETE SET NULL
);
create TABLE Course(
        CourseNum INTEGER,
        deptID TEXT CHECK(length(deptID) < 5),
        CourseName TEXT,
        Location TEXT,
        meetDay TEXT,
        meetTime TEXT CHECK(meetTime >= '07:00' and meetTime < '17:00'),
        PRIMARY KEY(CourseNum,deptID),
        FOREIGN KEY(deptID) REFERENCES Dept(deptID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);
create TABLE Enroll(
        CourseNum INTEGER,
        deptID TEXT CHECK(length(deptID) < 5),
        StudentID INTEGER,
        PRIMARY KEY(CourseNum,deptID,StudentID),
        FOREIGN KEY(deptID,CourseNum) REFERENCES Course(deptID,CourseNum)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        FOREIGN KEY(studentID) REFERENCES Student(studentID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);
create table student_log(
        activity TEXT CHECK(activity = 'insert' or activity = 'update' or activity = 'delete'),
        time_ TEXT,
        oldStudentName TEXT,
        newStudentName TEXT,
        oldStudentID INTEGER,
        newStudentID INTEGER,
        oldClass TEXT CHECK (oldClass = 'Freshman' or oldClass = 'Sophomore' or oldClass = 'Junior' or oldClass = 'Senior'),
        newClass TEXT CHECK (newClass = 'Freshman' or newClass = 'Sophomore' or newClass = 'Junior' or newClass = 'Senior'),
        oldGPA REAL CHECK (0 <= oldGPA AND oldGPA <= 4),
        newGPA REAL CHECK (0 <= newGPA AND newGPA <= 4)
);

CREATE TRIGGER insert_student
AFTER INSERT ON Student
BEGIN
 INSERT INTO student_log
 VALUES ('insert', date('now'), NULL, NEW.studentName, NULL, NEW.studentID,
         NULL, NEW.class, NULL, NEW.gpa);
END;

CREATE TRIGGER update_student
AFTER UPDATE ON Student
BEGIN
 INSERT INTO student_log
 VALUES ('update', date('now'), OLD.studentName, NEW.studentName, OLD.studentID, NEW.studentID,
         OLD.class, NEW.class, OLD.gpa, NEW.gpa);
END;

CREATE TRIGGER delete_student
AFTER DELETE ON Student
BEGIN
 INSERT INTO student_log
 VALUES ('delete', date('now'), OLD.studentName, NULL, OLD.studentID, NULL,
         OLD.class, NULL, OLD.gpa, NULL);
END;
