CREATE OR REPLACE EDITIONABLE FUNCTION STATSPACK_SCHEDULE RETURN DATE as
    next_run_time DATE;
    cur_time DATE;
BEGIN
    -- get the current date/time
    cur_time := SYSDATE;
       -- If it is between 7AM and midnight then run every fifteen minutes
       -- if it is after midnight and before 7AM then run every two hours on the hour
    if (to_char(cur_time,'HH24') > 7 and to_char(cur_time,'HH24') < 23) then
        next_run_time := cur_time  + (15/1440);
    elsif (to_char(cur_time,'HH24') >  0 and to_char(cur_time,'HH24') < 7) then
        next_run_time :=  TRUNC(cur_time+2/24,'HH24');
    end if;
return next_run_time;
end;
/

