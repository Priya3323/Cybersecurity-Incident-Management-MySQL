CREATE DATABASE cybersecurity_analytics;
USE cybersecurity_analytics;
SHOW DATABASES;
show tables;
SELECT * FROM organizations LIMIT 5;
SELECT * FROM users LIMIT 5;
SELECT * FROM systems LIMIT 5;
SELECT * FROM login_logs LIMIT 5;
SELECT * FROM network_events LIMIT 5;
SELECT * FROM security_incidents LIMIT 5;
SELECT * FROM incident_systems LIMIT 5;
USE cybersecurity_analytics;

DESCRIBE organizations;
DESCRIBE users;
DESCRIBE systems;
DESCRIBE login_logs;
DESCRIBE network_events;
DESCRIBE security_incidents;
DESCRIBE incident_systems;
SELECT COUNT(*) FROM organizations;
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM systems;
SELECT COUNT(*) FROM login_logs;
SELECT COUNT(*) FROM network_events;
SELECT COUNT(*) FROM security_incidents;
SELECT COUNT(*) FROM incident_systems;
ALTER TABLE organizations
MODIFY org_id VARCHAR(20),
MODIFY industry VARCHAR(100),
MODIFY country VARCHAR(100);

ALTER TABLE users
MODIFY user_id VARCHAR(20),
MODIFY org_id VARCHAR(20),
MODIFY role VARCHAR(100);

ALTER TABLE systems
MODIFY system_id VARCHAR(20),
MODIFY org_id VARCHAR(20),
MODIFY os_type VARCHAR(50),
MODIFY criticality VARCHAR(20);

UPDATE login_logs
SET login_time = DATE_FORMAT(
    STR_TO_DATE(login_time, '%d-%m-%Y'),
    '%Y-%m-%d'
);
SELECT
    login_time,
    STR_TO_DATE(login_time, '%d-%m-%Y') AS converted_date
FROM login_logs
LIMIT 10;
ALTER TABLE login_logs
ADD COLUMN login_date DATE;

UPDATE login_logs
SET login_date = STR_TO_DATE(login_time, '%d-%m-%Y');

SELECT login_time
FROM login_logs
LIMIT 10;

SELECT login_time, login_date
FROM login_logs
LIMIT 10;

UPDATE login_logs
SET login_date = CAST(login_time AS DATE);

SELECT login_time, login_date
FROM login_logs
LIMIT 10;

ALTER TABLE login_logs
DROP COLUMN login_time;
ALTER TABLE login_logs
CHANGE login_date login_time DATE;
DESCRIBE login_logs;
ALTER TABLE login_logs
MODIFY login_id VARCHAR(20),
MODIFY user_id VARCHAR(20),
MODIFY ip_address VARCHAR(45),
MODIFY status VARCHAR(20);

ALTER TABLE network_events
ADD COLUMN event_date DATE;
SELECT timestamp, STR_TO_DATE(timestamp, '%Y-%m-%d') AS converted_date
FROM network_events
LIMIT 5;
UPDATE network_events
SET event_date = STR_TO_DATE(timestamp, '%Y-%m-%d');
SELECT timestamp
FROM network_events
LIMIT 5;
UPDATE network_events
SET event_date = STR_TO_DATE(timestamp, '%d-%m-%Y');
SELECT timestamp, event_date
FROM network_events
LIMIT 5;
ALTER TABLE network_events
DROP COLUMN timestamp;
ALTER TABLE network_events
CHANGE event_date timestamp DATE;
ALTER TABLE network_events
MODIFY event_id VARCHAR(20),
MODIFY system_id VARCHAR(20),
MODIFY event_type VARCHAR(50),
MODIFY severity VARCHAR(20);
DESCRIBE network_events;

