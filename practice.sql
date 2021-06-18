-- How many books are there for each categories with more than 1 book?
-- Lai Kai Yong
SELECT UB.Book_Genre, COUNT(B.Book_ID) AS 'Total book'
FROM UNIVERSAL_BOOK UB
INNER JOIN BOOK B
ON UB.Book_ISBN = B.Book_ISBN
GROUP BY UB.Book_Genre
HAVING COUNT(B.Book_ID) > 1;

-- Cheong
SELECT UB.Book_Genre, COUNT(B.Book_ID) AS 'Number of Books'
FROM UNIVERSAL_BOOK UB INNER JOIN Book B ON UB.Book_ISBN = B.Book_ISBN
GROUP BY UB.Book_Genre
HAVING COUNT(B.Book_ID) > 1;

-- Cheryl
SELECT COUNT(B.Book_ID) AS 'Number of books', UB.Book_Genre
FROM UNIVERSAL_BOOK UB INNER JOIN BOOK B ON UB.Book_ISBN = B.Book_ISBN
GROUP BY UB.Book_Genre
HAVING COUNT(B.book_ID) > 1;

--List the names of all books with ratings 6 or 7.

--Vandyck
SELECT UB.Book_Title, AVG(MF.Rating) AS 'Rating'
FROM [MEMBER FEEDBACK] MF
INNER JOIN BOOK B
ON MF.Book_ID = B.Book_ID
INNER JOIN UNIVERSAL_BOOK UB
ON B.Book_ISBN = UB.Book_ISBN
GROUP BY UB.Book_Title
HAVING AVG(MF.Rating) IN (6, 7);

--Cheong

SELECT UB.Book_Title, MB.Book_ID, AVG(MB.Rating) AS 'Book Rating'
FROM BOOK B INNER JOIN [UNIVERSAL_BOOK] UB ON B.BOOK_ISBN = UB.Book_ISBN
INNER JOIN [MEMBER FEEDBACK] MB ON MB.Book_ID = B.Book_ID
GROUP BY UB.Book_Title, MB.Book_ID
HAVING AVG(MB.RATING) = 6 OR AVG(MB.Rating) = 7
ORDER BY AVG(MB.RATING) ASC;


--Cheryl
SELECT UB.Book_Title, AVG(MF.Rating) AS 'Rating'
FROM [MEMBER FEEDBACK] MF INNER JOIN BOOK B ON MF.Book_ID = B.Book_ID
INNER JOIN UNIVERSAL_BOOK UB ON UB.Book_ISBN = B.Book_ISBN
GROUP BY UB.Book_Title 
HAVING AVG(MF.Rating) BETWEEN 6 AND 7; 


--List the IDs of customers who had placed more than 1 order.

--Vandyck
SELECT MO.Member_ID, COUNT(MO.MemOrder_ID) AS 'Total order'
FROM [MEMBER ORDER] MO
GROUP BY MO.Member_ID
HAVING COUNT(MO.MemOrder_ID) > 1;

--Cheong
SELECT MEMBER_ID, COUNT(MemOrder_ID) AS 'Order Times'
FROM [MEMBER ORDER]
GROUP BY MEMBER_ID
HAVING COUNT(MemOrder_ID) > 1;

--Cheryl
SELECT Member_ID, COUNT(MemOrder_ID) AS "Number of orders"
FROM [MEMBER ORDER]
GROUP BY Member_ID
HAVING COUNT(MemOrder_ID) > 1;

-- List the names of all 'Coding' books bought by the member named 'Kim Jong'.

--Vandyck
SELECT UB.Book_Title
FROM BOOK B
INNER JOIN UNIVERSAL_BOOK UB 
ON B.Book_ISBN = UB.Book_ISBN
INNER JOIN BOOK_MEMBER_ORDER BMO
ON B.Book_ID = BMO.Book_ID
INNER JOIN [Member Order] MO
ON BMO.MemOrder_ID = MO.Memorder_ID
INNER JOIN Member M
ON MO.Member_ID = M.Member_ID
WHERE M.Member_Name = 'Kim Jong' AND UB.Book_Genre = 'Coding' AND MO.Payment_Status= 'Completed';

