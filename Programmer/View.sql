-- VIEW
-- View Untuk Menampilkan Total Revenue Per Branch
CREATE OR ALTER VIEW TotalRevenuePerBranch AS
SELECT 
    b.branch_id,
    b.branch_name,
    SUM(dr.total_revenue) AS total_revenue
FROM 
    branches b
    JOIN daily_revenue dr ON b.branch_id = dr.branch_id
GROUP BY 
    b.branch_id, b.branch_name;

-- Usage
-- SELECT * FROM TotalRevenuePerBranch;

-- View Untuk Menampilkan Total Sales Per Branch
CREATE OR ALTER VIEW TotalSalesPerBranch AS
SELECT 
    b.branch_id,
    b.branch_name,
    SUM(s.total_price) AS total_sales
FROM 
    branches b
    JOIN sales s ON b.branch_id = s.branch_id
GROUP BY 
    b.branch_id, b.branch_name;

-- Usage
-- SELECT * FROM TotalSalesPerBranch

-- View Untuk Menampilkan Total Operational Costs Per Branch
CREATE OR ALTER VIEW TotalOperationalCostsPerBranch AS
SELECT 
    b.branch_id,
    b.branch_name,
    SUM(oc.amount) AS total_operational_costs
FROM 
    branches b
    JOIN operational_costs oc ON b.branch_id = oc.branch_id
GROUP BY 
    b.branch_id, b.branch_name;

-- Usage
-- SELECT * FROM TotalOperationalCostsPerBranch;


-- View Untuk Menampilkan Daily Sales Per Branch
CREATE OR ALTER VIEW DailySalesPerBranch AS
SELECT 
    b.branch_id,
    b.branch_name,
    s.sale_date,
    SUM(s.total_price) AS daily_sales
FROM 
    branches b
    JOIN sales s ON b.branch_id = s.branch_id
GROUP BY 
    b.branch_id, b.branch_name, s.sale_date;

-- Usage
-- SELECT * FROM DailySalesPerBranch


-- View Untuk Menampilkan Daily Revenue Per Branch per Payment Method
CREATE OR ALTER VIEW DailyRevenueByPaymentMethod AS
SELECT 
    b.branch_id,
    b.branch_name,
    dr.revenue_date,
    dr.payment_method,
    SUM(dr.total_revenue) AS daily_revenue
FROM 
    branches b
    JOIN daily_revenue dr ON b.branch_id = dr.branch_id
GROUP BY 
    b.branch_id, b.branch_name, dr.revenue_date, dr.payment_method;

-- Usage
-- SELECT * FROM DailyRevenueByPaymentMethod;


-- View Untuk Menampilkan Spesiifc Branch Sales
CREATE OR ALTER VIEW SpecificBranchSales AS
SELECT 
    s.sale_id,
    s.branch_id,
    s.menu_id,
    s.sale_date,
    s.quantity,
    s.total_price,
    s.payment_method
FROM
    sales s
WHERE 
    s.branch_id = 1;
-- Usage
-- SELECT * FROM SpecificBranchSales;


-- View Untuk Menampilkan sales details dengan menu
CREATE OR ALTER VIEW SalesDetailsWithMenu AS
SELECT 
    s.sale_id,
    s.branch_id,
    s.menu_id,
    m.menu_name,
    m.category,
    s.sale_date,
    s.quantity,
    s.total_price,
    s.payment_method
FROM 
    sales s
    JOIN menu m ON s.menu_id = m.menu_id;
-- Usage
-- SELECT * FROM SalesDetailsWithMenu;


-- View Untuk Menampilkan operational costs details dengan branch
CREATE OR ALTER VIEW OperationalCostsWithBranch AS
SELECT 
    oc.cost_id,
    oc.branch_id,
    b.branch_name,
    oc.cost_date,
    oc.cost_category,
    oc.amount,
    oc.notes
FROM 
    operational_costs oc
    JOIN branches b ON oc.branch_id = b.branch_id;
-- usage
-- SELECT * FROM OperationalCostsWithBranch;

-- View Untuk Menampilkan daily revenue details dengan branch
CREATE OR ALTER VIEW DailyRevenueWithBranch AS
SELECT 
    dr.revenue_id,
    dr.branch_id,
    b.branch_name,
    dr.revenue_date,
    dr.total_revenue,
    dr.total_customers,
    dr.payment_method,
    dr.notes
FROM 
    daily_revenue dr
    JOIN branches b ON dr.branch_id = b.branch_id;
-- usage
-- SELECT * FROM DailyRevenueWithBranch

-- View Untuk Menampilkan sales details dengan branch dan menu
CREATE OR ALTER VIEW SalesWithBranchAndMenu AS
SELECT 
    s.sale_id,
    s.branch_id,
    b.branch_name,
    s.menu_id,
    m.menu_name,
    m.category,
    s.sale_date,
    s.quantity,
    s.total_price,
    s.payment_method
FROM 
    sales s
    JOIN branches b ON s.branch_id = b.branch_id
    JOIN menu m ON s.menu_id = m.menu_id;
-- Usage
-- SELECT * FROM SalesWithBranchAndMenu;

-- View untuk bracnh contact info
CREATE OR ALTER VIEW BranchContactInfo AS
SELECT 
    branch_id,
    branch_name
FROM 
    branches;
-- Usage
-- SELECT * FROM BranchContactInfo;

-- View untuk menu details
CREATE OR ALTER VIEW MenuDetails AS
SELECT 
    menu_id,
    menu_name,
    category,
    price
FROM 
    menu;
-- Usage
-- SELECT * FROM MenuDetails;


-- view untuk sales terbaru
CREATE OR ALTER VIEW RecentSales AS
SELECT 
    sale_id,
    branch_id,
    menu_id,
    sale_date,
    quantity,
    total_price,
    payment_method
FROM 
    sales
WHERE 
    sale_date >= DATEADD(DAY, -30, GETDATE());
-- Usage
-- SELECT * FROM RecentSales;

-- view untuk high revenue days
CREATE OR ALTER VIEW HighRevenueDays AS
SELECT 
    branch_id,
    revenue_date,
    total_revenue,
    total_customers,
    payment_method,
    notes
FROM 
    daily_revenue
WHERE 
    total_revenue > 5000;
-- Usage
-- SELECT * FROM HighRevenueDays;

-- view untuk operational costs summary
CREATE OR ALTER VIEW OperationalCostsSummary AS
SELECT 
    branch_id,
    cost_category,
    SUM(amount) AS total_amount
FROM 
    operational_costs
GROUP BY 
    branch_id, cost_category;
-- Usage
SELECT * FROM OperationalCostsSummary;

USE Revenue_Bebek_Kaleyo