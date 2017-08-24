/* purge database bcpr203 */
-- drop database bcpr203;
Create database bcpr203;
use bcpr203;

-- drop table Patient;
-- drop table if exists Participant;
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

Create table ReferralPerson
(
id		integer primary key,
first_name	varchar(30),
last_name	varchar(30)
) engine = innodb;

Create table Appointment
(
patient_id	integer,
referral_date date,
surgeon_id	integer,
refper_id	integer,
fsa_date date,
hte enum('Yes', 'No'),
primary key(patient_id, referral_date, surgeon_id),
Foreign key (patient_id) references Patient (id),
Foreign key (surgeon_id) references Surgeon (id),
Foreign key (refper_id) references ReferralPerson (id)
) engine = innodb;
