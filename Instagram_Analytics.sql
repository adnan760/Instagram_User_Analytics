-- Find the 5 oldest users of the Instagram from the database provided 
SELECT username,created_at
FROM ig_clone.users
ORDER BY created_at ASC
LIMIT 5; 

-- Find the users who have never posted a single photo on Instagram
SELECT username
FROM ig_clone.users
WHERE id
NOT IN (SELECT user_id FROM ig_clone.photos);

-- Identify the winner of the contest and provide their details to the team 
SELECT users.username, photos.id, count(*) AS amount_of_likes
FROM ig_clone.likes
JOIN ig_clone.photos ON ig_clone.photos.id=ig_clone.likes.photo_id
JOIN ig_clone.users ON ig_clone.users.id=ig_clone.likes.photo_id
GROUP BY ig_clone.photos.id
ORDER BY amount_of_likes DESC
LIMIT 1; 

-- Identify and suggest the top 5 most commonly used hashtags on the platform 
SELECT tag_name, COUNT(tag_name) AS frequency
FROM ig_clone.tags
JOIN ig_clone.photo_tags ON ig_clone.tags.id = ig_clone.photo_tags.tag_id
GROUP BY ig_clone.tags.id
ORDER BY frequency DESC
LIMIT 5; 

-- Day of the week do most users register on. Provide insights on when to schedule an ad campaign 
SELECT date_format(created_at,'%W') AS 'Day', COUNT(*) AS 'No of Registrations'
FROM ig_clone.users
GROUP BY 1
ORDER BY 2 DESC;

/* Provide how many times does average user posts on Instagram. 
Also, provide the total number of photos on Instagram/total number of users */
SELECT ROUND((SELECT COUNT(*)FROM ig_clone.photos)/(SELECT COUNT(*)
FROM ig_clone.users),2) AS 'Frequency'; 

/* Provide data on users (bots) who have liked every single photo on the site 
(since any normal user would not be able to do this). */
SELECT id, username, COUNT(users.id) As No_of_likes
FROM ig_clone.users
JOIN ig_clone.likes ON ig_clone.users.id = ig_clone.likes.user_id
GROUP BY ig_clone.users.id
HAVING No_of_likes = (SELECT COUNT(*) FROM ig_clone.photos); 


