-- Trigger
-- Membuat tabel log untuk mencatat perubahan harga menu
CREATE TABLE menu_price_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    menu_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date DATETIME DEFAULT GETDATE()
);

-- Membuat trigger untuk mencatat perubahan harga menu
DELIMITER $$
CREATE TRIGGER log_menu_price_change 
    BEFORE UPDATE 
    ON menu
    FOR EACH ROW 
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO menu_price_log (menu_id, old_price, new_price, change_date)
        VALUES (OLD.menu_id, OLD.price, NEW.price, NOW());
    END IF;
END$$
DELIMITER ;

-- Membuat trigger untuk memperbarui daily_revenue setelah penjualan baru ditambahkan
DELIMITER $$
CREATE TRIGGER update_daily_revenue_after_sale 
    AFTER INSERT 
    ON sales
    FOR EACH ROW 
BEGIN
    DECLARE revenue_exists INT;
    
    -- Cek apakah ada record untuk tanggal dan cabang yang sama di daily_revenue
    SELECT COUNT(*) INTO revenue_exists
    FROM daily_revenue
    WHERE branch_id = NEW.branch_id
    AND revenue_date = DATE(NEW.sale_date);

    IF revenue_exists > 0 THEN
        -- Update record yang sudah ada
        UPDATE daily_revenue
        SET total_revenue = total_revenue + NEW.total_price,
            total_customers = total_customers + 1
        WHERE branch_id = NEW.branch_id
        AND revenue_date = DATE(NEW.sale_date);
    ELSE
        -- Insert record baru
        INSERT INTO daily_revenue (branch_id, revenue_date, total_revenue, total_customers, payment_method, notes)
        VALUES (NEW.branch_id, DATE(NEW.sale_date), NEW.total_price, 1, NEW.payment_method, '');
    END IF;
END$$
DELIMITER ;