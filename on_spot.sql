-- LAI KAI YONG
-- List the name of all members who had given at least a rating of 5 for any books from the 'Romance' genre. 
SELECT M.Member_ID, M.Member_Name, MF.Rating, UB.Book_Genre
FROM MEMBER M
INNER JOIN [MEMBER FEEDBACK] MF
ON M.Member_ID = MF.Member_ID
INNER JOIN BOOK B
ON MF.Book_ID = B.Book_ID
INNER JOIN UNIVERSAL_BOOK UB
ON B.Book_ISBN = UB.Book_ISBN
WHERE UB.Book_Genre = 'Romance' AND MF.Rating >= 5;


-- CHEONG SHENG KUI
--What is the average price for all books from the 'Coding' genre with at least a 5 rating? - Cheong 
SELECT AVG(SUB.Book_Price) AS 'Average Price'
FROM (
    SELECT SUM(B.Book_Price) AS 'Book_Price'
    FROM UNIVERSAL_BOOK UB
    INNER JOIN BOOK B
    ON UB.BOOK_ISBN = B.Book_ISBN
    INNER JOIN [MEMBER FEEDBACK] MF
    ON B.Book_ID = MF.Book_ID
    WHERE UB.Book_Genre = 'Coding' AND MF.Rating >= 5)SUB;


--SELECT B.Book_ID, UB.Book_Genre, MF.Rating, AVG(B.Book_Price) AS 'Average Price'
--FROM BOOK B INNER JOIN UNIVERSAL_BOOK UB ON B.Book_ISBN = UB.Book_ISBN
--INNER JOIN [MEMBER FEEDBACK] MF ON B.Book_ID = MF.Book_ID
--GROUP BY B.Book_ID, UB.Book_Genre, MF.Rating
--WHERE UB.Genre = 'Coding' AND MF.Rating >= 5);

-- LIM WYE YEE
--List the names of all publishers who had published any books with the letter 's' in its title/name. - Lim
SELECT P.Pub_Name, UB.Book_Name
FROM PUBLISHER P INNER JOIN BOOK B ON P.Pub_ID = B.Pub_ID
INNER JOIN UNIVERSAL_BOOK UB ON UB.Book_ISBN = B.Book_ISBN
WHERE UB.Book_Name LIKE '%S%';

