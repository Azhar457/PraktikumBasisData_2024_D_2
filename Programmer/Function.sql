USE Revenue_Bebek_Kaleyo;
GO

-- Drop fungsi untuk menghilangkan redundansi
IF OBJECT_ID('dbo.GetTotalRevenue', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalRevenue;
GO

IF OBJECT_ID('dbo.GetTotalSales', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalSales;
GO

IF OBJECT_ID('dbo.GetTotalOperationalCosts', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalOperationalCosts;
GO

IF OBJECT_ID('dbo.GetBranchDetails', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetBranchDetails;
GO

IF OBJECT_ID('dbo.GetDailyRevenueByPaymentMethod', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetDailyRevenueByPaymentMethod;
GO

IF OBJECT_ID('dbo.GetMenuDetails', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetMenuDetails;
GO

IF OBJECT_ID('dbo.GetSalesByMenuItem', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetSalesByMenuItem;
GO

IF OBJECT_ID('dbo.GetTotalCustomers', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalCustomers;
GO

IF OBJECT_ID('dbo.GetTotalSalesByCategory', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalSalesByCategory;
GO

IF OBJECT_ID('dbo.GetTotalSalesByPaymentMethod', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalSalesByPaymentMethod;
GO

IF OBJECT_ID('dbo.GetTotalOperationalCostsByCategory', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalOperationalCostsByCategory;
GO

IF OBJECT_ID('dbo.GetDailyTotalRevenue', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetDailyTotalRevenue;
GO

IF OBJECT_ID('dbo.GetDailyTotalSales', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetDailyTotalSales;
GO

IF OBJECT_ID('dbo.GetDailyTotalOperationalCosts', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetDailyTotalOperationalCosts;
GO

IF OBJECT_ID('dbo.GetDailyTotalCustomers', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetDailyTotalCustomers;
GO

-- Function untuk mengambil total revenue dari suatu cabang dalam rentang tanggal tertentu
CREATE FUNCTION dbo.GetTotalRevenue (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(15,2);

    SELECT @TotalRevenue = ISNULL(SUM(total_revenue), 0)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalRevenue;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalRevenue(1, '2023-01-01', '2023-01-31');

-- Function untuk mengambil total penjualan dari suatu cabang dalam rentang tanggal tertentu
CREATE FUNCTION dbo.GetTotalSales (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(15,2);

    SELECT @TotalSales = ISNULL(SUM(total_price), 0)
    FROM sales
    WHERE branch_id = @BranchID
    AND sale_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalSales;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalSales(1, '2023-01-01', '2023-01-31');

-- Function untuk mengambil total biaya operasional dari suatu cabang dalam rentang tanggal tertentu
CREATE FUNCTION dbo.GetTotalOperationalCosts (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalCosts DECIMAL(15,2);

    SELECT @TotalCosts = ISNULL(SUM(amount), 0)
    FROM operational_costs
    WHERE branch_id = @BranchID
    AND cost_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalCosts;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalOperationalCosts(1, '2023-01-01', '2023-01-31');

-- Function untuk menampilkan detail dari branch
CREATE FUNCTION dbo.GetBranchDetails (
    @BranchID INT
)
RETURNS TABLE
AS
RETURN (
    SELECT branch_id, branch_name, address, city, province, postal_code, phone, opening_date
    FROM branches
    WHERE branch_id = @BranchID
);
GO

-- Pengunaan:
-- SELECT * FROM dbo.GetBranchDetails(1);

-- Function untuk menampilkan daily revenue dari suatu cabang berdasarkan metode pembayaran
CREATE FUNCTION dbo.GetDailyRevenueByPaymentMethod (
    @BranchID INT,
    @RevenueDate DATE,
    @PaymentMethod VARCHAR(50)
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalDailyRevenue DECIMAL(15,2);

    SELECT @TotalDailyRevenue = ISNULL(SUM(total_revenue), 0)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date = @RevenueDate
    AND payment_method = @PaymentMethod;

    RETURN @TotalDailyRevenue;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetDailyRevenueByPaymentMethod(1, '2023-01-01', 'Cash');

-- Function untuk menampilkan detail menu dari suatu cabang
CREATE FUNCTION dbo.GetMenuDetails (
    @BranchID INT
)
RETURNS TABLE
AS
RETURN (
    SELECT menu_id, menu_name, category, price, is_available
    FROM menu
    WHERE branch_id = @BranchID
);
GO

-- Pengunaan:
-- SELECT * FROM dbo.GetMenuDetails(1);

-- Function untuk mengambil total penjualan dari suatu menu item dalam rentang tanggal tertentu
CREATE FUNCTION dbo.GetSalesByMenuItem (
    @MenuItemID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(15,2);

    SELECT @TotalSales = ISNULL(SUM(total_price), 0)
    FROM sales
    WHERE menu_id = @MenuItemID
    AND sale_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalSales;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetSalesByMenuItem(1, '2023-01-01', '2023-01-31');

-- Function untuk mengambil total pelanggan dari suatu cabang dalam rentang tanggal tertentu
CREATE FUNCTION dbo.GetTotalCustomers (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCustomers INT;
    SELECT @TotalCustomers = ISNULL(SUM(total_customers), 0)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalCustomers;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalCustomers(1, '2023-01-01', '2023-01-31');

-- Function untuk mengambil total penjualan berdasarkan kategori
CREATE FUNCTION dbo.GetTotalSalesByCategory (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        m.category,
        SUM(s.total_price) AS TotalSales
    FROM sales s
    JOIN menu m ON s.menu_id = m.menu_id
    WHERE s.branch_id = @BranchID
    AND s.sale_date BETWEEN @StartDate AND @EndDate
    GROUP BY m.category
);
GO

-- Pengunaan:
-- SELECT * FROM dbo.GetTotalSalesByCategory(1, '2023-01-01', '2023-01-31');

-- Function untuk mengambil total penjualan berdasarkan metode pembayaran
CREATE FUNCTION dbo.GetTotalSalesByPaymentMethod (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE,
    @PaymentMethod VARCHAR(50)
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(15,2);

    SELECT @TotalSales = ISNULL(SUM(total_price), 0)
    FROM sales
    WHERE branch_id = @BranchID
    AND sale_date BETWEEN @StartDate AND @EndDate
    AND payment_method = @PaymentMethod;

    RETURN @TotalSales;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalSalesByPaymentMethod(1, '2023-01-01', '2023-01-31', 'Cash');

-- Function untuk mengambil total biaya operasional berdasarkan kategori
CREATE FUNCTION dbo.GetTotalOperationalCostsByCategory (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE,
    @CostCategory VARCHAR(50)
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalCosts DECIMAL(15,2);

    SELECT @TotalCosts = ISNULL(SUM(amount), 0)
    FROM operational_costs
    WHERE branch_id = @BranchID
    AND cost_date BETWEEN @StartDate AND @EndDate
    AND cost_category = @CostCategory;

    RETURN @TotalCosts;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalOperationalCostsByCategory(1, '2023-01-01', '2023-01-31', 'Utilities');

-- Function untuk mengambil total revenue harian
CREATE FUNCTION dbo.GetDailyTotalRevenue (
    @BranchID INT,
    @RevenueDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(15,2);

    SELECT @TotalRevenue = ISNULL(SUM(total_revenue), 0)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date = @RevenueDate;

    RETURN @TotalRevenue;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetDailyTotalRevenue(1, '2023-01-01');

-- Function untuk mengambil total penjualan harian
CREATE FUNCTION dbo.GetDailyTotalSales (
    @BranchID INT,
    @SaleDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(15,2);

    SELECT @TotalSales = ISNULL(SUM(total_price), 0)
    FROM sales
    WHERE branch_id = @BranchID
    AND sale_date = @SaleDate;

    RETURN @TotalSales;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetDailyTotalSales(1, '2023-01-01');

-- Function untuk mengambil total biaya operasional harian
CREATE FUNCTION dbo.GetDailyTotalOperationalCosts (
    @BranchID INT,
    @CostDate DATE
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalCosts DECIMAL(15,2);

    SELECT @TotalCosts = ISNULL(SUM(amount), 0)
    FROM operational_costs
    WHERE branch_id = @BranchID
    AND cost_date = @CostDate;

    RETURN @TotalCosts;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetDailyTotalOperationalCosts(1, '2023-01-01');

-- Function untuk mengambil total pelanggan harian
CREATE FUNCTION dbo.GetDailyTotalCustomers (
    @BranchID INT,
    @RevenueDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCustomers INT;

    SELECT @TotalCustomers = ISNULL(SUM(total_customers), 0)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date = @RevenueDate;

    RETURN @TotalCustomers;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetDailyTotalCustomers(1, '2023-01-01');

-- Function untuk mengambil total penjualan berdasarkan menu item dan metode pembayaran
CREATE FUNCTION dbo.GetSalesByMenuItemAndPaymentMethod (
    @MenuItemID INT,
    @StartDate DATE,
    @EndDate DATE,
    @PaymentMethod VARCHAR(50)
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(15,2);

    SELECT @TotalSales = ISNULL(SUM(total_price), 0)
    FROM sales
    WHERE menu_id = @MenuItemID
    AND sale_date BETWEEN @StartDate AND @EndDate
    AND payment_method = @PaymentMethod;

    RETURN @TotalSales;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetSalesByMenuItemAndPaymentMethod(1, '2023-01-01', '2023-01-31', 'Cash');

-- Function untuk mengambil total revenue berdasarkan metode pembayaran
CREATE FUNCTION dbo.GetTotalRevenueByPaymentMethod (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE,
    @PaymentMethod VARCHAR(50)
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(15,2);

    SELECT @TotalRevenue = ISNULL(SUM(total_revenue), 0)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date BETWEEN @StartDate AND @EndDate
    AND payment_method = @PaymentMethod;

    RETURN @TotalRevenue;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalRevenueByPaymentMethod(1, '2023-01-01', '2023-01-31', 'Credit Card');

-- Function untuk mengambil total revenue berdasarkan kategori
CREATE FUNCTION dbo.GetTotalRevenueByCategory (
    @BranchID INT,
    @StartDate DATE,
    @EndDate DATE,
    @Category VARCHAR(50)
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(15,2);

    SELECT @TotalRevenue = ISNULL(SUM(total_revenue), 0)
    FROM daily_revenue dr
    JOIN menu m ON dr.branch_id = m.branch_id
    WHERE dr.branch_id = @BranchID
    AND dr.revenue_date BETWEEN @StartDate AND @EndDate
    AND m.category = @Category;

    RETURN @TotalRevenue;
END;
GO

-- Pengunaan:
-- SELECT dbo.GetTotalRevenueByCategory(1, '2023-01-01', '2023-01-31', 'Food');