SELECT incident_id, org_id, incident_type, discovered_date, severity
FROM security_incidents
LIMIT 5;
ALTER TABLE security_incidents
ADD COLUMN incident_date DATE;
UPDATE security_incidents
SET incident_date = STR_TO_DATE(discovered_date, '%d-%m-%Y');
SELECT discovered_date, incident_date
FROM security_incidents
LIMIT 5;
ALTER TABLE security_incidents
DROP COLUMN discovered_date;
ALTER TABLE security_incidents
CHANGE incident_date discovered_date DATE;
ALTER TABLE security_incidents
MODIFY incident_id VARCHAR(20),
MODIFY org_id VARCHAR(20),
MODIFY incident_type VARCHAR(50),
MODIFY severity VARCHAR(20);

ALTER TABLE incident_systems
MODIFY incident_id VARCHAR(20),
MODIFY system_id VARCHAR(20);

SELECT COUNT(*)
FROM users u
LEFT JOIN organizations o
    ON u.org_id = o.org_id
WHERE o.org_id IS NULL;

SELECT COUNT(*) AS orphan_users
FROM users u
LEFT JOIN organizations o
    ON u.org_id = o.org_id
WHERE o.org_id IS NULL;

SELECT COUNT(*) AS orphan_systems
FROM systems s
LEFT JOIN organizations o
    ON s.org_id = o.org_id
WHERE o.org_id IS NULL;

SELECT COUNT(*) AS orphan_logins
FROM login_logs l
LEFT JOIN users u
    ON l.user_id = u.user_id
WHERE u.user_id IS NULL;

SELECT COUNT(*) AS orphan_events
FROM network_events n
LEFT JOIN systems s
    ON n.system_id = s.system_id
WHERE s.system_id IS NULL;

SELECT COUNT(*) AS orphan_incidents
FROM incident_systems ins
LEFT JOIN security_incidents si
    ON ins.incident_id = si.incident_id
WHERE si.incident_id IS NULL;

SELECT COUNT(*) AS orphan_incident_systems
FROM incident_systems ins
LEFT JOIN systems s
    ON ins.system_id = s.system_id
WHERE s.system_id IS NULL;

SELECT org_id, COUNT(*) AS cnt
FROM organizations
GROUP BY org_id
HAVING COUNT(*) > 1;

SELECT user_id, COUNT(*) AS cnt
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;
SELECT system_id, COUNT(*) AS cnt
FROM systems
GROUP BY system_id
HAVING COUNT(*) > 1;
SELECT login_id, COUNT(*) AS cnt
FROM login_logs
GROUP BY login_id
HAVING COUNT(*) > 1;
SELECT event_id, COUNT(*) AS cnt
FROM network_events
GROUP BY event_id
HAVING COUNT(*) > 1;
SELECT incident_id, COUNT(*) AS cnt
FROM security_incidents
GROUP BY incident_id
HAVING COUNT(*) > 1;
SELECT incident_id, system_id, COUNT(*) AS cnt
FROM incident_systems
GROUP BY incident_id, system_id
HAVING COUNT(*) > 1;

ALTER TABLE organizations
ADD PRIMARY KEY (org_id);

ALTER TABLE users
ADD PRIMARY KEY (user_id);

ALTER TABLE systems
ADD PRIMARY KEY (system_id);

ALTER TABLE login_logs
ADD PRIMARY KEY (login_id);

ALTER TABLE network_events
ADD PRIMARY KEY (event_id);

ALTER TABLE security_incidents
ADD PRIMARY KEY (incident_id);

ALTER TABLE incident_systems
ADD PRIMARY KEY (incident_id, system_id); 
#For incident_systems, use a composite primary key because the same incident can involve multiple systems

ALTER TABLE users
ADD CONSTRAINT fk_users_org
FOREIGN KEY (org_id)
REFERENCES organizations(org_id);

ALTER TABLE systems
ADD CONSTRAINT fk_systems_org
FOREIGN KEY (org_id)
REFERENCES organizations(org_id);

ALTER TABLE login_logs
ADD CONSTRAINT fk_login_user
FOREIGN KEY (user_id)
REFERENCES users(user_id);

ALTER TABLE network_events
ADD CONSTRAINT fk_network_system
FOREIGN KEY (system_id)
REFERENCES systems(system_id);

ALTER TABLE incident_systems
ADD CONSTRAINT fk_incident
FOREIGN KEY (incident_id)
REFERENCES security_incidents(incident_id);

