drop database if exists vk;
create database vk;
use vk;
drop table if exists users;
create table users (
id serial primary key,
firstname varchar(50),
lastname varchar(50),
email varchar(120) unique,
phone bigint,
index users_phone_indx(phone),
index users_firstname_lastname_indx(firstname, lastname)
);
drop table if exists `profiles`;
create table `profiles` (
user_id serial primary key,
gender  char(1),
birthday date,
photo_id bigint unsigned null,
created_at datetime default now(),
hometown varchar(100),
foreign key (user_id) references users(id)
on update cascade
on delete restrict
);
drop table if exists `message`;
create table `message` (
id serial primary key,
from_user_id bigint unsigned not null,
to_user_id bigint unsigned not null,
body text,
created_at datetime default now(),
index message_from_user_id (from_user_id),
index message_to_user_id (to_user_id),
foreign key (to_user_id) references users(id),
foreign key (from_user_id) references users(id)
);

drop table if exists `friend_request`;
CREATE TABLE `friend_request` (
    initiator_user_id BIGINT UNSIGNED NOT NULL,
    terget_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('request', 'aproved', 'unfrended', 'decline'),
    requered_at DATETIME DEFAULt now(),
    confirmed_at DATETIME,
    PRIMARY KEY (initiator_user_id , terget_user_id),
    INDEX (initiator_user_id),
    INDEX (terget_user_id),
    FOREIGN KEY (initiator_user_id)
        REFERENCES users (id),
    FOREIGN KEY (terget_user_id)
        REFERENCES users (id)
);
drop table if exists `communites`;
CREATE TABLE `communites` (
id serial primary key,
`name` varchar(150),   
index (`name`)
);

drop table if exists `users_communites`;
CREATE TABLE `users_communites` (
user_id bigint unsigned not null,
community_id bigint unsigned not null,
primary key (user_id, community_id),
FOREIGN KEY (user_id) REFERENCES users (id),
FOREIGN KEY (community_id) REFERENCES `communites` (id)
);

drop table if exists media_types;
CREATE TABLE media_types (
id serial primary key,
`name` varchar(255),
created_at datetime default now(),
updated_at datetime default current_timestamp on update  current_timestamp
);

drop table if exists media;
CREATE TABLE media (
id serial  primary key,
media_types_id bigint unsigned not null,
user_id bigint unsigned not null,
body text,
filename varchar(255),
size int,
metadata JSON
);
drop table if exists likes;
CREATE TABLE likes (
id serial  primary key,
media_types_id bigint unsigned not null,
user_id bigint unsigned not null,
created_at datetime default now()
);
drop table if exists photo_albums;
CREATE TABLE photo_albums (
id serial,
`name` varchar(255) default null,
user_id bigint unsigned not null,
created_at datetime default now(),
FOREIGN KEY (user_id) REFERENCES users (id),
primary key (id)
);
drop table if exists photos;
CREATE TABLE photos (
id serial,
album_id bigint unsigned not null,
media_id bigint unsigned not null,
`name` varchar(255) default null,
created_at datetime default now(),
FOREIGN KEY (album_id) REFERENCES users (id),
FOREIGN KEY (media_id) REFERENCES users (id),
primary key (id)
);