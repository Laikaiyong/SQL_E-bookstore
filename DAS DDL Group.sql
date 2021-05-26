CREATE DATABASE APUBookstore;

USE APUBookstore;

CREATE TABLE Book (
	Book_ID nchar(5) PRIMARY KEY,
	Book_Title varchar(50) NOT NULL,
	Book_Genre varchar(50) NOT NULL,
	Book_Price money NOT NULL,
	Book_ISBN varchar(13) NOT NULL,
	Book_Author varchar(50) NOT NULL,
	Book_Edition integer,
	Book_Section nchar(1) NOT NULL,
	BookPub_Year date NOT NULL,
	In_stockQty integer,
	Pub_ID nchar(5) FOREIGN KEY NOT NULL
		REFERENCES Publisher(Pub_ID),
	Feedback_ID  nchar(5) FOREIGN KEY NOT NULL
		REFERENCES Member_Feedback(Feedback_ID)
);

CREATE TABLE Book_Inventory_Records (
	Book_ID nchar(5) NOT NULL FOREIGN KEY
		REFERENCES Book(Book_ID),
	Book_InStockDate date NOT NULL,
	BookNum_Received integer NOT NULL
);

CREATE TABLE Member (
	Member_ID nchar(5) NOT NULL PRIMARY KEY,
	Member_Name 
);