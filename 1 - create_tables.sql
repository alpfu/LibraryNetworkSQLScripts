create table tel(
telNumber varchar(20) not null primary key
);

create table person(
ssn int not null primary key,
age int not null, 
name varchar(20) not null,
surname varchar(20) not null,
gender enum("M", "F") not null check (gender in ("M", "F"))
);

create table city(
city_id int not null primary key,
name varchar(20) not null,
population int not null
);

create table university(
university_id int not null primary key,
name varchar(20) not null unique,
numberOfStudents int not null
);

create table library(
library_id int not null primary key,
capacity int not null,
numberOfBooks int not null
);

create table book(
isbn int not null primary key,
name varchar(20) not null
);

create table writer(
writer_id int not null primary key,
numberOfBooks int not null
);

create table student(
student_id int not null,
department varchar(20) not null
);

create table regular(
yearOfStudy int not null
);

create table exchange(
durationOfStay int not null check (durationOfStay < 10)
);

create table copy( # insert into copy (copy_id, fk_library_id, fk_isbn) values
copy_id int not null,
statusOfBook char(1) not null default "+" check(statusOfBook in ("+", "-"))
);