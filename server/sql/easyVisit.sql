create table visitees
(
	visitee serial primary key not null,
	name text not null,
	imgurl text,
	frontpage boolean
);

create table visitors
(
	visitor serial primary key not null,
	name text not null,
	organization text not null,
	citizenship text not null,
	purpose text
);

create visits
(
	visit serial primary key not null,
	visitee int references visitees(visitee) not null,
	vistor int references visitors(visitor) not null,
	arrival timestamp with time zone default current_timestamp,
	departure timestamp with time zone,
	badge text not null
);
