call sp_register_user('alice', 'pass1', 'alice@example.com');
call sp_register_user('bob', 'pass2', 'bob@example.com');
call sp_register_user('charlie', 'pass3', 'charlie@example.com');
call sp_register_user('diana', 'pass4', 'diana@example.com');

select * from users;
select * from user_log order by log_id;


-- BÀI 2
call sp_create_post(1, 'Hello world from Alice!');
call sp_create_post(1, 'Alice second post');
call sp_create_post(2, 'Bob first post');
call sp_create_post(2, 'Bob sharing something');
call sp_create_post(3, 'Charlie is here');

select * from posts;
select * from post_log order by log_id;


-- BÀI 3
insert into comments(post_id, user_id, content) values
  (1, 2, 'Nice post'),
  (1, 3, 'Hello'),
  (2, 3, 'Good one');

call sp_like_post(2, 1);
call sp_like_post(3, 1);
call sp_like_post(4, 1);
call sp_like_post(1, 3);

select post_id, like_count from posts order by post_id;
select * from likes order by post_id, user_id;
select * from like_log order by log_id;

call sp_unlike_post(2, 1);

select post_id, like_count from posts order by post_id;
select * from likes order by post_id, user_id;
select * from like_log order by log_id;


-- BÀI 4
call sp_send_friend_request(1, 2);
call sp_send_friend_request(1, 3);
call sp_send_friend_request(4, 1);

select * from friends order by created_at;
select * from friend_log order by log_id;


-- BÀI 5
call sp_accept_friend_request(1, 2);

select * 
from friends
where (user_id = 1 and friend_id = 2)
   or (user_id = 2 and friend_id = 1);

select * from friend_log order by log_id;


-- BÀI 6
call sp_accept_friend_request(1, 3);

select * 
from friends
where (user_id = 1 and friend_id = 3)
   or (user_id = 3 and friend_id = 1);

call sp_update_friendship(1, 3, 'pending', 1);

select * 
from friends
where (user_id = 1 and friend_id = 3)
   or (user_id = 3 and friend_id = 1);

call sp_remove_friendship(1, 2, 1);

select * 
from friends
where (user_id = 1 and friend_id = 2)
   or (user_id = 2 and friend_id = 1);

call sp_remove_friendship(1, 2, 0);

select * from friends order by user_id, friend_id;


-- BÀI 7
select * from posts where post_id = 1;
select * from comments where post_id = 1;
select * from likes where post_id = 1;

call sp_delete_post(1, 1, 1);

select * from posts where post_id = 1;

call sp_delete_post(1, 1, 0);

select * from posts;
select * from comments;
select * from likes;
select * from post_log order by log_id;


-- BÀI 8
select * from users where user_id = 4;
select * from friends where user_id = 4 or friend_id = 4;

call sp_delete_user(4, 1);

select * from users where user_id = 4;

call sp_delete_user(4, 0);

select * from users;
select * from friends;


-- KẾT QUẢ CUỐI
select * from users;
select * from posts;
select * from comments;
select * from likes;
select * from friends;

select * from user_log order by log_id;
select * from post_log order by log_id;
select * from like_log order by log_id;
select * from friend_log order by log_id;