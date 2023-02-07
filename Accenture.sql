CREATE DATABASE Accenture;

USE Accenture;
Show Tables;

/*1. In the school, one teacher might be teaching more than one class. Write a query to dentify how many classes each teacher is taking.*/
 Select teacher_id, Count(*) from teacher_allocation group by teacher_id;

/*2.It is interesting for teachers to come across students who share similar names as theirs. John is one of the teachers who finds it fascinating and wants to find out how many students in each class have names similar to his. Write a query to help him find this data.*/ 
select class_id, count(student_name) as no_of_johns
from student
where student_name like "%John%" 
group by class_id;


/*3.Create a roll number column after sorting the data by fullname*/
SELECT student_name, class_id, (SELECT Count(*) from Student as s2 
						where s1.student_Name > s2.student_Name and s1.class_id = s2.class_id)+1 as UniqueRollNo
FROM Student as S1 
Order By 3;
------------
select row_number() over (partition by class_id order by student_name) as roll_no,student_id, student_name
from student;

/*4.*/
 SELECT class_id, sum(IF(gender = "M", 1, 0))/ sum(IF(gender="F",1,0)) as BoysVsGirls 
FROM Student
Group By Class_ID;

/*5.*/
Select avg(year(date()) - year(date_of_joining)) 
From teacher;

/*6.*/ 
SELECT st.student_id,student_name, exam_name, exam_subject, marks, marks/total_marks as MarksVsTotalMarks
FROM student st, exam_paper ept, exam et
WHERE st.student_id = ept.student_id and ept.exam_id = et.exam_id
order by 1, 2, 3;

/*7.*/ 
SELECT st.student_id, et.exam_id, 
Format("Percent",marks/total_marks) as performance 
FROM student st, exam_paper ept, exam et
WHERE st.student_id = ept.student_id and
ept.exam_id = et.exam_id 
and st.student_id IN (1,4,9,16,25) and exam_name = "Quarterly"
order by 1, 2, 3;

/*8.*/ 
SELECT ct.class_id, st.student_id,
dense_rank() over (partition by class_id order by sum(marks) DESC) as DRank  
FROM student st, exam_paper ept, exam et, class ct
WHERE ct.class_id = st.class_id and st.student_id = ept.student_id and ept.exam_id = et.exam_id and exam_name = "Half-yearly"
Group By ct.class_id, st.student_id 
order by 1, 3 DESC;