ALTER TABLE incident_systems
ADD CONSTRAINT fk_incident_system
FOREIGN KEY (system_id)
REFERENCES systems(system_id);


#How many records are present in the users table?
select count(*) from users;

# Q2 How many records are present in the security_incidents table?
select count(*) from security_incidents;

# Q3 Display all columns and the first 10 records from the security_incidents table.
select*from security_incidents limit 10;

#Q4 Display the structure of the network_events table, including its column names and data types.
desc network_events;

# Q5 Find the total number of records in each of the 7 tables in the cybersecurity database.
select 'organizations' as table_name, count(*) as total_records from organizations
union all
select 'users' as table_name, count(*) as total_records from users
union all
select 'security_incidents' as table_name, count(*) as total_records from security_incidents
union all
select 'network_events' as table_name, count(*) as total_records from network_events
union all
select 'login_logs' as table_name, count(*) as total_records from login_logs
union all
select 'incident_systems' as table_name, count(*) as total_records from incident_systems
union all
select 'systems' as table_name, count(*) as total_records from systems;


# Q6. Find the total number of users in each organization.
select*from users;
select*from organizations;
select*from security_incidents;
select*from network_events;

select org_id, count(user_id) as total_users from users group by org_id;

#Q7.Find the number of security incidents for each organization.
select org_id, count(incident_id) as total_security_incidents from security_incidents group by org_id;

#Q8.Find the number of security incidents for each severity level.
select severity, count(incident_id) as total_incidents from security_incidents group by severity;

#Q9. Find the number of security incidents discovered in each year.
select year(discovered_date) as Year_Number, count(incident_id) as total_incidents from security_incidents
group by Year_Number;

#Q10. Find the top 5 organizations with the highest number of security incidents.
select org_id, count(incident_id) as total_incidents from security_incidents group by org_id order by total_incidents desc limit 5;


#Q11 Find the number of network events for each event type.
select event_type, count(event_id) as Total_network_events from network_events group by event_type;


#Q12 Find the number of login attempts for each login status (successful/failed).
select*from login_logs;
select status, count(login_id) as login_attempts from login_logs group by status;

# Q13 Find the number of failed login attempts for each user.
select user_id, count(status) as failed_login_attempts from login_logs where status = 'Failed' group by user_id;

# Q14 Find the organizations that have more than 10 security incidents.
select org_id, count(incident_id) as total_incidents from security_incidents group by org_id having total_incidents >10;

#Q15. Find the earliest and latest security incident date in the database.
select min(discovered_date) as earliest_incident_date, max(discovered_date) as latest_incident_date from security_incidents;

#Q16. Display each user's user_id, role, and the industry of their organization.
select user_id, role, industry from users u
left join organizations o on u.org_id=o.org_id;

#Q17. Display each security incident along with the industry of the organization where it occurred.
select s.incident_id, s.incident_type, o.industry from security_incidents s
left join organizations o on s.org_id = o.org_id;

#Q18: Display each user along with the security incident type associated with their organization.
select u.user_id, u.org_id, s.incident_type from users u left join
security_incidents s on s.org_id = u.org_id;

#Q19. Display each network event along with the industry of the organization associated with that event.
select n.event_id, n.event_type, o.org_id, o.industry from network_events n
left join systems s on n.system_id = s.system_id
left join organizations o on o.org_id = s.org_id;

#Q20. Display each login record along with the user's role.
select l.login_id, l.status, u.role from login_logs l
left join users u on l.user_id = u.user_id;

#Q21. Display each security incident along with the systems involved in that incident.
select v.incident_id, v.incident_type, s.system_id, s.os_type from security_incidents v
left join incident_systems I on v.incident_id = I.incident_id
left join systems s on s.system_id =I.system_id;

#Q22. Display each system along with the organization that owns it.
select*from organizations;
select*from systems;
select*from security_incidents;
select*from incident_systems;
select*from login_logs;

select system_id, o.org_id, os_type from systems s left join organizations o on s.org_id = o.org_id;


#Q23. Find the total number of security incidents for each organization and display the organization ID along with the total incident count.

