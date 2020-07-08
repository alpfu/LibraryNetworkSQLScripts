# list all copies inserted database with some informations
select c.copy_id, c.statusOfBook, l.library_id, u.name as university, k.name as city 
from copy c join library l on c.fk_library_id = l.library_id 
join university u on l.fk_university_id = u.university_id 
join city k on u.fk_city_id = k.city_id
group by(l.library_id);

# list all processes 
select * from process;

# list all students with their informations
select p.ssn, p.name, p.surname, p.age, c.name as bornCity, u.name as universityName, s.department
from person p join student s on p.ssn = s.fk_ssn 
join city c on p.fk_city_id = c.city_id
join university u on  s.fk_university_id = u.university_id
order by(p.ssn);

# list universities with the average age of all students 
select u.name as universityName, avg(age) as avgAgeOfStudents
from person p, student s, university u 
where s.fk_university_id = u.university_id and p.ssn = s.fk_ssn
group by u.name;

# people and numbers who has more than one telephone number
select ssn, name, surname, telNumber 
from tel, person
where fk_ssn = ssn and ssn not in (select fk_ssn from tel group by(fk_ssn) having count(fk_ssn) < 2);