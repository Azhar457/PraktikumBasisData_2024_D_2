USE Revenue_Bebek_Kaleyo;
SELECT * FROM sales
INNER JOIN branches ON sales.branch_id = branches.branch_id
INNER JOIN daily_revenue ON sales.branch_id = daily_revenue.branch_id
WHERE sales.sale_date = daily_revenue.revenue_date;