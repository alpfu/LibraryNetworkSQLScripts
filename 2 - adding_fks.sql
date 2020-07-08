alter table book add fk_writer_id int not null;
alter table book add foreign key (fk_writer_id) references writer(writer_id) on delete cascade on update cascade; # written by

alter table tel add fk_ssn int not null;
alter table tel add foreign key (fk_ssn) references person(ssn) on delete cascade on update cascade; # has

alter table person add fk_city_id int not null; # born in
alter table person add foreign key (fk_city_id) references city(city_id) on update cascade;

alter table student add fk_university_id int not null;	# registered
alter table student add foreign key (fk_university_id) references university(university_id) on update cascade;
alter table student add unique(student_id, fk_university_id);

alter table copy add fk_library_id int; # in library can be null because the cardinality is (0, 1)
alter table copy add foreign key (fk_library_id) references library(library_id) on delete set null on update cascade;

alter table copy add fk_isbn int not null; # copy of book
alter table copy add foreign key (fk_isbn) references book(isbn) on delete cascade on update cascade;
alter table copy add unique(copy_id, fk_isbn);

alter table library add fk_university_id int not null; # library in university
alter table library add foreign key (fk_university_id) references university(university_id) on delete cascade on update cascade;

alter table university add fk_city_id int not null; # site
alter table university add foreign key (fk_city_id) references city(city_id) on update cascade;

alter table writer add fk_ssn int not null; # writer isa person
alter table writer add foreign key (fk_ssn) references person(ssn) on delete cascade on update cascade;

alter table student add fk_ssn int not null; # student isa person
alter table student add foreign key (fk_ssn) references person(ssn) on delete cascade on update cascade;

alter table regular add fk_student_id int not null; # regular isa student
alter table regular add fk_university_id int not null;
alter table regular add foreign key (fk_student_id, fk_university_id) references student(student_id, fk_university_id) on delete cascade on update cascade;

alter table exchange add fk_university_id int not null; # exchange isa student
alter table exchange add fk_student_id int not null;
alter table exchange add foreign key (fk_student_id, fk_university_id) references student(student_id, fk_university_id) on delete cascade on update cascade;

create table process( # process... !!!!!!!! don't insert any process_id and isSucceed !!!!!!!!
# insert into process (typeOfProcess, dateOfProcess, fk_ssn, fk_student_id, fk_university_id, fk_isbn, fk_copy_id) values
process_id int auto_increment primary key,
isSucceed char(1) not null default "+" check (isSucceed in ("+", "-")),
typeOfProcess enum("B", "R") not null check (typeOfProcess in ("B", "R")),
dateOfProcess date not null,
fk_ssn int not null,
fk_student_id int not null,
fk_university_id int not null,
fk_isbn int not null,
fk_copy_id int not null,
foreign key (fk_ssn) references person(ssn) on update cascade on delete no action,
foreign key (fk_student_id, fk_university_id) references student(student_id, fk_university_id) on update cascade on delete no action,
#foreign key (fk_copy_id, fk_isbn) references copy(copy_id, fk_isbn) on update cascade on delete no action,
foreign key (fk_isbn) references book(isbn) on update cascade on delete no action
);