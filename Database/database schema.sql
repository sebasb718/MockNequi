create database if not exists nequi_mock;

use nequi_mock;

CREATE TABLE if not exists Users (
  UserID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Email VARCHAR(100) NOT NULL unique,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  Password VARCHAR(200) NOT NULL,  
  PRIMARY KEY (UserID)
) DEFAULT CHARSET = utf8;

CREATE TABLE if not exists AccountTypes (
  AccountTypeID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  AccountType VARCHAR(100) NOT NULL,
  PRIMARY KEY (AccountTypeID)
) DEFAULT CHARSET = utf8;
INSERT INTO AccountTypes VALUES 
(0,'Cuenta principal'),
(0,'Bolsillo'),
(0,'Colchon'),
(0,'Meta');

CREATE TABLE if not exists GoalStatus (
  GoalStatusID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  GoalStatus VARCHAR(100) NOT NULL,
  PRIMARY KEY (GoalStatusID)
) DEFAULT CHARSET = utf8;
INSERT INTO GoalStatus VALUES 
(0,'En progreso'),
(0,'Lograda'),
(0,'Vencida');

CREATE TABLE if not exists Accounts (
  AccountID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  AccountTypeID INT UNSIGNED NOT NULL,
  FOREIGN KEY (AccountTypeID) REFERENCES AccountTypes(AccountTypeID),
  UserID INT UNSIGNED NOT NULL,
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  AvailableMoney INT UNSIGNED NOT NULL,
  AccountStatus BIT NOT NULL,
  Name VARCHAR(100) NULL,
  GoalDate DATE NULL,
  GoalStatusID INT UNSIGNED NULL,
  FOREIGN KEY (GoalStatusID) REFERENCES GoalStatus(GoalStatusID),
  GoalMoney INT UNSIGNED NULL,
  PRIMARY KEY (AccountID)
) DEFAULT CHARSET = utf8;

CREATE TABLE if not exists Transactions (
  TransactionID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  OriginAccountID INT UNSIGNED NULL,
  FOREIGN KEY (OriginAccountID) REFERENCES Accounts(AccountID),
  DestinationAccountID INT UNSIGNED NULL,
  FOREIGN KEY (DestinationAccountID) REFERENCES Accounts(AccountID),
  Money INT UNSIGNED NOT NULL,
  Transaction_date DATETIME NOT NULL,
  PRIMARY KEY (TransactionID)
) DEFAULT CHARSET = utf8;
