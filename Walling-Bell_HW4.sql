-- Sarah Walling-Bell
-- Oct 16, 2019
-- CS 455
-- Homework 4: Writing SQL Queries

-- Q1: Selects all courses from the Math department taught in the afternoon.
select *
from Course
where deptID = 'MATH' and meetTime >= '12:00';

-- Q2: Selects Davids course schedule (given that there is only one David in
-- the school).
with davidID as (select studentID
						from Student
						where studentName = 'David'),
	   davidEnrolls as (select CourseNum, deptID
							   from Enroll
							   where studentID in davidID)
select *
from Course
where (CourseNum, deptID) in davidEnrolls;

-- Q3: Retrieves the average GPA of each class.
select class, avg(gpa) as ClassGPA
from Student
group by class;

-- Q4: Identifies all students who have a lower GPA than the average for
-- their class.
with avgGPAs as (select class, avg(gpa) as ClassGPA
						  from Student
						  group by class)

select *
from Student natural join avgGPAs
where gpa < ClassGPA
order by class, studentName;

-- Q5: Returns a list of students who are still undeclared (major-wise).
select studentID, studentName
from Student left outer natural join major
where major is NULL
order by studentID;

-- Q6: Returns the number of students enrolled in each department.
select deptName, count (studentID) as enrolled
from Dept left outer natural join Enroll
group by deptName
order by enrolled desc;

-- Q7: Identifies the valedictorian(s) for each major.
with topMajorGPAs as (select major, max(gpa) as gpa
								 from Student natural join major
								 group by major)
select *
from student natural join major
where  (major, gpa) in topMajorGPAs
order by major;

-- Q8: Identifies the saluditorian(s) for each major.
with topGPAs as (select major, max(gpa) as topGPA
										from student natural join major
										group by major),
		secondGPAs as (select major, max(gpa) as secondGPA
									 from student natural join major
									 where (major, gpa) not in topGPAs
									 group by major)
select *
from student natural join major
where  (major, gpa) in secondGPAs
order by major;

-- Q9: Returns the names, IDs, and the number of courses students taking the
-- most number of courses are taking.
with studentCourses as (select studentID, count(studentID) as courseCount
								   from Enroll
								   group by studentID),
	   maxCourses as (select max(courseCount) as numCourses
							   from (studentCourses))
select studentID, studentName, numCourses
from studentCourses, maxCourses natural join Student
where courseCount in maxCourses;

-- Q10: Increases all Computer Science major's gpas by 1.0, up to a maximum gpa
-- of 4.0.
begin TRANSACTION;
update Student set gpa = (4.0) where (1.0 + gpa) > 4.0;
update Student set gpa = (1.0 + gpa) where gpa < 4.0;
commit;

-- Q11: Insert Philosphy department (PHIL, located in Plato's Cave) that offers
-- the course PHIL 101: Ethics located inthe CAVE at 16:00 on TR. Enroll all
-- Computer Science students in the Ethics course.
begin TRANSACTION;
insert into Dept values ('PHIL', 'Philosophy', "Plato's Cave");
insert into Course values (101, 'PHIL', 'Ethics', 'CAVE', 'TR', '16:00');
insert into Enroll select 101 as CourseNum, 'PHIL' as deptID, studentID from student natural join major where major='CSCI';
COMMIT;
