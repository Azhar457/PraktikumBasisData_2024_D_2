
-- prosedur untuk memperbarui opening_date di tabel branches
CREATE PROCEDURE UpdateBranchOpeningDate
AS
BEGIN
    -- Perbarui opening_date di tabel branches berdasarkan tanggal pembelian terawal di tabel sales
    UPDATE branches
    SET opening_date = (
        SELECT MIN(sale_date)
        FROM sales
        WHERE sales.branch_id = branches.branch_id
    )
    WHERE EXISTS (
        SELECT 1
        FROM sales
        WHERE sales.branch_id = branches.branch_id
    );
END;
GO

-- Jalankan prosedur untuk memperbarui opening_date
EXEC UpdateBranchOpeningDate;

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'UpdateTotalPrice')
BEGIN
    DROP PROCEDURE UpdateTotalPrice;
END
GO

-- CREATE PROCEDURE UpdateTotalPrice
CREATE PROCEDURE UpdateTotalPrice
AS
BEGIN
    UPDATE sales
    SET total_price = m.price * s.quantity
    FROM sales s
    JOIN menu m ON s.menu_id = m.menu_id;
END;
GO

-- Jalankan prosedur untuk memperbarui total_price
EXEC UpdateTotalPrice;

-- Procedure untuk menambahkan menu baru
CREATE PROCEDURE AddMenu
    @MenuName VARCHAR(100),
    @Category VARCHAR(50),
    @Price DECIMAL(10,2)
AS
BEGIN
    INSERT INTO menu ( menu_name, category, price)
    VALUES (@MenuName, @Category, @Price);
END;
GO

-- Usage:
-- EXEC AddMenu 'Menu Name', 'Category', 100.00;

-- Procedure untuk menambahkan penjualan tanpa parameter total_price
CREATE PROCEDURE AddSale
    @BranchID INT,
    @MenuID INT,
    @SaleDate DATETIME,
    @Quantity INT,
    @PaymentMethod VARCHAR(50)
AS
BEGIN
    INSERT INTO sales (branch_id, menu_id, sale_date, quantity, payment_method)
    VALUES (@BranchID, @MenuID, @SaleDate, @Quantity, @PaymentMethod);
END;
GO

-- Usage:
-- EXEC AddSale 1, 1, '2023-01-01 12:00:00', 2, 'Cash';


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
-- EXEC AddOperationalCost 1, '2024-12-01', 'Utilities', 500.00, 'Notes';
