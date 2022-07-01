-- Q1: create the file

	SHOW DATABASES;

-- Q2:
	USE albums_db;

-- Q3 - Explore the structure of the albums table.
	-- Q3a. How many rows are in the albums table?
		SELECT * FROM albums;
	-- Answer: 31 Rows
    
	-- Q3b. How many unique artist names are in the albums table?
		SELECT DISTINCT artist FROM albums;
	-- Answer: 23
    
	-- Q3c. What is the primary key for the albums table?
	-- Answer: 	The primary key is the 'id' column 
    
	-- Q3d. What is the oldest release date for any album in the albums table? What is the most recent release date?
		SELECT * FROM albums ORDER BY release_date;
        SELECT * FROM albums ORDER BY release_date DESC;
    -- Answer: oldest, most recent 1967, 2011
    
-- Q4: Write queries to find the following information:
	-- Q4a. The name of all albums by Pink Floyd
		SELECT name as albums FROM albums WHERE artist = 'Pink Floyd';
	-- Answer: The Dark Side of the Moon, The Wall
    
	-- Q4b. The year Sgt. Pepper's Lonely Hearts Club Band was released
		SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
	-- Answer: 1967
    
	-- Q4c. The genre for the album Nevermind
		SELECT genre FROM albums WHERE name = "Nevermind";
	-- Answer: Grunge, Alternative rock

	-- Q4d. Which albums were released in the 1990s
		SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 2000;
	-- Answer: The Bodygaurd, Jagged Little Pill, Come On OVer, Falling Into You
    -- Answer: Let's Talk About Love, 1, Dangerous, The Immaculate Collection
    -- Answer: Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural

	-- Q4e. Which albums had less than 20 million certified sales
		SELECT * FROM albums WHERE sales < 20;
	-- Answer: Grease: The Original Soundtrack from the Motion Picture, Bad, Sqt. Pepper's Lonely Hearts Club Band
    -- Answer: Dirty Dancing, Let's Talk About Love
    -- Answer: Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A, Brothers in Arms, 
    -- Answer: Titanic: Music from the Motion Picture, Nevermind, The Wall

	-- Q4f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
		SELECT * FROM albums WHERE genre = 'Rock';
	-- Answer: 'Hard rock', 'Progressive rock', and 'Rock' are all different string values
    -- Answer: the genre 'Rock' is a different idea than "genres containing the word 'rock'"
-- Be sure to add, commit, and push your work. 

