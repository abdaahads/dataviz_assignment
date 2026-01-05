-- BIG DATA ANALYTICS ASSIGNMENT - NETFLIX DATASET
-- SQL Analysis Script

-- PREREQUISITE: Assume a table named 'netflix_titles' exists with the CSV schema.

-- 1. COUNT OF MOVIES VS TV SHOWS
-- Objective: Understand the composition of the library.
SELECT 
    type, 
    COUNT(*) as total_count 
FROM 
    netflix_titles 
GROUP BY 
    type;

-- 2. MOST COMMON RATINGS FOR MOVIES AND TV SHOWS
-- Objective: Identify the target audience based on ratings.
SELECT 
    type, 
    rating, 
    COUNT(*) as count 
FROM 
    netflix_titles 
GROUP BY 
    type, 
    rating 
ORDER BY 
    count DESC;

-- 3. LIST ALL MOVIES RELEASED IN A SPECIFIC YEAR (e.g., 2020)
-- Objective: Filter content by release year.
SELECT 
    title, 
    country, 
    duration 
FROM 
    netflix_titles 
WHERE 
    type = 'Movie' 
    AND release_year = 2020;

-- 4. TOP 5 COUNTRIES WITH THE MOST CONTENT
-- Objective: Geographic analysis of content origin.
-- Note: This assumes simpler country data. Complex parsing might be needed for multi-country strings.
SELECT 
    country, 
    COUNT(*) as title_count 
FROM 
    netflix_titles 
WHERE 
    country IS NOT NULL 
GROUP BY 
    country 
ORDER BY 
    title_count DESC 
LIMIT 5;

-- 5. CONTENT ADDED PER YEAR
-- Objective: Analyze the platform's growth trajectory.
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as year_added,
    COUNT(*) as count
FROM 
    netflix_titles
WHERE
    date_added IS NOT NULL
GROUP BY 
    year_added
ORDER BY 
    year_added DESC;

-- 6. FIND CONTENT DIRECTED BY SPECIFIC DIRECTORS (e.g., 'Rajiv Chilaka')
-- Objective: Director-specific analysis.
SELECT 
    title, 
    type, 
    release_year 
FROM 
    netflix_titles 
WHERE 
    director LIKE '%Rajiv Chilaka%';

-- 7. AVERAGE DURATION OF MOVIES
-- Objective: Analyze content length (requires cleaning 'min' from duration string).
SELECT 
    AVG(CAST(REPLACE(duration, ' min', '') AS INTEGER)) as avg_movie_duration_mins
FROM 
    netflix_titles 
WHERE 
    type = 'Movie';
