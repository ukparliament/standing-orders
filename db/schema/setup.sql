drop table if exists fragment_versions;
drop table if exists adoptions;

create table adoptions (
	id serial not null,
	date date not null,
	ordinality serial not null,
	parlrules_identifier varchar(20) not null,
	primary key (id)
);
create table fragment_versions (
	id serial not null,
	adoption_id int not null,
	parlrules_identifier varchar(20) not null,
	current_number varchar(20) not null,
	root_number varchar(20) not null,
	text text not null,
	parlrules_article_identifier varchar(20) not null,
	article_current_number varchar(20) not null,
	article_root_number varchar(20) not null,
	constraint fk_adoption foreign key (adoption_id) references adoptions(id),
	primary key (id)
);