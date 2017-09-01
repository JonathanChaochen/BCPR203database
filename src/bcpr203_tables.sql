/* purge database bcpr203 */
-- drop database bcpr203;
Create database bcpr203;
use bcpr203;

drop table  if exists Patient;
Create table Patient
(
id		integer primary key,
first_name	varchar(30),
last_name	varchar(30),
nhi		varchar(80),
dob		date,
gender varchar(6)
) engine = innodb;

Create table Department
(
id		integer primary key,
dept_name	varchar(40)
) engine = innodb;

Create table Surgeon
(
id		integer primary key,
first_name	varchar(30),
last_name	varchar(30),
dept_id integer,
Foreign key (dept_id) references Department (id)
) engine = innodb;

drop table  if exists ReferralPerson;
Create table ReferralPerson
(
id		integer primary key,
first_name	varchar(30),
last_name	varchar(30),
referred_from varchar(20)
) engine = innodb;

drop table  if exists Appointment;
Create table Appointment
(
patient_id	integer,
referral_date date,
surgeon_id	integer,
refper_id	integer,
add_waitlist_date date,
fsa_date date,
hte enum('Yes', 'No'),
primary key(patient_id, referral_date, surgeon_id),
Foreign key (patient_id) references Patient (id),
Foreign key (surgeon_id) references Surgeon (id),
Foreign key (refper_id) references ReferralPerson (id)
) engine = innodb;

Select * from Patient;
-- Load another external file
load data local infile '/Users/chenchao/Desktop/moodle/2017semester2/BCPR203/Design Assignment/BCPR203_ASS1_ChaoChen/table/Patient.csv'
into table Patient
fields terminated by ','
lines terminated by '\r\n'
(id, first_name,last_name,nhi,
  dob, gender);

Select * from Department;
-- Load another external file
load data local infile '/Users/chenchao/Desktop/moodle/2017semester2/BCPR203/Design Assignment/BCPR203_ASS1_ChaoChen/table/Department.csv'
into table Department
fields terminated by ','
lines terminated by '\r\n'
(id, dept_name);

Select * from Surgeon;
-- Load another external file
load data local infile '/Users/chenchao/Desktop/moodle/2017semester2/BCPR203/Design Assignment/BCPR203_ASS1_ChaoChen/table/Surgeon.csv'
into table Surgeon
fields terminated by ','
lines terminated by '\r\n'
(id, first_name,last_name, dept_id);


Select * from ReferralPerson;
-- Load another external file
load data local infile '/Users/chenchao/Desktop/moodle/2017semester2/BCPR203/Design Assignment/BCPR203_ASS1_ChaoChen/table/ReferralPerson.csv'
into table ReferralPerson
fields terminated by ','
lines terminated by '\r\n'
(id, first_name,last_name, referred_from);

Select * from Appointment;
-- Load another external file
load data local infile '/Users/chenchao/Desktop/moodle/2017semester2/BCPR203/Design Assignment/BCPR203_ASS1_ChaoChen/table/Appointment.csv'
into table Appointment
fields terminated by ','
lines terminated by '\r\n'
(patient_id, referral_date,surgeon_id, refper_id, add_waitlist_date, fsa_date, hte);

-- extra field 1
select  DATEDIFF(fsa_date, referral_date) as 'days' from Appointment; 

-- extra field 2
select  DATEDIFF(curdate(), dob) as 'days' from patient;

select  A.referral_date, R.id, R.first_name, R.last_name, S.id, S.first_name, S.last_name, P.id,P.nhi, P.first_name, P.last_name, D.id, D.dept_name
from Appointment A
inner join ReferralPerson R on A.refper_id = R.id
inner join Surgeon S on A.surgeon_id = S.id
inner join Patient P on A.patient_id = P.id
inner join Department D on D.id = S.dept_id
Order by p.id; 

