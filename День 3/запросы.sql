USE WebEducationDB;
GO


SELECT UserID, UserName, Email, CreatedAt
FROM Users
WHERE UserRole = 'Student';



SELECT CourseID, Title, Price
FROM Courses
WHERE Price > 4000.00
ORDER BY Price DESC;



SELECT 
    L.LessonID,
    C.Title AS CourseTitle,
    L.Title AS LessonTitle
FROM Lessons L
INNER JOIN Courses C ON L.CourseID = C.CourseID;



SELECT 
    C.CourseID,
    C.Title AS CourseTitle,
    COUNT(E.EnrollmentID) AS TotalStudents
FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseID, C.Title
ORDER BY TotalStudents DESC;


SELECT 
    E.EnrollmentID,
    U.UserName AS StudentName,
    C.Title AS CourseTitle,
    C.Price
FROM Enrollments E
INNER JOIN Users U ON E.UserID = U.UserID
INNER JOIN Courses C ON E.CourseID = C.CourseID
WHERE E.IsPaid = 1;



SELECT 
    U.UserID,
    U.UserName,
    U.Email,
    C.Title AS UnpaidCourse
FROM Enrollments E
INNER JOIN Users U ON E.UserID = U.UserID
INNER JOIN Courses C ON E.CourseID = C.CourseID
WHERE E.IsPaid = 0;



SELECT 
    L.LessonID,
    L.Title AS LessonTitle,
    COUNT(Com.CommentID) AS CommentsCount
FROM Lessons L
LEFT JOIN Comments Com ON L.LessonID = Com.LessonID
GROUP BY L.LessonID, L.Title;



SELECT CourseID, Title, Description, Price
FROM Courses
WHERE Price = (SELECT MAX(Price) FROM Courses);



SELECT 
    SUM(C.Price) AS TotalRevenue,
    COUNT(E.EnrollmentID) AS TotalSalesCount
FROM Enrollments E
INNER JOIN Courses C ON E.CourseID = C.CourseID
WHERE E.IsPaid = 1;



SELECT 
    U.UserID,
    U.UserName,
    U.UserRole,
    COUNT(E.EnrollmentID) AS EnrolledCoursesCount
FROM Users U
LEFT JOIN Enrollments E ON U.UserID = E.UserID
GROUP BY U.UserID, U.UserName, U.UserRole
ORDER BY EnrolledCoursesCount DESC;
GO