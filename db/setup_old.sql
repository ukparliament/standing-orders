/* main schema */
drop table if exists edges;
drop table if exists nodes;
drop table if exists standing_order_fragment_versions;
drop table if exists standing_order_fragments;
drop table if exists adoption_dates;
drop table if exists standing_order_fragment_version_texts;

create table standing_order_fragment_version_texts (
	id serial,
	text varchar(2000) not null,
	downcase_text varchar(2000) not null,
	primary key (id)
);
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
	is_edit boolean default false,
	adoption_date_id int,
	standing_order_fragment_id int,
	standing_order_fragment_version_text_id int,
	constraint fk_adoption_date foreign key (adoption_date_id) references adoption_dates(id),
	constraint fk_standing_order_fragment foreign key (standing_order_fragment_id) references standing_order_fragments(id),
	constraint fk_standing_order_fragment_version_text foreign key (standing_order_fragment_version_text_id) references standing_order_fragment_version_texts(id),
	primary key (id)
);

create table nodes (
	id int not null,
	standing_order_fragment_version_id int,
	label varchar(2000) not null,
	primary key (id)
);

create table edges (
	id serial,
	from_standing_order_fragment_version_id int not null,
	from_node int not null,
	to_standing_order_fragment_version_id int,
	to_node int not null,
	weight int not null,
	primary key (id)
);