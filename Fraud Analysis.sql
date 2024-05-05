create database FraudAnalytics;
show tables;
select*from transactions;

select*from card_holder;
select*from credit_card;
select*from merchant;
select*from merchant_category;
select*from transactions;

# View of Top 100 highest transactions during early hours (7:00 to 9:00 AM)
create view early_hour_transactions_view as
select * from transactions
where hour(date) >= 7 and hour(date) < 9
order by  amount desc;
select *from early_hour_transactions_view limit 10;

# Transactions that are less than $2.00 per cardholder
select card, count(*) as number_of_small_transactions
from transactions
where  amount < 2.00
group by card
order by number_of_small_transactions desc;

# top five merchants prone to being hacked using small transactions
select m.name as merchant_name ,count(*) as num_small_transactions
from transactions t
join merchant m on t.id_merchant = m.id
where t.amount < 2.00
group by  m.name	
order by num_small_transactions desc
limit 5;
select*from merchant;
select*from merchant_category;
select*from transactions;

# multiple cards associated with a single cardholder (more than 2 cards)
select id_card_holder, count(distinct card) as num_cards
from credit_card
group by id_card_holder
having count(distinct card) > 2;

# transaction amount is greater than the average transaction amount
select *
from transactions
where amount > (select avg(amount) from
 transactions);
 
 

