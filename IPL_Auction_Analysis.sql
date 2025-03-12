CREATE TABLE IPL_Auction (
    Player VARCHAR(100),
    Nationality VARCHAR(20),
    Type VARCHAR(20),
    Team VARCHAR(50),
    Price_Paid BIGINT
);
--2. Most Expensive Player

SELECT Player, Team, Price_Paid 
FROM IPL_Auction 
ORDER BY Price_Paid DESC 
LIMIT 1;

--3. Team Spending Analysis
SELECT Team, SUM(Price_Paid) AS Total_Spending 
FROM IPL_Auction 
GROUP BY Team 
ORDER BY Total_Spending DESC;

--4. Players by Role Count
SELECT Type, COUNT(*) AS Player_Count 
FROM IPL_Auction 
GROUP BY Type 
ORDER BY Player_Count DESC;

--5. Indian vs Overseas Player Spending
SELECT Nationality, SUM(Price_Paid) AS Total_Spending, COUNT(*) AS Player_Count
FROM IPL_Auction 
GROUP BY Nationality;

--6. Top 5 Most Expensive Bowlers
SELECT Player, Team, Price_Paid 
FROM IPL_Auction 
WHERE Type = 'Bowler' 
ORDER BY Price_Paid DESC 
LIMIT 5;

---7. Average Price per Player Type
SELECT Type, AVG(Price_Paid) AS Avg_Price 
FROM IPL_Auction 
GROUP BY Type 
ORDER BY Avg_Price DESC;

--8. Rank Players by Price
SELECT Player, Team, Price_Paid, 
       RANK() OVER (ORDER BY Price_Paid DESC) AS Price_Rank 
FROM IPL_Auction;

--9. Least Expensive Players
SELECT Player, Team, Price_Paid 
FROM IPL_Auction 
ORDER BY Price_Paid ASC 
LIMIT 5;

--10. Difference Between Highest and Lowest Price
SELECT MAX(Price_Paid) - MIN(Price_Paid) AS Price_Difference 
FROM IPL_Auction;

--11. Highest Spending Team per Player Type
SELECT Type, Team, SUM(Price_Paid) AS Total_Spending
FROM IPL_Auction
GROUP BY Type, Team
ORDER BY Type, Total_Spending DESC;

--12. Percentage of Budget Spent on Each Player Type per Team
SELECT Team,
       SUM(Price_Paid) AS Total_Spending,
       ROUND((SUM(Price_Paid) * 100.0 / (SELECT SUM(Price_Paid) FROM IPL_Auction WHERE IPL_Auction.Team = IA.Team)), 2) AS Percentage_Spending
FROM IPL_Auction IA
GROUP BY Team, Type
ORDER BY Team, Percentage_Spending DESC;

--13. Players Purchased Below the Average Price
SELECT Player, Team, Price_Paid
FROM IPL_Auction
WHERE Price_Paid < (SELECT AVG(Price_Paid) FROM IPL_Auction)
ORDER BY Price_Paid ASC;
--14. Total Players Purchased by Each Team
SELECT Team, COUNT(*) AS Total_Players
FROM IPL_Auction
GROUP BY Team
ORDER BY Total_Players DESC;
--15. Find the Most Popular Player Type (Based on Count)
SELECT Type, COUNT(*) AS Total_Players
FROM IPL_Auction
GROUP BY Type
ORDER BY Total_Players DESC
LIMIT 1;

--16. Players with Price Above Team's Average Spending

SELECT Player, Team, Price_Paid
FROM IPL_Auction IA
WHERE Price_Paid > (SELECT AVG(Price_Paid) FROM IPL_Auction WHERE Team = IA.Team)
ORDER BY Team, Price_Paid DESC;

--17. Teams That Spent More Than 500 Million
SELECT Team, SUM(Price_Paid) AS Total_Spending
FROM IPL_Auction
GROUP BY Team
HAVING SUM(Price_Paid) > 500000000
ORDER BY Total_Spending DESC;
--18. Players Sorted by Price Within Each Team
SELECT Player, Team, Price_Paid,
       RANK() OVER (PARTITION BY Team ORDER BY Price_Paid DESC) AS Rank_in_Team
FROM IPL_Auction;

--19. Number of Indian vs Overseas Players Per Team
SELECT Team, Nationality, COUNT(*) AS Player_Count
FROM IPL_Auction
GROUP BY Team, Nationality
ORDER BY Team, Nationality;

--20. Top 3 Most Expensive Players from Each Team
SELECT Player, Team, Price_Paid
FROM (
    SELECT Player, Team, Price_Paid,
           RANK() OVER (PARTITION BY Team ORDER BY Price_Paid DESC) AS Player_Rank
    FROM IPL_Auction
) AS Ranked
WHERE Player_Rank <= 3;

