--Cheong
SELECT M.Member_Name, UB.Book_Title, UB.Book_Genre, B.Book_ID 
FROM BOOK B INNER JOIN UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
INNER JOIN BOOK_MEMBER_ORDER BMO ON BMO.Book_ID = B.Book_ID
INNER JOIN [MEMBER ORDER] MO ON BMO.MemOrder_ID = MO.Memorder_ID
INNER JOIN MEMBER M ON M.Member_ID = MO.Member_ID
WHERE UB.Book_Genre = 'Coding' AND M.Member_Name = 'Kim Jong' AND Payment_Status = 'Completed'

--Cheryl
SELECT UB.Book_Title, UB.Book_Genre
FROM UNIVERSAL_BOOK UB INNER JOIN BOOK B ON UB.Book_ISBN = B.Book_ISBN
INNER JOIN BOOK_MEMBER_ORDER BMO ON BMO.Book_ID = B.Book_ID
INNER JOIN [MEMBER ORDER] MO ON BMO.MemOrder_ID = MO.MemOrder_ID
INNER JOIN Member M ON M.Member_ID = MO.Member_ID 
WHERE M.Member_Name = 'Kim Jong' AND UB.Book_Genre = 'Coding' AND MO.Payment_Status = 'Completed';

-- How many members had given any ratings above 5 for any book? 

--Vandyck
SELECT COUNT(Sub.Member_ID) AS 'Members that given rating above 5'
FROM (SELECT DISTINCT MF.Member_ID
FROM [MEMBER FEEDBACK] MF
WHERE MF.Rating > 5) Sub;

--Cheong
SELECT COUNT(Member_ID) AS 'Times rating more than 5'
FROM (SELECT DISTINCT Member_ID
FROM [MEMBER FEEDBACK]
WHERE Rating > 5) [Rating > 5];

--Cheryl
SELECT COUNT(Member_ID) AS 'Number of members'
FROM (SELECT DISTINCT Member_ID 
FROM [MEMBER FEEDBACK]
WHERE Rating > 5)[Rating > 5];

-- List the publisher name (s) with the highest purchase order - amount/total?

--Vandyck
SELECT P.Pub_Name, SUB2.Order_Quantity
FROM PUBLISHER P
INNER JOIN (
    SELECT TOP 1 SUB1.Pub_ID, SUB1.Order_Quantity
	FROM (
		SELECT P.Pub_ID, SUM(BBO.Order_Quantity) AS 'Order_Quantity'
		FROM PUBLISHER P
		INNER JOIN [BOOKSTORE ORDER] BO
		ON P.Pub_ID = BO.Pub_ID
		INNER JOIN BOOK_BOOKSTORE_ORDER BBO
		ON BO.Order_ID = BBO.Order_ID
		GROUP BY P.Pub_ID
		)SUB1 
	GROUP BY SUB1.Pub_ID, SUB1.Order_Quantity
	ORDER BY SUB1.Order_Quantity DESC) SUB2
ON P.Pub_ID = SUB2.Pub_ID;


--Cheong
SELECT TOP 1 P.Pub_Name, SUM(BBO.Order_Quantity) AS "Total Books ordered"
FROM Publisher P INNER JOIN [BOOKSTORE ORDER] BO ON P.Pub_ID = BO.Pub_ID
INNER JOIN BOOK_BOOKSTORE_ORDER BBO ON BBO.Order_ID = BO.Order_ID
GROUP BY P.Pub_Name
ORDER BY (SUM(BBO.Order_Quantity)) DESC;

--Cheryl
SELECT TOP 1 P.Pub_Name, SUM(BBO.Order_Quantity) AS 'Total number of books'
FROM PUBLISHER P INNER JOIN [BOOKSTORE ORDER] BO ON P.Pub_ID = BO.Pub_ID 
INNER JOIN BOOK_BOOKSTORE_ORDER BBO ON BBO.Order_ID = BO.Order_ID
GROUP BY P.Pub_Name
ORDER BY SUM(BBO.Order_Quantity) DESC;


-- List all the remark feedbacks and book name from member name 'Ji Eun' where remark is not empty.

--Vandyck
SELECT  UB.Book_Title, MF.Remarks
FROM BOOK B
INNER JOIN [MEMBER FEEDBACK] MF
ON B.Book_ID = MF.Book_ID
INNER JOIN MEMBER M
ON MF.Member_ID = M.Member_ID
INNER JOIN UNIVERSAL_BOOK UB
ON B.Book_ISBN = UB.Book_ISBN
WHERE M.Member_Name = 'Ji Eun' AND MF.Remarks IS NOT NULL;

