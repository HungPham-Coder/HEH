-- alter sequence role_roleid_seq restart with 4

insert into "role" (rolename)
values ('Admin'),
values ('Member'),
values ('Physiotherapist'),
values ('Manager');


insert into deposit (userID, deposit)
values (1, 0),
values (2, 0),
values (3, 0),
values (4, 0);

insert into users (roldid,depositid,firstname,lastname,phone,dob,gender,address,email,"password",bookingstatus,banstatus)
values (1,1,'Khang','Nguyen','0367302912','2000-07-15','Male','Go Vap','Khang@gmail.com','123456789',0,0),
values (2,2,'Hung','Nguyen','0254784745','2000-05-30','Male','District 9','Hung@gmail.com','123456789',0,0),
values (3,3,'Long','Nguyen','0214547874','2000-03-10','Male','District 9','Long@gmail.com','123456789',0,0),
values (4,4,'Thien','Nguyen','0154787457','2000-05-10','Male','District 9','Thien@gmail.com','123456789',0,0);



-- delete from role where rolename = 'Physiotherapist';