select o.org_id, count(incident_id) as Total_security_Incidents from organizations o join
security_incidents s on o.org_id = s.org_id group by o.org_id order by Total_security_Incidents desc; 

#Q24. Find the total number of failed login attempts for each organization.
select o.org_id, o.industry, count(l.status) as total_failed_counts from organizations o
join users u using(org_id) join login_logs l using(user_id) where l.status = "Failed" group by o.org_id, o.industry;

#Q25. Find the total number of successful login attempts for each organization.
select o.org_id, o.industry, count(l.status) as total_success_count from organizations o join
users u using(org_id) join login_logs l using(user_id) where l.status = "Success" group by o.org_id, o.industry;

#Q26. Find the total number of security incidents for each severity level, and display the severity along with the incident count.
select s.severity, count(s.incident_id) as total_incident_count from security_incidents s group by s.severity;

#Q27. Find the percentage of total security incidents represented by each severity level.
select*from security_incidents;
select s.severity, count(s.incident_id)/(select count(incident_id) from security_incidents)*100 as Security_incidents_percentage from security_incidents s group by s.severity;

#Q28. Find the number of security incidents for each combination of incident type and severity level.
select severity, incident_type, count(incident_id) as Security_incident_count from security_incidents group by severity, incident_type;

#Q29. Find the organization with the highest number of high-severity security incidents.
select org_id, count(incident_id) as Number_of_incidents from security_incidents where severity = "High" group by org_id order by
Number_of_incidents desc limit 1;

#Q30. Find the percentage of high-severity incidents out of the total number of security incidents.
select severity, count(incident_id)/(select count(incident_id) from security_incidents)*100 as High_severity_percentage from security_incidents 
where severity = "High";

#Q31. Find the number of security incidents for each organization and severity level.
select org_id, count(incident_id) as Counts, severity from security_incidents group by org_id, severity;

#Q32. Find the organization that has the highest number of critical severity incidents.
select org_id, severity, count(incident_id) as total_count from security_incidents where severity = "Critical" group by org_id
order by total_count desc limit 1;

#Q33. Find the percentage of Critical-severity incidents out of the total number of security incidents.
select severity, count(incident_id)/(select count(incident_id) from security_incidents)*100 as Critical_severity_percentage from 
security_incidents where severity = 'Critical';

#Q34. Find the most common incident type among Critical-severity incidents.
select incident_type, count(incident_id) as total_number, severity from security_incidents where severity = "Critical" group by 
incident_type order by total_number desc limit 1;

#Q35. Find the percentage of Critical incidents for each incident type.
select incident_type, count(incident_id)/(select count(incident_id) from security_incidents where severity = 'Critical')*100 as Critical_incidents_percentage
from security_incidents where severity = "Critical" group by incident_type;

#Q36: Find the total number of systems owned by each organization.
select*from systems;
select org_id, count(system_id) as total_systems from systems group by org_id;

#Q37. Find the number of systems for each operating system type (os_type).
select os_type, count(system_id) as total_systems from systems group by os_type;

# Q38. Find the operating system type with the highest number of systems.
with system_table as (select os_type, count(system_id) as system_count from systems group by os_type)
select os_type, system_count from system_table order by system_count desc limit 1;

# Q39. Find the organizations that have more than 10 systems.
with System_new as (select org_id, count(system_id) as system_count from systems group by org_id)
select org_id, system_count from System_new where system_count > 10;

# Q40. Find the average number of systems owned by each organization.
with system_new as (select org_id, count(system_id) as average_systems from systems group by org_id)
select avg(average_systems) as Average_count from system_new;

# Q41. Find the total number of systems involved in each security incident.
select*from incident_systems;
select*from security_incidents;
select s.incident_id, count(I.system_id) as system_count from security_incidents s join
incident_systems I using(incident_id) group by s.incident_id;

# Q42. Find the total number of security incidents associated with each system.
select I.system_id, count(s.incident_id) as incidents_count from incident_systems I join
security_incidents s using(incident_id) group by I.system_id;

# Q43. Find the number of systems involved in Critical-severity incidents.
select count(I.system_id) as Number_of_system from security_incidents s join
incident_systems I using(incident_id) where s.severity = "Critical";

