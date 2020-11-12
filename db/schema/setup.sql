drop table if exists adoptions;

create table adoptions (
	id serial not null,
	date date not null,
	ordinality serial not null,
	parlrules_identifier varchar(20) not null,
	primary key (id)
)
	