--Cheong
SELECT MF.Remarks, UB.Book_Title
FROM [MEMBER FEEDBACK] MF INNER JOIN Book B ON B.Book_ID = MF.Book_ID
INNER JOIN UNIVERSAL_BOOK UB ON UB.Book_ISBN = B.Book_ISBN
INNER JOIN MEMBER M ON M.Member_ID=MF.Member_ID
WHERE M.Member_Name = 'Ji Eun' AND MF.Remarks IS NOT NULL

-- Cheryl 
SELECT MF.Remarks, UB.Book_Title
FROM [MEMBER FEEDBACK] MF INNER JOIN BOOK B ON MF.Book_ID = B.Book_ID
INNER JOIN [UNIVERSAL_BOOK] UB ON UB.Book_ISBN = B.Book_ISBN
INNER JOIN MEMBER M ON M.Member_ID = MF.Member_ID
WHERE M.Member_Name= 'Ji Eun' AND MF.Remarks IS NOT NULL;

-- Get member personal contact number where their order is in delivering 

--Vandyck
SELECT DISTINCT M.Member_ID, MCN.Personal_Phone 
FROM Member M
INNER JOIN MEMBER_CONTACT_NUMBER MCN
ON M.Member_ID = MCN.Member_ID
INNER JOIN [MEMBER ORDER] MO
ON M.Member_ID = MO.Member_ID
WHERE MO.Delivery_Status = 'DELIVERING' 
AND MCN.Personal_Phone IS NOT NULL;


--Cheong
SELECT DISTINCT MCM.Member_ID, MCM.Personal_Phone, MO.Delivery_Status
FROM MEMBER_CONTACT_NUMBER MCM INNER JOIN MEMBER M ON MCM.Member_ID = M.MEMBER_ID
INNER JOIN [MEMBER ORDER] MO ON MO.Member_ID = M.Member_ID
INNER JOIN BOOK_MEMBER_ORDER BMO ON BMO.MemOrder_ID = MO.MemOrder_ID
WHERE MO.Delivery_Status = 'Delivering' AND MCM.Personal_Phone IS NOT NULL;

--Cheryl
SELECT DISTINCT MCN.Member_ID, MCN.Personal_Phone
FROM MEMBER_CONTACT_NUMBER MCN INNER JOIN MEMBER M ON MCN.Member_ID = M.Member_ID
INNER JOIN [MEMBER ORDER] MO ON MO.Member_ID = M.Member_ID
INNER JOIN BOOK_MEMBER_ORDER BMO ON BMO.MemOrder_ID = MO.MemOrder_ID
WHERE MO.Delivery_Status = 'Delivering' AND MCN.Personal_Phone IS NOT NULL;

-- List the publisher that is using gmail

--Vandyck
SELECT Pub_ID, Pub_Name, Pub_Email
FROM PUBLISHER
WHERE Pub_Email LIKE '%gmail%';

--Cheong
SELECT Pub_Name, Pub_Email 
FROM PUBLISHER
WHERE Pub_Email LIKE '%gmail%';

--Cheryl
SELECT Pub_Name, Pub_Email
FROM PUBLISHER
WHERE Pub_Email LIKE '%gmail%';

-- List the member name that purchased the book published by publisher that are in Malaysia

-- Vandyck
SELECT DISTINCT M.Member_Name
FROM MEMBER M
INNER JOIN [MEMBER ORDER] MO
ON M.Member_ID = MO.Member_ID
INNER JOIN BOOK_MEMBER_ORDER BMO
ON MO.MemOrder_ID = BMO.MemOrder_ID
INNER JOIN BOOK B
ON BMO.BOOK_ID = B.Book_ID
INNER JOIN PUBLISHER P
ON B.Pub_ID = P.Pub_ID
WHERE P.Country = 'Malaysia';

-- -- Validation
SELECT M.Member_Name, BMO.Book_ID, P.Pub_ID, P.Country
FROM MEMBER M
INNER JOIN [MEMBER ORDER] MO
ON M.Member_ID = MO.Member_ID
INNER JOIN BOOK_MEMBER_ORDER BMO
ON MO.MemOrder_ID = BMO.MemOrder_ID
INNER JOIN BOOK B
ON BMO.BOOK_ID = B.Book_ID
INNER JOIN PUBLISHER P
ON B.Pub_ID = P.Pub_ID
WHERE P.Country = 'Malaysia';


