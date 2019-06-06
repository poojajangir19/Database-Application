/*1. Display description of all the crime alert notifications that have been sent to Urban type neighborhood.*/
select Alert_Description 
from Crime_Alerts c 
inner join Notification n 
on c.Alert_ID=n.Alert_ID 
inner join Neighbourhood o 
on n.Neighbourhood_ID = o.Neighbourhood_ID 
where o.Neighborhood_Type = 'Urban'

 
/*2. Display all the crime information such as type of crime, number of suspects, and number of victims that were reported 
in the Chicago city along with the names of the users who reported it*/
Select c.FirstName,u.LastName,c.Type,c.WeaponsUsed,c.Suspects_Description,c.NumberOfSuspects,c.NumberOfVictims 
from Users u inner join Report r 
on u.User_ID = r.User_ID 
inner join Crime c 
on c.Crime_ID = r.Crime_ID 
where c.Incident_City = 'Chicago'

 

/*3. Display the status of the cases related to crimes occurred in the month of September and the names of the Police officers’ who are managing the case?*/

select c.Case_ID, P_FirstName, P_LastName,C.Status from Police p 
inner join Cases c on p.Police_ID = c.Police_ID 
inner join Crime r on r.Crime_ID = c.Crime_ID
where r.Month = 'September'

 
/*4. Display names of all the users who have registered to receive Crime_Alerts through ‘Email’?*/

select distinct u.User_ID,u.FirstName,u.LastName,r.Register_Type from Users u 
inner join Register r on u.User_ID = r.User_ID
inner join Crime_Alerts a on r.Alert_ID = r.Alert_ID
where r.Register_Type = 'Email'
 
/*5. Display the names of the users to whom the crime alerts could not be delivered.*/
 
select distinct t.Alert_ID, u.User_ID,u.EmailID,u.IpAddress, u.FirstName,u.LastName, t.DeliveryStatus 
from Users u 
inner join Report r 
on u.User_ID = r.User_ID
inner join Track t 
on t.Crime_ID = r.Crime_ID
where t.DeliveryStatus = 'Not-sent'

 

/*6. Display the total number of police officers who are working as Police Technicians from the department location ‘Alaska’*/

select count(p.Police_ID) as TotalPoliceOfficers
from Police P
inner join Department d 
on p.Department_ID = d.Department_ID
inner join Dept_Location l
on d.Department_ID = l.Department_ID
inner join Location a
on l.Location_ID = a.Location_ID
where p.Designation = 'Police technician' and a.State = 'Alaska' 
 

/*7. Display the names of the police who have designation of a ‘Police officer’ and work for department similar to ‘Health’ in the city ‘Helena’*/

select p.Police_ID,p.P_FirstName,p.P_LastName,d.Department_Name as TotalPoliceOfficers from Police P
inner join Department d 
on p.Department_ID = d.Department_ID
inner join Dept_Location l 
on l.Department_ID = d.Department_ID
inner join Location n
on n.Location_ID = l.Location_ID
where p.Designation = 'Police officer' and d.department_name LIKE '%Health%' and n.city ='Helena'
 
/*8.  Display the names of all the employees who operate from 8 AM until 5 PM*/

select E_FirstName,E_LastName 
from Employee 
where Employee_ID IN 
(select Employee_ID 
From Operate 
where WorkFrom = '8:00:00 AM'
and WorkUntill = '5:00:00 PM')

/*9.  Display name, sex, and description of the criminals who were involved in crime in the year 2017 and whose case status is ‘pending’ in the ascending order of the Crime_ID*/

select c.Crime_ID,m.Criminal_ID,m.FirstName,m.LastName,m.Sex,m.C_Description, c.Date,c.Month,c.Year,a.Status
from Crime c
inner join Cases a 
on c.Crime_ID = a.Crime_ID
inner join Criminal m 
on m.Criminal_ID = a.Criminal_ID 
where c.Year = '2017' and a.status = 'Pending'
order by Crime_ID asc

 

/*10.  Display names of all the employees who are operating on sending alerts related to crime occurred in State ‘Illinois’*/

select distinct c.Crime_ID, e.E_FirstName,e.E_LastName,c.Incident_State
from Employee e
inner join Operate o
on e.Employee_ID = o.Employee_ID
inner join Track t
on t.Alert_ID = o.Alert_ID
inner join Crime c
on t.Crime_ID = c.Crime_ID
where c.Incident_State = 'Illinois'

