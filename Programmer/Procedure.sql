-- Procedure untuk menambahkan cabang baru
CREATE PROCEDURE AddBranch
    @BranchName VARCHAR(100),
    @Address TEXT,
    @City VARCHAR(50),
    @Province VARCHAR(50),
    @PostalCode VARCHAR(10),
    @Phone VARCHAR(15),
    @OpeningDate DATE
AS
BEGIN
    INSERT INTO branches (branch_name, address, city, province, postal_code, phone, opening_date)
    VALUES (@BranchName, @Address, @City, @Province, @PostalCode, @Phone, @OpeningDate);
END;
GO

-- Usage:
-- EXEC AddBranch 'Branch Name', 'Address', 'City', 'Province', 'PostalCode', 'Phone', '2023-01-01';

-- Procedure untuk menambahkan revenue harian
CREATE PROCEDURE AddDailyRevenue
    @BranchID INT,
    @RevenueDate DATE,
    @TotalRevenue DECIMAL(15,2),
    @TotalCustomers INT,
    @PaymentMethod VARCHAR(50),
    @Notes TEXT
AS
BEGIN
    INSERT INTO daily_revenue (branch_id, revenue_date, total_revenue, total_customers, payment_method, notes)
    VALUES (@BranchID, @RevenueDate, @TotalRevenue, @TotalCustomers, @PaymentMethod, @Notes);
END;
GO

-- Usage:
-- EXEC AddDailyRevenue 1, '2023-01-01', 1000.00, 50, 'Cash', 'Notes';

-- Procedure untuk menambahkan menu baru
CREATE PROCEDURE AddMenu
    @BranchID INT,
    @MenuName VARCHAR(100),
    @Category VARCHAR(50),
    @Price DECIMAL(10,2),
    @IsAvailable BIT
AS
BEGIN
    INSERT INTO menu (branch_id, menu_name, category, price, is_available)
    VALUES (@BranchID, @MenuName, @Category, @Price, @IsAvailable);
END;
GO

-- Usage:
-- EXEC AddMenu 1, 'Menu Name', 'Category', 100.00, 1;

-- Procedure untuk menambahkan penjualan
CREATE PROCEDURE AddSale
    @BranchID INT,
    @MenuID INT,
    @SaleDate DATETIME,
    @Quantity INT,
    @TotalPrice DECIMAL(15,2),
    @PaymentMethod VARCHAR(50)
AS
BEGIN
    INSERT INTO sales (branch_id, menu_id, sale_date, quantity, total_price, payment_method)
    VALUES (@BranchID, @MenuID, @SaleDate, @Quantity, @TotalPrice, @PaymentMethod);
END;
GO

-- Usage:
-- EXEC AddSale 1, 1, '2023-01-01 12:00:00', 2, 200.00, 'Cash';

-- Procedure untuk menambahkan biaya operasional
CREATE PROCEDURE AddOperationalCost
    @BranchID INT,
    @CostDate DATE,
    @CostCategory VARCHAR(50),
    @Amount DECIMAL(15,2),
    @Notes TEXT
AS
BEGIN
    INSERT INTO operational_costs (branch_id, cost_date, cost_category, amount, notes)
    VALUES (@BranchID, @CostDate, @CostCategory, @Amount, @Notes);
END;
GO

-- Usage:
-- EXEC AddOperationalCost 1, '2023-01-01', 'Utilities', 500.00, 'Notes';

-- Procedure untuk memperbarui harga menu
CREATE PROCEDURE UpdateMenuPrice
    @MenuID INT,
    @NewPrice DECIMAL(10,2)
AS
BEGIN
    UPDATE menu
    SET price = @NewPrice
    WHERE menu_id = @MenuID;
END;
GO

-- Usage:
-- EXEC UpdateMenuPrice 1, 150.00;

-- Procedure untuk menghapus cabang
CREATE PROCEDURE DeleteBranch
    @BranchID INT
AS
BEGIN
    DELETE FROM branches
    WHERE branch_id = @BranchID;
END;
GO

-- Usage:
-- EXEC DeleteBranch 1;