--Cheong
SELECT DISTINCT M.Member_Name
FROM MEMBER M INNER JOIN [MEMBER ORDER] MO ON M.MEMBER_ID = MO.MEMBER_ID
INNER JOIN BOOK_MEMBER_ORDER BMO ON BMO.MemOrder_ID = MO.MemOrder_ID
INNER JOIN BOOK B ON B.Book_ID = BMO.Book_ID
INNER JOIN Publisher P ON P.Pub_ID = B.Pub_ID
WHERE P.Country = 'Malaysia'

-- Cheryl
SELECT DISTINCT M.Member_Name
FROM MEMBER M INNER JOIN [MEMBER ORDER] MO ON M.Member_ID = MO.Member_ID
INNER JOIN BOOK_MEMBER_ORDER BMO ON MO.MemOrder_ID = BMO.Memorder_ID
INNER JOIN BOOK B ON B.Book_ID = BMO.Book_ID 
INNER JOIN PUBLISHER P ON P.Pub_ID = B.Pub_ID
WHERE P.Country = 'Malaysia';

-- List the book id and book name where the price of it is under RM25

-- Vandyck
SELECT B.Book_ID, UB.Book_Title, B.Book_Price
FROM BOOK B
INNER JOIN UNIVERSAL_BOOK UB
ON B.Book_ISBN = UB.Book_ISBN
WHERE B.Book_Price < 25;

--Cheong
SELECT B.Book_ID, UB.Book_Title
FROM BOOK B INNER JOIN UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
WHERE B.Book_Price < 25;

--Cheryl
SELECT B.Book_ID, UB.Book_Title
FROM BOOK B INNER JOIN UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
WHERE B.Book_Price < 25;

-- List member id, member name that make multiple book order (CHEONG)

--CHEONG
SELECT M.Member_ID, M.Member_Name, COUNT(MO.MemOrder_ID) AS 'Book Orders'
FROM MEMBER M INNER JOIN [MEMBER ORDER] MO ON M.Member_ID = MO.Member_ID
GROUP BY M.Member_ID, M.Member_Name
HAVING COUNT(MO.MemOrder_ID)>1;

--Cheryl
SELECT M.Member_Name, M.Member_ID, COUNT(MO.MemOrder_ID) AS 'Total book orders'
FROM [MEMBER ORDER] MO INNER JOIN MEMBER M ON M.Member_ID = MO.Member_ID
GROUP BY M.Member_Name, M.Member_ID
HAVING COUNT(MO.MemOrder_ID) > 1;

-- List the most recent member order (CHEONG)

--CHEONG
SELECT TOP 5 MemOrder_ID, MemOrder_Date
FROM [MEMBER ORDER]
ORDER BY MemOrder_Date DESC;

-- Vandyck
SELECT TOP 5 *
FROM [MEMBER ORDER]
ORDER BY MemOrder_Date DESC;

--Cheryl
SELECT TOP 5 MemOrder_ID, MemOrder_Date
FROM [MEMBER ORDER]
ORDER BY MemOrder_Date DESC;

-- List all book where second author and third author must be present

-- Vandyck
SELECT B.Book_ID, UB.Book_Title
FROM BOOK B
INNER JOIN BOOK_AUTHOR BA
ON B.Book_ID = BA.Book_ID
INNER JOIN UNIVERSAL_BOOK UB
ON B.Book_ISBN = UB.Book_ISBN
WHERE BA.Second_Author IS NOT NULL 
AND BA.Third_Author IS NOT NULL;

-- CHEONG
SELECT B.Book_ID, UB.Book_Title, BA.First_Author, BA.Second_Author,BA.Third_Author
FROM BOOK B INNER JOIN UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
INNER JOIN Book_Author BA ON BA.Book_ID = B.Book_ID
WHERE BA.Second_Author IS NOT NULL AND
BA.Third_Author IS NOT NULL;


-- CHERYL
SELECT B.Book_ID, UB.Book_Title
FROM BOOK B INNER JOIN BOOK_AUTHOR BA ON B.BOOK_ID = BA.BOOK_ID
INNER JOIN UNIVERSAL_BOOK UB ON B.BOOK_ISBN = UB.BOOK_ISBN
WHERE BA.Second_Author IS NOT NULL AND
BA.Third_Author IS NOT NULL;

