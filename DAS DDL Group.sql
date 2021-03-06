CREATE DATABASE APUBookstore;

USE APUBookstore;

CREATE TABLE BOOK (
	Book_ID CHAR(8) NOT NULL PRIMARY KEY,
	Book_ISBN CHAR(13) NOT NULL FOREIGN KEY
		REFERENCES UNIVERSAL_BOOK(Book_ISBN),
	Book_Price SMALLMONEY NOT NULL,
	Book_Section TINYINT NOT NULL,
	In_stockQty INT NOT NULL,
	Pub_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES PUBLISHER(Pub_ID)
);

CREATE TABLE UNIVERSAL_BOOK (
	Book_ISBN CHAR(13) NOT NULL PRIMARY KEY,
	Book_Title VARCHAR(60) NOT NULL,
	Book_Genre VARCHAR(25) NOT NULL,
	Book_Edition TINYINT NOT NULL,
	BookPub_Year SMALLINT NOT NULL
);

CREATE TABLE BOOK_AUTHOR (
	Book_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES BOOK(Book_ID),
	First_Author VARCHAR(30) NOT NULL,
	Second_Author VARCHAR(30),
	Third_Author VARCHAR(30),
	PRIMARY KEY(Book_ID)
);

CREATE TABLE MEMBER (
	Member_ID CHAR(8) NOT NULL PRIMARY KEY,
	Member_Name VARCHAR(30) NOT NULL,
	Gender CHAR(1) NOT NULL,
	Member_DOB DATE NOT NULL,
	Member_Join_Date DATE NOT NULL,
	Street VARCHAR(60) NOT NULL,
	[Zip Code] CHAR(5) NOT NULL,
	City VARCHAR(60) NOT NULL,
	State VARCHAR(60) NOT NULL,
	Country VARCHAR(60) NOT NULL
);

CREATE TABLE MEMBER_CONTACT_NUMBER (
	Member_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES MEMBER(Member_ID),
	Personal_Phone CHAR(11),
	Work_Phone CHAR(11),
	PRIMARY KEY(Member_ID)
);

CREATE TABLE PUBLISHER (
	Pub_ID CHAR(8) NOT NULL PRIMARY KEY,
	Pub_Name VARCHAR(50) NOT NULL,
	Pub_Email VARCHAR(40) NOT NULL,
	Pub_Qty INT NOT NULL,
	Street VARCHAR(60) NOT NULL,
	[Zip Code] CHAR(5) NOT NULL,
	City VARCHAR(60) NOT NULL,
	State VARCHAR(60) NOT NULL,
	Country VARCHAR(60) NOT NULL
);

CREATE TABLE PUB_PHONE (
	Pub_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES PUBLISHER(Pub_ID),
	Headquarter_phoneNo CHAR(11) NOT NULL,
	Branch_phoneNo CHAR(11),
	PRIMARY KEY(Pub_ID)
);

CREATE TABLE [BOOKSTORE ORDER](
	Order_ID CHAR(8) NOT NULL PRIMARY KEY,
	Order_Date DATE NOT NULL, 
	Order_Status VARCHAR(15) NOT NULL,
	Pub_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES PUBLISHER(Pub_ID)
);

CREATE TABLE [SHOPPING CART](
	Purchase_ID CHAR(8) NOT NULL PRIMARY KEY,
	Purchase_Date DATE NOT NULL,
	TotalPurchase_Price MONEY NOT NULL,
	Member_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES MEMBER(Member_ID)
);

CREATE TABLE [MEMBER ORDER] (
	MemOrder_ID CHAR(8) NOT NULL PRIMARY KEY,
	MemOrder_Date DATE NOT NULL,
	Payment_Status VARCHAR(15) NOT NULL,
	Delivery_Status VARCHAR(15),
	MemOrder_Price MONEY NOT NULL,
	EstOrderArri_date DATE,
	Purchase_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES [SHOPPING CART](Purchase_ID),
	Member_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES Member(Member_ID)
);

CREATE TABLE [MEMBER FEEDBACK](
	Feedback_ID CHAR(8) NOT NULL PRIMARY KEY,
	Rating INT NOT NULL,
	Remarks VARCHAR(60),
	Member_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES Member(Member_ID),
	Book_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES BOOK(Book_ID),
);

CREATE TABLE BOOK_MEMBER (
	Book_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES BOOK(Book_ID),
	Member_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES Member(Member_ID),
	PRIMARY KEY(Book_ID, Member_ID)	
);

CREATE TABLE BOOK_SHOPPING_CART (
	Book_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES BOOK(Book_ID),
	Purchase_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES [SHOPPING CART](Purchase_ID),
	Purchase_Quantity INT NOT NULL,
	PRIMARY KEY(Book_ID, Purchase_ID)
);

CREATE TABLE BOOK_BOOKSTORE_ORDER (
	Book_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES BOOK(Book_ID),
	Order_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES [BOOKSTORE ORDER](Order_ID),
	Order_Quantity INT NOT NULL,
	PRIMARY KEY(Book_ID, Order_ID)
);

CREATE TABLE BOOK_MEMBER_ORDER (
	Book_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES BOOK(Book_ID),
	MemOrder_ID CHAR(8) NOT NULL FOREIGN KEY
		REFERENCES [MEMBER ORDER](MemOrder_ID),
	MemOrder_Quantity INT NOT NULL,
	PRIMARY KEY(Book_ID, MemOrder_ID)
);