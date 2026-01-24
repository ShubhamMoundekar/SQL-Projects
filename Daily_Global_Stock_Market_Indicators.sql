Create Database Stock_data;
Use Stock_data;

CREATE TABLE global_stock_market (
    Date DATE,
    Index_Name VARCHAR(50),
    Country VARCHAR(50),
    Open DECIMAL(10,2),
    High DECIMAL(10,2),
    Low DECIMAL(10,2),
    Close DECIMAL(10,2),
    Volume BIGINT,
    Daily_Change_Percent DECIMAL(5,2)
);

Select * from daily_global_stock_market_indicators;

/* Average Closing Price by Country */ 

Select Country, round(Avg(close),2) as Avg_closing_price from daily_global_stock_market_indicators
group by country;

/* Top 5 Highest Volatility Days */ 

Select Date, Index_name, country, (High - Low) as Volatility_days
from daily_global_stock_market_indicators
order by Volatility_days desc
limit 5;

/* Best Performing Index (Overall) */

Select Index_name, Round(Avg(Daily_Change_Percent),2) as Index_Perform from daily_global_stock_market_indicators
Group by Index_name
Order by Index_Perform desc;

/* Monthly Trend Analysis */

Select date_format(Date, "%y-%m") As Month, Round(Avg(Close),2) as Avg_close From daily_global_stock_market_indicators
Group by Month
Order by month;

/* High Volume Trading Days */ 

Select Date, Index_name, Volume from daily_global_stock_market_indicators
where volume > (select avg(volume) from daily_global_stock_market_indicators);

/* Country-wise Market Stability */ 

Select Country, round(STddev(Daily_Change_Percent), 2) as Volatility_score from daily_global_stock_market_indicators
group by Country
Order by Volatility_score;

/* Bull vs Bear Days */ 

Select 
     case 
         when Daily_Change_Percent > 0 then "Bull"
         Else "Bear Day"
	 end as Market_type, count(*) as total_days
from daily_global_stock_market_indicators
group by Market_type;

/* Top 3 Indices Per Country (Window Function) */ 

Select * from ( Select country, index_name, Avg(close) as Avg_close, rank() over(partition by country order by avg(close) desc) as rnk 
from daily_global_stock_market_indicators
group by country, index_name) t
where rnk <= 3;