/*11.Display Date in Date format, No of suspects , delivery status and criminal first and last name for the crime types robbery which occurred only  in cities DeKalb, Chicago*/
select distinct CONCAT (C.Date,'/',C.Month,'/',C.Year) As New_Date,A.No_of_suspects,T.DeliveryStatus,R.FirstName,R.LastName
from Crime_Alerts A inner join Track T on A.Alert_ID=T.Alert_ID
inner join Crime c on T.Crime_ID=C.Crime_ID
inner join Cases S on C.Crime_ID=S.Crime_ID
inner join Criminal R on S.Criminal_ID=R.Criminal_ID
where C.Type ='Robbery'  and T.DeliveryStatus ='Sent'and  C.Incident_City in ('Dekalb', 'chicago') ;

 
/*12. Display alert description for all the shootings occurred in chicago city between the year 2017 and 2018, no. of suspects reported in the crime and the address details of 
all the urban neighborhood type to which the notifications were sent. */ 
select A.alert_description,A.No_of_Suspects,T.deliveryStatus, concat(D.ApartmentNumber,D.StreetName,D.StreetNumber,D.City,D.ZIpcode) AS Addressdetails
from Crime C inner join Track T on C.Crime_ID=T.Crime_ID
inner join Crime_Alerts A on A.Alert_ID= T.Alert_ID
inner join Notification F on F.Alert_ID=A.Alert_ID
inner join Neighbourhood N on N.Neighbourhood_ID=F.Neighbourhood_ID 
inner join Address D on D.Address_ID=N.Address_ID
where C.type='Shooting' and C.Incident_City='Chicago' and year between 2017 and 2018 ;

 

/*13. Display  suspect’s description, crime type, incident city, status of the crime done by the criminal Ivan crime handled police name and his/her department names */
 
select C.Suspects_Description, C.type, C.Incident_City, S.Status,P_FirstName,D.Department_Name
from Crime C inner join Cases S on C.Crime_ID= S.Crime_ID
inner join Criminal R on S.Criminal_ID=R.Criminal_ID
inner join Police P on S.Police_ID=P.Police_ID
inner join Department D on D.Department_ID=P.Department_ID
where R.FirstName='Ivan'  and C.type='Robbery' and C.Incident_State='illinois';

 

/*14. Display all distinct crime ids in ascending order, Crime incidents  occurred in Ohio state , case statuses which are pending and that are reported by public users*/

select distinct U.UserType,C.Crime_ID,C.Incident_State,S.status
from Users U inner join Report R on U.User_ID=R.User_ID
inner join Crime C on R.Crime_ID=C.Crime_ID
inner join cases S on C.Crime_ID=S.Crime_ID
where  C.Incident_State='Ohio' and U.UserType='Public' and S.status='Pending'

 

/*15. Display count of assault crimes and neighborhood type in ascending order which have safety level 2 */

Select count(C.type) As NoofCrimes , N.Neighborhood_Type
from Crime C inner join Track T  on C.Crime_ID=T.Crime_ID
inner join Crime_Alerts A on A.Alert_ID=T.Alert_ID
inner join Notification F on A.Alert_ID=F.Alert_ID
inner join Neighbourhood N on F.Neighbourhood_ID=N.Neighbourhood_ID
where C.type='Assault' and A.SafetyLevel='2'
group by C.Type, N.Neighborhood_Type

 
/*16) Display the distinct department ids and name of the department that have solved cases with number of victims less than 2*/
select distinct d.Department_ID,d.Department_Name
from Department d, Police p, Cases c, Crime e
where d.Department_ID=p.Department_ID and p.Police_ID=c.Police_ID and c.Crime_ID=e.Crime_ID
group by d.Department_ID, p.Police_ID,c.Case_ID,e.Crime_ID,d.Department_Name
having min(e.NumberOfVictims)<2;

/*17)Display name of the criminal, suspect description and the weapon used for the crime who is Juvenile(Age <20)*/
Select CONCAT(d.FirstName, d.LastName) as CriminalName,c.Suspects_Description, c.WeaponsUsed
from Crime c, Criminal d, Cases e
where c.Crime_ID=e.Crime_ID and e.Criminal_ID=d.Criminal_ID and d.Age<20 ;

/*18) Display distinct first name, last name, address and user type who is a female and reported a robbery crime and the case status is solved.*/
Select distinct u.FirstName, u.LastName, u.Address, u.UserType
from Users u , Report r, Crime c, Cases e
where u.Gender='Female'and u.User_ID= r.User_ID and r.Crime_ID=c.Crime_ID and c.Crime_ID=e.Crime_ID and c.Type='Robbery'
and e.Status='Solved';

 
/*19) Display the alert id, alert description and time of crime occurred in the Street named Gateway*/
select ca.Alert_ID, ca.Alert_Description, c.Time
from Crime_Alerts ca, Track t, Crime c
where  c.Crime_ID= t.Crime_ID and t.Alert_ID=ca.Alert_ID and c.Incident_Street='Gateway';
 
/*20) Display the Top 5 Criminal ID, First Name , Last Name and the Number of Crimes committed by them in Descending order.*/
select distinct TOP 5 s.Criminal_ID, r.FirstName,r.LastName, count(c.Crime_ID) as NumberOFCrimes
from Criminal r, crime c, Cases s
where r.Criminal_ID=s.Criminal_ID and s.Crime_ID=c.Crime_ID
group by c.Crime_ID, r.FirstName, r.LastName,s.Criminal_ID
order by NumberOfCrimes desc;
