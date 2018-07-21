create database dice;
use database dice;

create table player (
	idplayer VARCHAR(36) NOT NULL  PRIMARY KEY,
	paymentid VARCHAR(64) NOT NULL,
	balance NUMERIC(15,8) NOT NULL,
	nickname VARCHAR(100) NOT NULL,
	username VARCHAR(70) NOT NULL,
	password VARCHAR(70) NOT NULL,
	email VARCHAR(200) NULL,
	creationtime datetime NOT NULL DEFAULT NOW(),
	lastupdate datetime NULL
);


create table rollhistory(
	idgame VARCHAR(36) NOT NULL PRIMARY KEY,
	idplayer VARCHAR(36) NOT NULL,
	nickname VARCHAR(100) NOT NULL,
	bet NUMERIC(15,8) NOT NULL,
	target NUMERIC(5,2) NOT NULL,
	number NUMERIC(5) NOT NULL,
	profit NUMERIC(15,8) NOT NULL,
	result BOOL,
	creationtime datetime NOT NULL DEFAULT NOW(),
	lastupdate datetime NULL
);

ALTER TABLE rollhistory
ADD FOREIGN KEY (idplayer) REFERENCES player(idplayer);