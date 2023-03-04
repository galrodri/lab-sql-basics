-- Lab SQL Basics
-- Question 1
SELECT DISTINCT *
FROM bank.client
WHERE district_id = 1
ORDER BY district_id DESC
LIMIT 5;

-- Question 2
SELECT DISTINCT *
FROM bank.client
WHERE district_id = 72
ORDER BY client_id DESC
LIMIT 1;

-- Question 3
select distinct amount 
from bank.loan
order by amount asc
limit 3;

-- Question 4
SELECT DISTINCT status
FROM bank.loan
order by status asc

-- Question 5
select distinct * 
from bank.loan
order by amount desc
limit 1;

-- Question 6
SELECT DISTINCT account_id
				, amount
FROM bank.loan
ORDER BY account_id ASC
LIMIT 5;

-- Question 7
SELECT DISTINCT account_id
				, duration
				, amount
FROM bank.loan
WHERE duration = 60
ORDER BY amount ASC
LIMIT 5;

-- Question 8
SELECT DISTINCT k_symbol
FROM bank.order

-- Question 9
SELECT DISTINCT *
FROM bank.order
WHERE account_id = 34

-- Question 10
SELECT DISTINCT *
FROM bank.order
WHERE order_id BETWEEN 29540 and 29560

-- Question 11
SELECT DISTINCT *
FROM bank.order
WHERE account_to = 30067122

-- Question 12
SELECT DISTINCT *
FROM BANK.TRANS
WHERE ACCOUNT_ID = 793
ORDER BY DATE DESC
LIMIT 10;

-- Question 13
select district_id
, count(distinct client_id) as client_count
from bank.client
where district_id < 10
group by 1
order by 1 asc;

-- Question 14
SELECT DISTINCT type
, count(distinct card_id) CARD_COUNT
FROM bank.card 
GROUP BY 1
ORDER BY CARD_COUNT DESC;

-- Question 15
select account_id
, sum(amount) as total_amount
from bank.loan
group by 1
order by total_amount desc
limit 10;

-- Question 16
select distinct date
, count(loan_id) as loans_issued
from bank.loan
where date < 930907
group by 1
order by 1 desc;

-- Question 17
select distinct date
, duration
, count(loan_id) as loans_issued
from loan
where date between 971201 and 971231
group by 1,2
having loans_issued > 0
order by 1 asc, 2 asc

-- Question 18
SELECT DISTINCT 
    account_id,
    type,
    SUM(amount) AS total_amount
FROM bank.trans
WHERE account_id = 396
GROUP BY 1,2;

-- Question 19
SELECT DISTINCT 
    account_id
    , CASE
        WHEN type = 'PRIJEM' THEN 'INCOMING'
        WHEN type = 'VYDAJ' THEN 'OUTGOING'
    END AS type
    , FLOOR(SUM(amount)) AS total_amount
FROM bank.trans
WHERE account_id = 396
GROUP BY 1,2;

-- Question 20
with t1 as (SELECT 
    account_id,
    FLOOR(SUM(CASE
                WHEN type = 'PRIJEM' THEN amount
            END)) AS incoming,
    FLOOR(SUM(CASE
                WHEN type = 'VYDAJ' THEN amount
            END)) AS outgoing
            
FROM
    trans
WHERE
    account_id = 396
GROUP BY 1)

select t1.*
, incoming - outgoing as difference
from t1;

-- Question 21
with t1 as (SELECT 
    account_id,
    FLOOR(SUM(CASE
                WHEN type = 'PRIJEM' THEN amount
            END)) AS incoming,
    FLOOR(SUM(CASE
                WHEN type = 'VYDAJ' THEN amount
            END)) AS outgoing
            
FROM
    bank.trans
GROUP BY 1)

select t1.*
, incoming - outgoing as difference
from t1
order by difference desc
limit 10;