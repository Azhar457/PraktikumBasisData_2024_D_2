USE Revenue_Bebek_Kaleyo;
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

    SELECT @TotalRevenue = SUM(total_revenue)
    FROM daily_revenue
    WHERE branch_id = @BranchID
    AND revenue_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalRevenue;
END;
GO

-- pengunaan fungsi GetTotalRevenue
SELECT dbo.GetTotalRevenue(1, '2021-01-01', '2021-01-31') AS TotalRevenue;

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

    SELECT @TotalSales = SUM(total_price)
    FROM sales
    WHERE branch_id = @BranchID
    AND sale_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalSales;
END;
GO

-- pengunaan fungsi GetTotalSales
SELECT dbo.GetTotalSales(1, '2021-01-01', '2021-01-31') AS TotalSales;

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

    SELECT @TotalCosts = SUM(amount)
    FROM operational_costs
    WHERE branch_id = @BranchID
    AND cost_date BETWEEN @StartDate AND @EndDate;

    RETURN @TotalCosts;
END;
GO

-- pengunaan fungsi GetTotalOperationalCosts
SELECT dbo.GetTotalOperationalCosts(1, '2021-01-01', '2021-01-31') AS TotalOperationalCosts;

-- Drop functions if they exist to avoid redundancy
IF OBJECT_ID('dbo.GetTotalRevenue', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalRevenue;
GO

IF OBJECT_ID('dbo.GetTotalSales', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalSales;
GO

IF OBJECT_ID('dbo.GetTotalOperationalCosts', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetTotalOperationalCosts;
GO