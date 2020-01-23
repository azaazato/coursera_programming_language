fun is_older(date1 : int*int*int, date2 : int*int*int) =
  if (#1 date1 ) <> (#1 date2)
  then (#1 date1) < (#1 date2)
  else if (#2 date1) <> (#2 date2)
  then (#2 date1) < (#2 date2)
  else (#3 date1) < (#3 date2) 

fun number_in_month(dates: (int*int*int) list, month) =
    if null dates 
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

fun number_in_months(dates: (int*int*int) list, months: int list) = 
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates: (int*int*int) list, month: int) =
  if null dates
  then []
  else if #2 (hd dates) = month
  then hd dates :: dates_in_month(tl dates, month)
  else dates_in_month(tl dates, month)

fun dates_in_months(dates: (int*int*int) list, months: int list) = 
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth(lst: string list, num: int) = 
  if null lst
  then ""
  else if num = 1
  then hd lst
  else get_nth(tl lst, num-1)

val month_strings = [ "January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December"]


fun date_to_string(year:int, month: int, date: int) =
  get_nth(month_strings, month) ^ " " ^ Int.toString(date) ^ ", " ^ Int.toString(year)

fun number_before_reaching_sum(sum: int, lst: int list) =
  let
    fun number_before_reaching_sum_helper(sum: int, lst: int list, cnt: int) =
      if sum <= hd lst
      then cnt
      else number_before_reaching_sum_helper(sum-(hd lst), tl lst, cnt+1)
  in
    number_before_reaching_sum_helper(sum, lst, 0)
  end

fun what_month(d: int) = 
  let
    val day_of_month = [31, 28 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum(d, day_of_month) + 1
  end

fun month_range(d1: int, d2: int) =
  let
    fun month_range_helper(d: int) =
      if d > d2
      then []
      else what_month(d) :: month_range_helper(d+1)
  in
    month_range_helper(d1)
  end
  
fun oldest(dates: (int*int*int) list) =
  if null dates then NONE
    else
	let fun oldest_nonempty (sublist: (int*int*int) list) =
	    if null (tl sublist) then (hd sublist)
	    else
          let val tail_oldest = oldest_nonempty (tl sublist)
          in
              if is_older (hd sublist, tail_oldest) then (hd sublist)
              else
                 tail_oldest
          end
	 in SOME (oldest_nonempty (dates))
   end