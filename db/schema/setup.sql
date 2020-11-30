drop table if exists fragment_versions;
drop table if exists fragments;
drop table if exists order_versions;
drop table if exists orders;
drop table if exists revision_sets;

create table revision_sets (
	id serial not null,
	date date not null,
	ordinality serial not null,
	parlrules_identifier varchar(20) not null,
	primary key (id)
);
create table orders (
	id serial not null,
	parlrules_identifier varchar(20) not null,
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