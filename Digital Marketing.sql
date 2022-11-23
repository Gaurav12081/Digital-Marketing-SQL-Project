/* What is CTR for google_wide campaign on February 1, 2021?
Ans: 0.18 */
/*What is Conversion 1 for instagram_tier2 campaign on February 5, 2021?
Ans: 0.03 */
/*What is Conversion 2 for facebook_tier1 campaign on February 9, 2021?
Ans: 0.13 */
/*What is AOV for facebook_lal campaign on February 13, 2021?
Ans: 1265 */
/*What is CPC for facebook_retargeting campaign on February 23, 2021?
Ans: 7.99 */
/*What is CAC for the youtube_blogger campaign on February 24, 2021?
Ans: 1638.88 */
/*What is ROMI for the banner_partner campaign on February 28, 2021?
Ans: 0.03 */
select *,
((clicks/impressions)*100) CTR,
(leads/clicks) 'Conversion 1',
(orders/leads) 'Conversion 2',
(Revenue/orders) 'Average order value (AOV)',
(mark_spent/clicks) 'Cost per click (CPC)',
(mark_spent/leads) 'Cost per lead (CPL)',
(mark_spent/orders) 'Customer acquisition cost (CAC)',
(revenue - mark_spent) 'Gross profit',
((revenue - mark_spent)/mark_spent) ROMI
from marketing;

/*Calculate Overall ROMI
Ans: 0.4 */
Select (sum(revenue) - sum(mark_spent))/sum(mark_spent)
from marketing;

/*Calculate ROMI for instagram_blogger campaign between 15th Feb to 25th Feb
Ans: 0.38 */
Select (sum(revenue) - sum(mark_spent))/sum(mark_spent)
from marketing
where campaign_name = "instagram_blogger" and c_date between "2021-02-15" and "2021-02-25";

/*Find out the average revenue spent on weekend(Saturday and Sunday)
Ans: 132593.58 */
Select avg(revenue)
from marketing
where dayname(c_date) = "Saturday" or  dayname(c_date) = "Sunday";

/*Find out the average revenue spent on weekdays(Monday to Friday) with NOT IN
Ans. 141914.2 */
Select avg(revenue)
from marketing
where dayname(c_date) in ("Friday","Thursday","wednesday","Tuesday","Monday");

Select avg(revenue)
from marketing
where weekday(c_date) between 0 and 4;

Select avg(revenue)
from marketing
where dayname(c_date) not in ("Sunday","Saturday");

/*Which campaign showed the worst loss in a single day? 
By loss we mean negative gross profit (revenue - marketing spending). Enter campaign ID.
Ans. 544756 */
Select *,dayname(c_date),(revenue - mark_spent) gross_profit
from marketing
order by gross_profit;

/*How much total money we spent on Facebook on campaigns with negative ROMI.
Note: Use LOCATE function to find the substring in the string.
Ans. 9280237.56*/
select sum(mark_spent)
from marketing
Where locate("facebook",campaign_name) and ((revenue - mark_spent)/mark_spent) <0;