-- List all publisher where they have equal to 2 books in the bookstore and more than 1 order created with the bookstore.

-- Vandyck
SELECT P.Pub_ID, P.Pub_Name, COUNT(BO.Order_ID) AS 'Total order with bookstore', SUB.[Total Book]
FROM PUBLISHER P
INNER JOIN [BOOKSTORE ORDER] BO
ON P.Pub_ID = BO.Pub_ID
INNER JOIN (SELECT Pub_ID, COUNT(Book_ID) AS 'Total Book'
			FROM BOOK 
			GROUP BY Pub_ID) SUB 
ON P.Pub_ID = SUB.Pub_ID
GROUP BY P.Pub_ID, P.Pub_Name, SUB.[Total Book]
HAVING COUNT(BO.Order_ID) > 1;

-- Cheong
SELECT P.Pub_Name, P.Pub_Qty, COUNT(BO.Order_ID) AS 'Amount of Orders'
FROM PUBLISHER P INNER JOIN [BOOKSTORE ORDER] BO ON P.Pub_ID = BO.Pub_ID
WHERE P.Pub_Qty>0
GROUP BY P.Pub_Qty, P.Pub_Name
HAVING COUNT(BO.Order_ID)>1

-- Cheryl
SELECT P.Pub_ID, P.Pub_Name, COUNT(BO.Order_ID) AS 'Number of Orders'
FROM PUBLISHER P INNER JOIN [BOOKSTORE ORDER] BO ON P.Pub_ID = BO.Pub_ID
INNER JOIN BOOK B ON B.Pub_ID = BO.Pub_ID
GROUP BY P.Pub_ID, P.Pub_Name, P.Pub_Qty
HAVING COUNT(BO.Order_ID) > 1 AND P.Pub_Qty > 2;


-- List all member where their shopping cart book more than 5.

-- Vandyck
SELECT M.Member_ID, M.Member_Name, SUM(BSC.Purchase_Quantity) AS 'Total book quantity'
FROM MEMBER M
INNER JOIN [SHOPPING CART] SC
ON M.Member_ID = SC.Member_ID
INNER JOIN BOOK_SHOPPING_CART BSC
ON SC.Purchase_ID = BSC.Purchase_ID
GROUP BY M.Member_ID, M.Member_Name;
HAVING SUM(BSC.Purchase_Quantity) > 5;

-- Cheong
SELECT M.Member_ID, SC.Purchase_ID, SUM(BSC.Purchase_Quantity)
FROM MEMBER M INNER JOIN [SHOPPING CART] SC ON M.Member_ID = SC.Member_ID
INNER JOIN BOOK_SHOPPING_CART BSC ON BSC.Purchase_ID=SC.Purchase_ID
GROUP BY M.Member_ID, SC.Purchase_ID
HAVING SUM(BSC.Purchase_Quantity)>5

-- Cheryl
SELECT M.Member_ID, M.Member_Name, SUM(BSC.Purchase_Quantity) AS 'Total number of books' 
FROM MEMBER M INNER JOIN [SHOPPING CART] SC ON M.Member_ID = SC.Member_ID
INNER JOIN BOOK_SHOPPING_CART BSC ON BSC.Purchase_ID = SC.Purchase_ID
GROUP BY M.Member_ID, M.Member_Name
HAVING SUM(Purchase_Quantity) > 5;


-- List Book that have book edition and appear to be contained in a member order.

-- Vandyck
SELECT B.Book_ID, UB.Book_Edition
FROM BOOK B
INNER JOIN UNIVERSAL_BOOK UB
ON B.Book_ISBN = UB.Book_ISBN
INNER JOIN BOOK_MEMBER_ORDER BMO
ON B.Book_ID =  BMO.Book_ID
WHERE BMO.

-- Cheong
SELECT B.Book_ISBN, UB.Book_Title, UB.Book_Edition
FROM BOOK B INNER JOIN  UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
INNER JOIN BOOK_MEMBER_ORDER BMO ON B.Book_ID = BMO.Book_ID

-- Cheryl
SELECT B.book_ID, UB.Book_Edition
FROM BOOK B INNER JOIN UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
INNER JOIN BOOK_MEMBER_ORDER BMO ON B.Book_ID = BMO.Book_ID
WHERE BMO.