-- -- View untuk total revenue per branch
-- CREATE VIEW TotalRevenuePerBranch AS
-- SELECT 
--     b.branch_id,
--     b.branch_name,
--     SUM(dr.total_revenue) AS total_revenue
-- FROM 
--     branches b
--     JOIN daily_revenue dr ON b.branch_id = dr.branch_id
-- GROUP BY 
--     b.branch_id, b.branch_name;

-- -- usage:
-- -- SELECT * FROM TotalRevenuePerBranch;

-- -- View untuk Total penjualan per cabang
-- CREATE VIEW TotalSalesPerBranch AS
-- SELECT 
--     b.branch_id,
--     b.branch_name,
--     COUNT(s.sale_id) AS total_sales
-- FROM
--     branches b
--     JOIN sales s ON b.branch_id = s.branch_id
-- GROUP BY
--     b.branch_id, b.branch_name;

-- -- usage:
-- -- SELECT * FROM TotalSalesPerBranch;

-- -- View untuk total biaya operasional per cabang
-- CREATE VIEW TotalOperationalCostPerBranch AS
-- SELECT 
--     b.branch_id,
--     b.branch_name,
--     SUM(oc.amount) AS total_operational_cost
-- FROM
--     branches b
--     JOIN operational_costs oc ON b.branch_id = oc.branch_id
-- GROUP BY
--     b.branch_id, b.branch_name;

-- -- usage:
-- -- SELECT * FROM TotalOperationalCostPerBranch;

-- -- View untuk penjualan harian per cabang
-- CREATE VIEW DailySalesPerBranch AS
-- SELECT 
--     b.branch_id,
--     b.branch_name,
--     s.sale_date,
--     COUNT(s.sale_id) AS total_sales
-- FROM
--     branches b
--     JOIN sales s ON b.branch_id = s.branch_id
-- GROUP BY
--     b.branch_id, b.branch_name, s.sale_date;

-- -- usage:
-- -- SELECT * FROM DailySalesPerBranch;

-- -- View untuk pendapatan harian per metode pembayaran
-- CREATE VIEW DailyRevenueByPaymentMethod AS
-- SELECT 
--     b.branch_id,
--     b.branch_name,
--     dr.revenue_date,
--     dr.payment_method,
--     SUM(dr.total_revenue) AS daily_revenue
-- FROM 
--     branches b
--     JOIN daily_revenue dr ON b.branch_id = dr.branch_id
-- GROUP BY 
--     b.branch_id, b.branch_name, dr.revenue_date, dr.payment_method;

-- -- usage:
-- -- SELECT * FROM DailyRevenueByPaymentMethod;


-- -- USE Revenue_Bebek_Kaleyo;
-- -- GO
-- -- SELECT * FROM branches;

-- -- UPDATE branches SET phone = '081234567890';
-- -- -- Ubah opening_date menjadi '2023-01-01' untuk semua cabang yang opening_date-nya lebih dari '2023-01-01 00:00:00'
-- -- UPDATE branches SET opening_date = '2023-01-01' WHERE opening_date > '2023-01-01 00:00:00';