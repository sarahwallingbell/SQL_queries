# Writing SQL queries
### CS455 Principles of Database Systems <br>Homework Assignment 4 <br>October, 2019

Homework assignment summary: 
Now that you’ve gotten the raw enrollment data stored in a relational database (SQLite), you’re finally ready to conduct the analysis that the college wants. Remember that the data, though fake, is an analog to the real data in our university’s database. The queries I’m having you run are very similar to (or even the same as) the ones that we actually run when generating our reports!

Queries to perform:
[Click here for the full homework assignment.](https://davidtchiu.github.io/teaching/cs455/hwk4.dml/)
1. Get all courses being taught by the MATH department that start in the afternoon. You may assume that time is in 24hr format, and you’re reminded that you can use comparison operators (<, >) on strings.
2. Return the student, David’s, course schedule. You don’t have their student ID, but they’re the only one with that name. Only Course’s attributes should be projected.
3. Find the average GPA for each of the class ranks (freshman, sophomore, junior, senior). Rename the avg(GPA) column to ClassGPA.
4. Identify all students who have a lower GPA than the average of their respective class rank. Sort the results first by class rank, then by the student’s name.
5. Get a list of all students who are still undeclared (that is, without a major). Project only the studentID and their name. Sort results by studentID.
6. List all departments and their respective student enrollments. Sort the results in descending order of enrollment. Be careful! Make sure departments with no enrollments are also represented in your results (e.g., History)
7. Identify all valedictorians in all majors. (This is a real query that we have to run at the end of each year for the award ceremony!) For each major, find the student(s) with the highest GPA. Sort results by major. (Notice that ENGL has two students with the same GPA)
8. The runners-up in each major also receive awards! For each major, now find the student(s) with the second highest GPAs. Sort results by major. (You may not delete tuples from the database). Hint: How might the previous query help answer this one?


*Walling-Bell_HW4.sql* contains my solutions. 
