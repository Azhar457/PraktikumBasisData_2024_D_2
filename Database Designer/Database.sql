-- Membuat Database
CREATE TABLE branches (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10),
    phone VARCHAR(15),
    opening_date DATE
);

CREATE TABLE daily_revenue (
    revenue_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT FOREIGN KEY REFERENCES branches(branch_id),
    revenue_date DATE NOT NULL,
    total_revenue DECIMAL(15,2) NOT NULL,
    total_customers INT,
    payment_method VARCHAR(50),
    notes TEXT
);

CREATE TABLE menu (
    menu_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT FOREIGN KEY REFERENCES branches(branch_id),
    menu_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    is_available BIT DEFAULT 1
);

CREATE TABLE sales (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT FOREIGN KEY REFERENCES branches(branch_id),
    menu_id INT FOREIGN KEY REFERENCES menu(menu_id),
    sale_date DATETIME DEFAULT GETDATE(),
    quantity INT NOT NULL,
    total_price DECIMAL(15,2) NOT NULL,
    payment_method VARCHAR(50)
);

CREATE TABLE operational_costs (
    cost_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT FOREIGN KEY REFERENCES branches(branch_id),
    cost_date DATE NOT NULL,
    cost_category VARCHAR(50) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    notes TEXT
); 