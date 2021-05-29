-- 1.	List the book(s) which has the highest rating. Show book id, book name, and the rating.
SELECT TOP 1 B.Book_ID, U.Book_Title, AVG(MF.Rating) AS Rating
FROM BOOK B
JOIN [MEMBER FEEDBACK] MF
ON B.Book_ID = MF.Book_ID
JOIN UNIVERSAL_BOOK U
ON B.Book_ISBN = U.Book_ISBN
GROUP BY B.Book_ID, U.Book_Title
ORDER BY AVG(MF.Rating) DESC;

-- Or
CREATE VIEW Rating AS
SELECT B.Book_ID, U.Book_Title, AVG(MF.Rating) AS Rating
FROM BOOK B
JOIN [MEMBER FEEDBACK] MF
ON B.Book_ID = MF.Book_ID
JOIN UNIVERSAL_BOOK U
ON B.Book_ISBN = U.Book_ISBN
GROUP BY B.Book_ID, U.Book_Title;

SELECT DISTINCT B.Book_ID, U.Book_Title, R.Rating
FROM BOOK B
JOIN [MEMBER FEEDBACK] MF
ON B.Book_ID = MF.Book_ID
JOIN UNIVERSAL_BOOK U
ON B.Book_ISBN = U.Book_ISBN
JOIN Rating R
ON B.Book_ID = R.Book_ID
WHERE R.Rating = (SELECT MAX(Rating) FROM Rating);

-- 2.	Find the total number of feedback per member. Show member id, member name, and total number of feedback per member.
SELECT M.Member_ID, M.Member_Name, COUNT(MF.Feedback_ID) AS 'Total Feedback'
FROM MEMBER M
JOIN [MEMBER FEEDBACK] MF
ON M.Member_ID = MF.Member_ID
GROUP BY M.Member_ID, M.Member_Name;


-- 3.	Find the total number of book published by each publisher. Show publisher id, publisher name, and number of book published.
SELECT P.Pub_ID, P.Pub_Name, P.Pub_Qty
FROM PUBLISHER P;


-- 4.	Find the total number of books ordered by store manager from each publisher.
SELECT P.Pub_ID, P.Pub_Name, SUM(BO.Order_Quantity) AS 'Total Books Ordered'
FROM [BOOKSTORE ORDER] BO
JOIN PUBLISHER P
ON BO.Pub_ID = P.Pub_ID
GROUP BY P.Pub_ID, P.Pub_Name;


-- 5.	Find the total number of books ordered by each member.
SELECT MO.Member_ID, SUM(BMO.MemOrder_Quantity) AS 'Total Books Ordered'
FROM [MEMBER ORDER] MO INNER JOIN BOOK_MEMBER_ORDER BMO ON MO.MemOrder_ID = BMO.MemOrder_ID  
GROUP BY MO.Member_ID


-- 6.   Find the bestselling book(s).
SELECT TOP 5 BMO.Book_ID, UB.Book_Title, SUM(BMO.MemOrder_Quantity) AS 'Sales'
FROM BOOK_MEMBER_ORDER BMO INNER JOIN BOOK B ON BMO.Book_ID = B.Book_ID
INNER JOIN UNIVERSAL_BOOK UB ON UB.Book_ISBN = B.Book_ISBN
INNER JOIN [MEMBER ORDER] MO ON BMO.MemOrder_ID = MO.MemOrder_ID
WHERE Payment_Status = 'Completed'
GROUP BY BMO.Book_ID, UB.Book_Title ORDER BY SUM(BMO.MemOrder_Quantity) DESC

-- 7.   Show list of total customers based on gender who are registered as members in APU E-Bookstore. 
--      The list should show total number of registered members and total number of gender (Male and female).
SELECT COUNT(Member_ID) AS 'Total Registered Member',
(SELECT COUNT(Member_ID) FROM MEMBER WHERE Gender = 'M') AS 'Male Member',
(SELECT COUNT(Member_ID) FROM MEMBER WHERE Gender = 'F') AS 'Female Member'
FROM MEMBER


-- 8 Show a list of purchased books that have not been delivered to members. The list should show member identification number, address, contact number, book serial number, book title, quantity, date and status of delivery.
SELECT DISTINCT M.Member_ID, CONCAT(M.Street, ', ', M.[Zip Code], ', ', M.City, ', ', M.State, ', ', M.Country) AS 'Member_Address', MCN.Personal_Phone, MCN.Work_Phone, B.Book_ID, UB.Book_Title, BMO.MemOrder_Quantity, MO.MemOrder_Date, MO.Delivery_Status
FROM MEMBER M INNER JOIN MEMBER_CONTACT_NUMBER MCN ON M.Member_ID = MCN.Member_ID
INNER JOIN [MEMBER ORDER] MO ON MO.Member_ID = M.Member_ID
INNER JOIN BOOK_MEMBER_ORDER BMO ON BMO.MemOrder_ID = MO.MemOrder_ID
INNER JOIN BOOK B ON B.Book_ID = BMO.Book_ID
INNER JOIN UNIVERSAL_BOOK UB ON UB.Book_ISBN = B.Book_ISBN
WHERE MO.Delivery_Status != 'Delivered';


-- 9.	Show the member who spent most on buying books. Show member id, member name and total expenditure.
SELECT M.Member_ID, M.Member_Name, MO.MemOrder_Price
FROM MEMBER M INNER JOIN [MEMBER ORDER] MO ON M.Member_ID = MO.Member_ID
WHERE MO.MemOrder_Price = (SELECT MAX(MemOrder_Price) FROM [MEMBER ORDER]);



-- 10.	Show a list of total books as added by each members in the shopping cart.
SELECT SC.Member_ID, M.Member_Name, COUNT(BSC.Purchase_Quantity) AS 'Total books purchased'
FROM [SHOPPING CART] SC INNER JOIN BOOK_SHOPPING_CART BSC ON SC.Purchase_ID = BSC.Purchase_ID
INNER JOIN MEMBER M ON M.Member_ID = SC.Member_ID
INNER JOIN BOOK B ON B.Book_ID = BSC.Book_ID
GROUP BY SC.Member_ID, M.Member_Name;