-- Trigger
-- Membuat trigger untuk Memvalidasi total_price sebelum insert atau update pada tabel sales
CREATE TRIGGER validate_total_price
ON sales
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    DECLARE @menu_price DECIMAL(10,2);
    DECLARE @menu_id INT;
    DECLARE @quantity INT;
    DECLARE @total_price DECIMAL(15,2);
    DECLARE @branch_id INT;
    DECLARE @sale_date DATETIME;
    DECLARE @payment_method VARCHAR(50);

    -- Ambil harga menu dari tabel menu
    SELECT @menu_price = price
    FROM menu
    WHERE menu_id = (SELECT menu_id FROM inserted);

    -- Ambil nilai dari inserted
    SELECT 
        @menu_id = menu_id,
        @quantity = quantity,
        @branch_id = branch_id,
        @sale_date = sale_date,
        @payment_method = payment_method
    FROM inserted;

    -- Hitung total_price berdasarkan harga menu dan quantity
    SET @total_price = @menu_price * @quantity;

    -- Insert atau update ke tabel sales
    IF EXISTS (SELECT 1 FROM sales WHERE sale_id = (SELECT sale_id FROM inserted))
    BEGIN
        UPDATE sales
        SET 
            menu_id = @menu_id,
            quantity = @quantity,
            total_price = @total_price,
            branch_id = @branch_id,
            sale_date = @sale_date,
            payment_method = @payment_method
        WHERE sale_id = (SELECT sale_id FROM inserted);
    END
    ELSE
    BEGIN
        INSERT INTO sales (branch_id, menu_id, sale_date, quantity, total_price, payment_method)
        VALUES (@branch_id, @menu_id, @sale_date, @quantity, @total_price, @payment_method);
    END
END;
GO

-- Usage:
-- INSERT INTO sales (branch_id, menu_id, sale_date, quantity, payment_method)
-- VALUES (1, 5, '2024-12-01 10:30:00', 10, 'Cash');

-- membuat trigger untuk menghapus data dari tabel sales jika total_price = 0
CREATE TRIGGER delete_sales
ON sales
AFTER INSERT, UPDATE
AS
BEGIN
    DELETE FROM sales
    WHERE total_price = 0;
END;
GO

-- Usage:
-- INSERT INTO sales (branch_id, menu_id, sale_date, quantity, payment_method)
-- VALUES (1, 5, '2024-12-01 10:30:00', 0, 'Cash');
