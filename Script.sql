-- insert into person (first_name,last_name,gender,date_of_birth) 
-- 	values ('Ha', 'Nguyen', 'FEMALE',DATE '2000-05-30') , ('Linh', 'Nguyen', 'FEMALE',DATE '2000-06-10') 
-- 	, ( 'Dung', 'Nguyen', 'MALE',DATE '2000-01-05'), ('Uyen', 'Nguyen', 'FEMALE',DATE '2000-06-03');
	
-- drop table users

create database heh;
create table ROLE (
	roleID BIGSERIAL NOT NULL PRIMARY KEY,
	roleName varchar (20) not null 
);
create table deposit (
	depositID BIGSERIAL NOT NULL PRIMARY KEY,
	deposit FLOAT not null
);
create table USERS (
	userID BIGSERIAL NOT NULL PRIMARY KEY,
	roldID bigint references role (roleID),
	depositID bigint references deposit (depositID),
	firstName varchar (50) not null,
	lastName varchar (50) not null,
	gender varchar (10) not null,
	phone varchar (50) not null,
	dob date not null,
	address varchar (50),
	email varchar (50),
	password varchar (50) not null,
	bookingStatus bool not null,
	banStatus bool not null
);
create table EXERCISE (
	exerciseID BIGSERIAL NOT NULL PRIMARY KEY,
	exerciseName varchar (50) not null,
	exerciseTimePerWeek int not null,
	flag bool,
	status bool
);
create table UsersExercise (
	exerciseID bigint references EXERCISE(exerciseID),
	userID bigint references USERS (userID)
);
create table Category (
	categoryID bigserial not null primary key, 
	categoryName varchar (50) not null,
	description varchar (100) 
);
create table ExerciseDetail (
	exerciseDetailID bigserial not null primary key,
	exerciseID bigint references EXERCISE (exerciseID),
	categoryID bigint references Category (categoryID),
	exerciseTimePerSet time,
	description varchar (100)
);
create table Video (
	videoID bigserial not null primary key,
	videoURL varchar (255)
);
create table Image (
	imageID bigserial not null primary key,
	imageURL varchar (255)
);
create table ExerciseVideo(
	videoID bigint references Video(videoID),
	exerciseDetailID bigint references ExerciseDetail(exerciseDetailID)
);
create table ExerciseImage (
	imageID bigint references Image (imageID),
	exerciseDetailID bigint references ExerciseDetail(exerciseDetailID)
);
create table FreeDay (
	freeDayID bigserial not null primary key ,
	freeDate date not null,
	timeStart time not null,
	timeEnd time not null
);
create table PhysioTherapistDetail (
	physioTherapistID bigserial not null primary key,
	userID bigint references USERS (userID) ,
	specialize varchar (100) not null,
	skill varchar (100),
	schedulingStatus int,
	scheduleStatus int,
	workingStatus int 
);
create table FreePhysioSchedule (
	freeScheduleID bigserial not null primary key,
	freeDayID bigint references FreeDay (freeDayID),
	physiotherapistID bigint references PhysioTherapistDetail (physioTherapistID),
	description varchar (100)
);



create table TotalSchedule (
	totalScheduleID bigserial not null primary key,
	physioTherapistID bigint references PhysioTherapistDetail (physioTherapistID),
	freeScheduleID bigint references FreePhysioSchedule (freeScheduleID),
	userID bigint references USERS (userID),
	timeStart time not null,
	timeEnd time not null,
	duaration int
);
create table ExerciseFeedback (
	exerciseFeedbackID bigserial not null primary key,
	physiotherapistID bigint references PhysioTherapistDetail (physioTherapistID),
	exerciseID bigint references EXERCISE (exerciseID),
	feedbackContent varchar (200)
);
create table ScheduleType (
	scheduleTypeID bigserial not null primary key,
	typeOfName varchar (50) not null,
	description varchar (100) 
);
create table TypeOfFee (
	typeIfFeeID bigserial not null primary key,
	serviceCharge varchar (50)
);
create table Fee (
	feeID bigserial not null primary key ,
	typeIfFeeID bigint references TypeOfFee (typeIfFeeID),
	fee float 
);
create table ScheduleDetail (
	scheduleDetailID bigserial not null primary key,
	exerciseID bigint references EXERCISE (exerciseID),
	totalScheduleID bigint references TotalSchedule (totalScheduleID),
	scheduleTypeID bigint references ScheduleType (scheduleTypeID),
	feeID bigint references Fee(feeID)
);
create table Feedback (
	feedbackID bigserial not null primary key,
	userID bigint references USERS (userID),
	scheduleDetailID bigint references ScheduleDetail(scheduleDetailID),
	comment varchar (100),
	ratingStar int 
);

create table Payment (
	paymentID varchar (20),
	scheduleDetailID bigint references ScheduleDetail(scheduleDetailID),
	totalPrice float 
);

-- alter table Users rename fullname to firstName;
-- alter table Users add lastName varchar (50);
-- alter table Users add gender varchar (10);
