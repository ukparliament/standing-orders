drop table if exists edges;
drop table if exists nodes;
drop table if exists revisions;
drop table if exists fragment_versions;
drop table if exists fragments;
drop table if exists order_versions;
drop table if exists orders;
drop table if exists revision_sets;
drop table if exists business_extents;
drop table if exists houses;


create table houses (
	id serial not null,
	name varchar(20) not null,
	primary key (id)
);
insert into houses (name) values ('House of Commons');
create table business_extents (
	id serial not null,
	label varchar(20) not null,
	primary key (id)
);
insert into business_extents (label) values ('Public business');
create table revision_sets (
	id serial not null,
	date date not null,
	ordinality serial not null,
	parlrules_identifier varchar(20) not null,
	business_extent_id int not null,
	house_id int not null,
	constraint fk_business_extent foreign key (business_extent_id) references business_extents(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
create table orders (
	id serial not null,
	parlrules_identifier varchar(20) not null,
	business_extent_id int not null,
	house_id int not null,
	constraint fk_business_extent foreign key (business_extent_id) references business_extents(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
create table order_versions (
	id serial not null,
	revision_set_id int not null,
	order_id int,
	parlrules_identifier varchar(20) not null,
	current_number varchar(20) not null,
	root_number varchar(20) not null,
	constraint fk_revision_set foreign key (revision_set_id) references revision_sets(id),
	constraint fk_order foreign key (order_id) references orders(id),
	primary key (id)
);
create table fragments (
	id serial not null,
	parlrules_identifier varchar(20) not null,
	primary key (id)
);
create table fragment_versions (
	id serial not null,
	revision_set_id int not null,
	fragment_id int,
	order_id int,
	order_version_id int,
	parlrules_identifier varchar(20) not null,
	current_number varchar(20) not null,
	root_number varchar(20) not null,
	text text not null,
	parlrules_article_identifier varchar(20) not null,
	article_current_number varchar(20) not null,
	article_root_number varchar(20) not null,
	constraint fk_revision_set foreign key (revision_set_id) references revision_sets(id),
	constraint fk_fragment foreign key (fragment_id) references fragments(id),
	constraint fk_order foreign key (order_id) references orders(id),
	constraint fk_order_version foreign key (order_version_id) references order_versions(id),
	primary key (id)
);
create table revisions (
	id serial not null,
	from_fragment_version_id int not null,
	to_fragment_version_id int not null,
	is_major boolean default false,
	primary key (id)
);

/* Nodes and edges for Sankey thing */
create table nodes (
	id int not null,
	order_version_id int,
	label varchar(2000) not null,
	primary key (id)
);
create table edges (
	id serial,
	from_order_version_id int not null,
	from_node int not null,
	to_order_version_id int,
	to_node int not null,
	weight int not null,
	primary key (id)
);