/* main schema */
drop table if exists standing_order_fragment_versions;
drop table if exists standing_order_fragments;
drop table if exists adoption_dates;

create table adoption_dates (
	id int not null,
	date date not null,
	primary key (id)
);
create table standing_order_fragments (
	id int not null,
	primary key (id)
);
create table standing_order_fragment_versions (
	id int not null,
	text varchar(2000) not null,
	adopted_on date not null,
	current_number varchar(10) not null,
	standing_order_number varchar(5),
	standing_order_number_in_list int,
	standing_order_letter_in_list char(1),
	fragment_number_in_list int,
	root_number int not null,
	reference int not null,
	year int not null,
	adoption_date_id int,
	standing_order_fragment_id int,
	constraint fk_adoption_date foreign key (adoption_date_id) references adoption_dates(id),
	constraint fk_standing_order_fragment foreign key (standing_order_fragment_id) references standing_order_fragments(id),
	primary key (id)
);