# Q44. Find the organizations that have security incidents involving more than 5 systems.
select s.org_id, count(i.system_id) as system_count from security_incidents s join incident_systems i using(incident_id) group by 
s.org_id having system_count > 5;

# Q45. Find the system associated with the highest number of security incidents.
select i.system_id, count(s.incident_id) as Incident_count from incident_systems i join 
security_incidents s using(incident_id) group by i.system_id order by Incident_count desc limit 1;

# Q46. Find the number of network events for each system.
select*from network_events;
select*from systems;
select system_id, count(event_id) as Event_count from network_events group by system_id;

# Q47. Find the number of network events for each organization.
select s.org_id, count(e.event_id) as Event_count from systems s join network_events e using(system_id) group by s.org_id;

# Q48. Find the number of network events for each event type and organization.
select s.org_id, n.event_type, count(n.event_id) as Event_count from network_events n join
systems s using (system_id) group by s.org_id, n.event_type;

# Q49. Find the system that has the highest number of network events.
select system_id, count(event_id) as Event_count from network_events group by system_id 
order by Event_count desc limit 1;

# Q50. Find the organizations that have more network events than the average number of network events per organization.
with average_count as (select s.org_id, count(n.event_id) as event_count from network_events n join systems s using(system_id) 
group by s.org_id)
select org_id, event_count from average_count where event_count > (select avg(event_count) from average_count);

# Q51. Find the total number of login attempts for each user.
select*from login_logs;
select user_id, count(login_id) as Attempts from login_logs group by user_id;

# Q52. Find the number of successful login attempts for each user.
select user_id, count(login_id) as login_attempts from login_logs where status = "Success" group by user_id;

# Q53. Find the number of failed login attempts for each organization.
select u.org_id, count(l.login_id) as login_attempts from login_logs l join 
users u using(user_id)
 where status = "Failed" group by u.org_id;
select*from login_logs;

# Q54. Find the users who have more failed login attempts than successful login attempts.
select user_id, 
count(case when status = "Failed" then login_id end) as Failed_count,
count(case when status = "Success" then login_id end) as Success_count
from login_logs group by user_id having Failed_count > Success_count;

# Q55. Find the organization with the highest number of failed login attempts.
select u.org_id, count(l.status) as attempt_count from login_logs l join users u using(user_id) where status = 'Failed' 
group by u.org_id order by attempt_count desc limit 1;

# Q56. Find the total number of users for each role.
select*from users;
select role, count(user_id) as users_COUNT from users group by role;

# Q57. Find the number of users for each role in each organization.
select org_id, role, count(*) as user_count from users group by org_id, role;

# Q58. Find the organization having the highest number of users.
select org_id, count(*) as users_count from users group by org_id order by users_count desc limit 1;

# Q59. Find the role with the highest number of users in each organization.
select role, org_id, count(user_id) as count_user from users group by role, org_id order by count_user desc limit 1;

# Q60. Find organizations that have more users than the average number of users per organization.


# Q61. Find the total number of systems, users, and security incidents for each organization.
# Q62. Find the total number of successful and failed login attempts for each organization.
# Q63. Find the total number of network events and security incidents for each organization.
# Q64. Find organizations that have both Critical security incidents and failed login attempts.
# Q65. Find the organization with the highest number of security incidents and display its industry.

# Q66. Find organizations whose number of security incidents is greater than the average number of incidents across all organizations.
# Q67. Find the users who have made more login attempts than the average number of login attempts per user.
# Q68. Rank organizations based on their total number of security incidents using a window function.
# Q69. Rank incident types based on their total number of incidents using a window function.
# Q70. Find the percentage contribution of each organization's security incidents to the total security incidents using a window function.

# Q71. Find the organization with the highest number of Critical incidents and display its industry.
# Q72. Find the most common security incident type in the database.
# Q73. Find the operating system type associated with the highest number of systems.
# Q74. Find the organization with the highest number of network events and display its industry.
# Q75. Find the organization with the highest number of failed login attempts and display its industry.