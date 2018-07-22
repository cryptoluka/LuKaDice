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


----------------
-- QUERYS
----------------

-- GET INFO FROM USERS
SELECT p.nickname, p.email, SUM(r.bet), p.balance, (50 - p.balance) AS 'Profit', p.password
FROM rollhistory r
JOIN player p ON p.idplayer = r.idplayer
GROUP BY p.nickname, p.email,  p.password, p.balance
ORDER BY  sum(r.bet) DESC;


-- GET JACKPOT TOTAL
SELECT SUM(ab.Profit) AS 'JACKPOT' FROM rollhistory roll
JOIN (
	SELECT r.idplayer AS 'nick', (50 - p.balance) AS 'Profit'
	FROM rollhistory r
	JOIN player p ON p.idplayer = r.idplayer
	GROUP BY p.nickname, r.idplayer, p.balance, (50 - p.balance)
	) ab ON roll.idplayer = ab.nick

-- GET JACKPOT PAYABLE (66%)
SELECT (SUM(ab.Profit) / 3) * 2 AS 'JACKPOT' FROM rollhistory roll
JOIN (
	SELECT r.idplayer AS 'nick',( 50 - p.balance) AS 'Profit'
	FROM rollhistory r
	JOIN player p ON p.idplayer = r.idplayer
	GROUP BY p.nickname, r.idplayer, p.balance, (50 - p.balance)
	) ab ON roll.idplayer = ab.nick




SELECT SUM(ab.Profit) AS 'JACKPOT' FROM player pl
JOIN (
	SELECT r.idplayer AS 'nick', (50 - p.balance) AS 'Profit'
	FROM rollhistory r
	JOIN player p ON p.idplayer = r.idplayer
	GROUP BY p.nickname, r.idplayer, p.balance, (50 - p.balance)
	) ab ON pl.idplayer = ab.nick



SELECT (SUM(ab.Profit) / 3) * 2 AS 'JACKPOT' FROM player pl
JOIN (
	SELECT r.idplayer AS 'nick', (50 - p.balance) AS 'Profit'
	FROM rollhistory r
	JOIN player p ON p.idplayer = r.idplayer
	GROUP BY p.nickname, r.idplayer, p.balance, (50 - p.balance)
	) ab ON pl.idplayer = ab.nick



