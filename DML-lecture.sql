-- Data Manipulation Language (DML)

-- Add a row of data to a table
-- Syntax: INSERT INTO table_name(col_name_1, col_name_2, etc) VALUES (val_1, val_2, etc)

select *
from blog_user;

INSERT INTO blog_user (
    username,
    password_hash,
    email_address,
    first_name,
    last_name
) VALUES (
    'brians',
    '7$#hgsdfi8#',
    'brians@codingtemple.com',
    'Brian',
    'Stanton'
);

insert into blog_user (
	username,
    password_hash,
    email_address,
    first_name,
    last_name
) VALUES (
    'Sarahs',
    '8A#8u#$fjsf-',
    'sarahs@codingtemple.com',
    'Sarah',
    'Stodder'
);
)




select *
from blog_user;

select *
from category

-- Insert Values Only
-- Syntax: INSERT INTO table_name VALUES (val_1, val_2, etc)
-- Follows the original order that the columns were added
insert into category values (
	1, 
	'business',
	'A bunch of suits talking about boring things'
);

select *
from category;

-- Because we put in the first category with the manual entry of ID 1, the serial default did not call
-- nextval on the sequence, so it will initially throw an error if we try to insert a new category.

insert into category (
	category_name,
	description
) values(
	'Programming',
	'Cool good looking people talking about interesting things'
);

select *
from category;

-- Insert Multiple rows of data in one command
-- Syntax: INSERT INTO table_name(col_1, col_2, etc) VALUES (val_a_1, val_a_2, etc), (val_b_1, val_b_2, etc)
select *
from post;

insert into post(
	title,
	body,
	user_id
) values (
	'Hello, world',
	'This is the body of the post',
	1
),(
	'Another post',
	'This is another post',
	3
);

-- Foreign keys must have the same value (Username or ID is the same) in order to not throw an error

select *
from post;

insert into blog_user(
	username,
	password_hash,
	email_address,
	first_name,
	last_name
) values (
	'mickey',
	'y8DAS3q##fewsu',
	'mickey.mouse@disney.com',
	'Mickey',
	'Mouse'
),(
	'minnie',
	'T^Dasd7t8gaadw*',
	'minnie.mouse@disney.com',
	'Minnie',
	'Mouse'
);

select *
from blog_user;

-- To update existing data in a table
-- Syntax: UPDATE table_name SET col_1 = val_1, col_2 = val_2, etc. WHERE condition

update blog_user 
set middle_name = 'Danger'
where user_id = 1;

select *
from blog_user
order by user_id;

update blog_user 
set middle_name = 'The'
where email_address like '%disney.com';

select *
from category;

-- Alter the category table to add a color column
alter table category
add column color VARCHAR(7);

update category
set color = '#db6e14';

select *
from category;

-- Set multiple columns in one command
select *
from post;

update post
set title = 'Updated title', body = 'This is the updated body'
where post_id = 5;

-- DELETE 
-- Syntax: DELETE FROM table_name WHERE condition
-- WHERE is not required but highly recommended *without WHERE every row will be deleted. This action is irrevesible

select *
from blog_user 
order by user_id;

delete from blog_user 
where user_id >= 6;

select *
from blog_user;

-- A DELETE FROM without a WHERE will delete all rows
select *
from category;

delete from category;

select *
from post;

select *
from blog_user;

delete from blog_user 
where user_id = 3; -- Cannot delete where a foreign key is still being referenced from a table

-- To make it so that when we delete a row, it will delete any rows in related tables that reference that row:
-- we will add ON DELETE CASCADE to the foreign key constraint 

alter table post 
drop constraint post_user_id_fkey;

alter table post
add foreign key(user_id) references blog_user(user_id) on delete cascade;

select *
from blog_user;

select *
from post;

-- Types of joins (reference online resources)
-- SQL INNER JOIN between two tables
-- Syntax: SELECT foods.item_name,foods.item_unit,
-- company.company_name,company.company_city
-- FROM foods
-- 