--Add nationality to table employee
ALTER TABLE employee 
ADD COLUMN nationality VARCHAR(255);
--Select Age Group (i.e., "Under Age" for employees under 18 and "Over Age" for employees over 60)
SELECT 
  e.full_name,
  e.gender,
  e.date_of_birth,
  c.company_name,
  c.contact_email,
  c.phone_number AS company_phone_number,
  CASE 
    WHEN DATE_PART('year', AGE(e.date_of_birth)) < 18 THEN 'Under Age'
    WHEN DATE_PART('year', AGE(e.date_of_birth)) > 60 THEN 'Over Age'
    ELSE 'Adult'
  END AS age_group
FROM employee e
JOIN company c ON e.company_id = c.id;

-- Insert company data
INSERT INTO company (company_name, contact_email, phone_number, address, industry_type, license_number)
VALUES 
('东方科技有限公司', 'info@dongfangtech.com', '+86 10 1234 5678', '北京市朝阳区科技路10号', 'Technology', 'CN12345678');

--Insert data into quotation table

INSERT INTO quotation (company_id, insurance_broker_id, date_issued, proposed_premium, sum_insured, coverage_details, quotation_status, acceptance_date)
VALUES
  (3, '2025-01-03', 300.00, 10000.00, 'Personal Accident Coverage (Accident, Disability, Death)', 'Pending', NULL);


--Insert data into employee table

INSERT INTO employee (company_id,staff_id, full_name, date_of_birth, gender, phone_number, email, nationality)
VALUES
  (6, 'EMS051','王伟(Wang Wei)', '1985-03-15', 'Male', '+86 139 1234 5678', 'wang.wei@dongfangtech.com', 'Chinese'),
  (6, 'EMS52','李娜(Li Na)', '1990-07-10', 'Female', '+86 139 2345 6789', 'li.na@dongfangtech.com', 'Chinese'),
  (6, 'EMS53','张强(Zhang Qiang)', '1992-09-30', 'Male', '+86 139 3456 7890', 'zhang.qiang@dongfangtech.com', 'Chinese'),
  (6, 'EMS54','刘洋(Liv Yang)', '1988-11-25', 'Female', '+86 139 4567 8901', 'liu.yang@dongfangtech.com', 'Chinese'),
  (6, 'EMS55','陈刚(Chen Gang)', '1987-05-12', 'Male', '+86 139 5678 9012', 'chen.gang@dongfangtech.com', 'Chineses');

--Ensure a foreign key relationship (if not already set)
ALTER TABLE insured_coverage
DROP COLUMN date_of_birth;
--Quotation is approved
SELECT 
    COUNT(ip.id) AS total_policies,
    SUM(q.proposed_premium) AS total_proposed_premium
FROM insurance_policy ip
JOIN quotation q ON ip.quotation_id = q.id
WHERE q.quotation_status = 'approved';




SELECT 
    COUNT(DISTINCT ic.insurance_policy_id) AS total_insured,
    SUM( ip.coverage_amount) AS total_sum_insured
FROM insured_coverage ic
JOIN insurance_policy_benefit ip ON ic.insurance_policy_id = ip.id;
--Condition: is_partner_hf
SELECT 
    COUNT(*) AS total_hf_partners,
    (SELECT COUNT(*) FROM health_facility WHERE is_partner_hf = FALSE) AS total_non_partners
FROM health_facility 
WHERE is_partner_hf = TRUE;


SELECT 
    (SELECT COUNT(DISTINCT e.id) 
     FROM employee e
     LEFT JOIN insured_coverage ic ON e.id = ic.id
     WHERE ic.id IS NULL) AS total_prospect,

    (SELECT COUNT(DISTINCT c.id)
     FROM company c
     JOIN insurance_policy ip ON c.id = ip.company_id
     JOIN quotation q ON ip.quotation_id = q.id
     WHERE q.quotation_status <> 'accepted') AS prospect;

--Request 5:
--1. total propose premium
     SELECT 
  COUNT(*) AS total_policies,
  SUM(proposed_premium) AS total_proposed_premium
  FROM quotation;
--1.Total policy
SELECT 
  COUNT(*) AS total_policied
  FROM insurance_policy;
--2.Total insured, total sum-insured

select sum(coverage_amount) as total_sum_insured
from insured_coverage cov
join insurance_policy_benefit ben on cov.insurance_policy_id=ben.insurance_policy_id

--3.Total prospect, number of prospect campany
 SELECT 
     COUNT(e.id) - COUNT(ic.id) AS total_prospect
     FROM employee e
    LEFT JOIN insured_coverage ic ON e.id = ic.employee_id
  `;
--4.Total HF partner, number of not partner
SELECT
COUNT(*) - COUNT(CASE WHEN is_partner_hf = TRUE THEN 1 END)AS total_hf_partners,
COUNT(*) - COUNT(CASE WHEN is_partner_hf = FALSE THEN 1 END) AS total_non_partner
FROM health_facility;

--Request 6:
--Please add 3 new partnership health facilities as following:
INSERT INTO health_facility (health_facility_name,is_partner_hf,phone_number,location,email)
 VALUES
 ('Preah Ang Duong Hospital','true','+855 23 218 875',' No. 118, Preah Norodom Blvd (41), corner of Kramuon Sar (St. 114), 12203 Phnom Penh','A\N'),
 ('Chamkar Morn Referral Hospital','true','+855 12 551 254','Chamkar Dong (St. 217), Khva Village, 12401 Phnom Penh','A/N'),
 ('Teuk Thla Health Center','true',' +855 12 927 052',' Confederation de la Russie Blvd (110), 12102 Phnom Penh','A\N');
--And 2 health facilities that will do partnerships soon as following:
 INSERT INTO health_facility (health_facility_name,is_partner_hf,phone_number,location,email)
 VALUES
('Chamkar Dong Health Center','false','+855 12 551 254',' Chamkar Dong (St. 217), Khva Village, 12401 Phnom Penh','A\N'),
('Prek Phneou Health Center','false','+855 12 449 570','No. 140, St. 364, 12308 Phnom Penh','A\N');


--Request 7
ALTER TABLE health_facility
ALTER COLUMN phone_number TYPE text;
--Request 8
--Pending quotation, maximum premium [2pt]

SELECT count(id) from quotation 
    where quotation_status = 'Pending';

 SELECT
    MAX(proposed_premium) AS max_premium
    FROM quotation q
    WHERE q.quotation_status = 'Pending';

--Approved quotation, number of company [2pt]
SELECT
COUNT(DISTINCT c.id) AS approved_quotation_company
FROM quotation q
JOIN company c ON q.company_id = c.id
WHERE q.quotation_status = 'Approved';



