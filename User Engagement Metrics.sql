-- Mandatory Project Week 3 Advance SQL--
-- 1.Create an ER diagram or draw a schema for the given database. --

-- 2.We want to reward the user who has been around the longest, Find the 5 oldest users. -- 
Select * from Users 
order by created_at asc
limit 5;

-- 3.To target inactive users in an email ad campaign, find the users who have never posted a photo. --
Select U.id, U.username From Users U
Left Join Likes L on L.user_id=U.id
where L.photo_id is Null;

-- 4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? --
Select L.user_id, U.username, Count(*) as Total_likes From likes L
Join Photos P on L.user_id = P.user_id
Join users U on L.user_id=U.id
group by U.id
Order By Total_likes Desc;

Select U.Id, U.Username, Count(L.photo_id) as Total_likes from Users U
Join Likes L on U.Id=L.user_id
Group by U.id
Order by Total_likes Desc;

-- 5.The investors want to know how many times does the average user post. --
Select Avg(User_post) as Avg_User_post
From (
    Select COUNT(*) as User_post
    from Likes
    group by user_id
) as User_post;

-- 6. A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. --
Select T.id, T.tag_name, Count(*) as Most_Used_tags from Photo_tags Pt
Join Tags T on PT.tag_id=T.Id
Group by T.id
order by Most_Used_tags Desc; 

-- 7. To find out if there are bots, find users who have liked every single photo on the site. --
Select user_id, COUNT(*) as Total_like
From likes
Group by user_id
Having total_like = (Select COUNT(*) from photos);

-- 8.Find the users who have created instagramid in may and select top 5 newest joinees from it? --
Select * from Users 
where month(created_at) = 5 
order by created_at desc
limit 5;

-- 9. Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos? -- 
Select Distinct u.username
From users u
Join photos p on u.id = p.user_id
Join likes l on p.id = l.photo_id
Where u.username Like 'c%' and u.username Like '%(0-9)' and p.user_id = l.user_id;

-- 10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5. --
Select U.Id, U.username, COUNT(*) AS 'num_photos'
from Photos P
Join Users U on U.id=P.user_id 
Where 'num_photos' Between 3 and 5
Group by U.Id
Order by 'num_photos' Desc
Limit 30;
