DROP database if exists Transit;
CREATE DATABASE IF NOT EXISTS Transit;

USE Transit;

create table trains (
	trainID int primary key
);

create table stations (
	stationID int primary key,
    name varchar(25),
    state char(2),
    city varchar(20)
);

create table trainSchedule (
	scheduleID int primary key,
    line_name varchar(20),
    fare real,
    departure_time datetime,
    arrival_time datetime,
    travel_time time,
    originates_in int,
    destination int,
    foreign key (originates_in) references stations(stationID),
    foreign key (destination) references stations(StationID)
);

create table follow (
	trainID int,
    scheduleID int,
    primary key (trainID, scheduleID),
    foreign key (trainID) references trains(trainID),
    foreign key (scheduleID) references trainSchedule(scheduleID)
);


create table stops_at (
	scheduleID int,
    stationID int,
    arrival_time datetime,
    departure_time datetime,
    primary key (scheduleID, stationID),
    foreign key (scheduleID) references trainSchedule(scheduleID),
    foreign key (stationID) references stations(stationID)
);

create table reservations (
	reservation_number int primary key,
    date date,
    total_fare real,
    board int,
    depart int,
    foreign key (board) references stations(stationID),
    foreign key (depart) references stations(stationID)
);
 
 create table reservation_for (
	scheduleID int,
    reservation_number int,
    primary key (scheduleID, reservation_number),
    foreign key (scheduleID) references trainSchedule(scheduleID),
    foreign key (reservation_number) references reservations(reservation_number)
);

create table customers (
	username varchar(16) primary key,
    password varchar(16),
    first_name varchar(16),
    last_name varchar(16),
    email varchar(30),
    age int
);

create table employees (
	username varchar(16) primary key,
    password varchar(16),
    first_name varchar(16),
    last_name varchar(16),
    ssn char(11),
    role varchar(11)
);

insert into employees values
('jayp1', 'yellow4', 'Jay', 'Phansalkar', '123-45-6789', 'CustomerRep'), 
('Bobby2', 'blue6', 'Robert', 'Stevens', '234-45-6789', 'CustomerRep'), 
('ryan11', 'ninety42', 'Ryan', 'Jackson', '678-98-2234', 'CustomerRep'),
('Na53', 'scoobydoo', 'Nathan', 'Silva', '247-54-6789', 'Admin'),
('SKy77', 'pot90', 'Sang', 'Kim', '923-45-0892', 'Admin');

create table messages (
	username_customer varchar(16),
    username_rep varchar(16),
    primary key (username_customer, username_rep),
    foreign key (username_customer) references employees(username),
    foreign key (username_rep) references employees(username)
);

    
    