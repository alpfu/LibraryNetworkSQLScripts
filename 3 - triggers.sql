delimiter $$
create trigger borrow_return before insert on process
for each row
begin

set @tr_typeOfProcess := new.typeOfProcess;
set @tr_copy_id := new.fk_copy_id;
set @tr_isbn := new.fk_isbn;
set @tr_university_id := new.fk_university_id; # student university id 

set @tr_status_copy := (select statusOfBook from copy where (copy_id, fk_isbn) = (@tr_copy_id, @tr_isbn));
# university id of copy
set @tr_uni_id_copy := (select fk_university_id
						 from library
						 where library_id = (select fk_library_id
											 from copy
											 where (copy_id, fk_isbn) = (@tr_copy_id, @tr_isbn)));


if @tr_typeOfProcess = "R" then 
 update copy set statusOfBook = "+" where (copy_id, fk_isbn) = (@tr_copy_id, @tr_isbn);
elseif @tr_typeOfProcess = "B" AND @tr_status_copy = "+" AND @tr_university_id = @tr_uni_id_copy then 
 update copy set statusOfBook = "-" where (copy_id, fk_isbn) = (@tr_copy_id, @tr_isbn);
else
 set new.isSucceed = "-";
end if;
end$$

create trigger isRegular before insert on exchange
for each row
begin
set @tr_ssn := (select ssn	# ssn of inserting value
				from person 
				where ssn = (select fk_ssn 
							 from student 
                             where (student_id, fk_university_id) = (new.fk_student_id, new.fk_university_id)));
                                                                     

if (@tr_ssn in  (select ssn
				from person 
				where ssn = (select fk_ssn 
							 from student 
                             where (student_id, fk_university_id) = (select fk_student_id, fk_university_id
																	 from regular
                                                                     where (fk_student_id, fk_university_id) = (new.fk_student_id, new.fk_university_id)))))

then 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'inserted data is already regular';
end if;																												
end$$

create trigger isExchange before insert on regular
for each row
begin
set @tr_ssn := (select ssn	# ssn of inserting value 
				from person 
				where ssn = (select fk_ssn 
							 from student 
                             where (student_id, fk_university_id) = (new.fk_student_id, new.fk_university_id)));
                                                                     

if (@tr_ssn in  (select ssn
				from person 
				where ssn = (select fk_ssn 
							 from student 
                             where (student_id, fk_university_id) = (select fk_student_id, fk_university_id
																	 from exchange
                                                                     where (fk_student_id, fk_university_id) = (new.fk_student_id, new.fk_university_id)))))

then 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'inserted data is already exchange'; 
end if;																												
end$$
delimiter ;