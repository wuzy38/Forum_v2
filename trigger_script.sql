# 当一个版块中有新主题theme的时候，版块plate下主题数+1
# 同时用户发帖数+1

drop trigger TRI_INSERT_PLATE;
DELIMITER $
create trigger TRI_INSERT_PLATE
AFTER INSERT on theme
for each row 
begin
	UPDATE plate set theme_cnt = theme_cnt + 1
    where plate.plate_id = NEW.plate_id;
    
    UPDATE user set grade = grade + 1
    where user.user_id = NEW.user_id;
end
$
DELIMITER ;

# 当一个版块中有删除主题theme的时候，版块plate下主题数-1
# 同时用户发帖数-1
drop trigger TRI_DELETE_PLATE;
DELIMITER $
create trigger TRI_DELETE_PLATE
AFTER DELETE on theme
for each row 
begin
	UPDATE plate set theme_cnt = theme_cnt - 1
    where plate.plate_id = OLD.plate_id;
    
    UPDATE user set grade = grade -1
    where user.user_id = OLD.user_id;
end
$
DELIMITER ;


# 当一个主题theme中有新回复的reply的时候，theme下回复数+1
# 同时用户发帖数+1

drop trigger TRI_INSERT_REPLY;
DELIMITER $
create trigger TRI_INSERT_REPLY
AFTER INSERT on reply
for each row 
begin
	UPDATE theme set reply_cnt = reply_cnt + 1
    where theme.theme_id = NEW.theme_id;
    
    UPDATE user set grade = grade + 1
    where user.user_id = NEW.user_id;
    # 更新时间
    UPDATE theme set newest_reply = now()
    where theme.theme_id = NEW.theme_id;
end
$
DELIMITER ;


# 当一个主题theme中有删除的reply的时候，theme下回复数-1
# 同时用户发帖数-1
drop trigger TRI_DELETE_REPLY;
DELIMITER $
create trigger TRI_DELETE_REPLY
AFTER DELETE on reply
for each row 
begin
	UPDATE theme set reply_cnt = reply_cnt - 1
    where theme.theme_id = NEW.theme_id;
    
    UPDATE user set grade = grade - 1
    where user.user_id = NEW.user_id;
end
$
DELIMITER ;


