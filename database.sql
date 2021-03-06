create database dice;
use dice;

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


create table transfers (
    hash VARCHAR(100) NOT NULL PRIMARY KEY,
    amount numeric(15,8),
    creationtime datetime NOT NULL DEFAULT NOW()
);


----------------
-- QUERYS
----------------

-- GET INFO FROM USERS
SELECT p.nickname, p.email, SUM(r.bet), p.balance, (50 - p.balance) AS 'Profit', p.password
FROM rollhistory r
JOIN player p ON p.idplayer = r.idplayer
GROUP BY p.nickname, p.email,  p.password, p.balance
ORDER BY  sum(r.bet) DESC;


-- GET JACKPOT TOTAL ^8 (100%)
SELECT ROUND(SUM(ab.Profit), 8) AS 'JACKPOT' FROM player pl
JOIN (
	SELECT r.idplayer AS 'nick', (p.balance) AS 'Profit'
	FROM rollhistory r
	JOIN player p ON p.idplayer = r.idplayer
	GROUP BY p.nickname, r.idplayer, p.balance, (p.balance)
	) ab ON pl.idplayer = ab.nick;


-- GET JACKPOT PAYABLE ^8 (66%) ^8
SELECT ROUND(((SUM(ab.Profit) / 3) * 2),8) AS 'JACKPOT' FROM player pl
JOIN (
	SELECT r.idplayer AS 'nick', (p.balance) AS 'Profit'
	FROM rollhistory r
	JOIN player p ON p.idplayer = r.idplayer
	GROUP BY p.nickname, r.idplayer, p.balance, (p.balance)
	) ab ON pl.idplayer = ab.nick;


