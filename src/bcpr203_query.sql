use bcpr203;

-- extra field 1 days waiting from Referral
select  DATEDIFF(fsa_date, referral_date) as 'days' from Appointment; 

-- extra field 2  age
select p.id, concat(p.first_name, '', p.last_name) Patient, floor(DATEDIFF(referral_date, dob)/365.25) as 'age' 
from Appointment a
inner	 JOIN Patient p  on a.patient_id = p.id
Order BY p.id;

-- Query1
select count(distinct patient_id) 
from  Appointment a 
where a.hte = 'Yes' ;


-- Query2
select  d.dept_name as 'department', floor(avg(DATEDIFF(fsa_date, referral_date))) as 'days' 
from Appointment a
inner join Surgeon  s on s.id = a.surgeon_id
inner join Department  d on d.id = s.dept_id
where fsa_date is not null and a.hte = 'Yes'
Group by s.dept_id; 

-- Query3
select concat(s.first_name,' ',s.last_name) Surgeon,concat(p.first_name,' ',p.last_name) Patient, datediff(a.fsa_Date,a.referral_date) as Days 
from appointment a,Surgeon s,patient p
where a.surgeon_id=s.id 
and a.patient_id=p.id 
and a.hte='Yes'
order by a.surgeon_id;

-- Query4  under 18 need to be seen by Paediatric Surgery
select p.id, concat(p.first_name, p.last_name) Patient, floor(DATEDIFF(referral_date, dob)/365.25) as 'age', d.dept_name
from Patient p 
inner join Appointment a on a.patient_id = p.id
inner join Surgeon  s on s.id = a.surgeon_id
inner join Department  d on d.id = s.dept_id
where floor(DATEDIFF(referral_date, dob)/365.25) between 0 and 18 
and d.dept_name <> 'Paediatric Surgery'
and a.hte = 'Yes'
order by Patient;

-- Query5  percentage of patient whith the target of 80 days by department

select T1.Department, T1.Count/T2.Count as Persentage
from
(select d.dept_name Department, count(DATEDIFF(fsa_date, referral_date))  as Count 
from Appointment a
inner join patient p on a.patient_id = p.id
inner join Surgeon  s on s.id = a.surgeon_id
inner join Department  d on d.id = s.dept_id
where DATEDIFF(fsa_date, referral_date) <= 80
group by d.id
) T1,
(select d.dept_name Department, count(DATEDIFF(fsa_date, referral_date)) as Count 
from Appointment a
inner join patient p on a.patient_id = p.id
inner join Surgeon  s on s.id = a.surgeon_id
inner join Department  d on d.id = s.dept_id
group by d.id
) T2
where T1.Department = T2.Department
order by T1.Department;

