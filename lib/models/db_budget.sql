-- Table des utilisateurs
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT UNIQUE,
    password TEXT,
    email TEXT UNIQUE
);

-- Table des catégories de dépenses
CREATE TABLE expense_categories (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE
);

-- Table des méthodes de paiement
CREATE TABLE payment_methods (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE
);

-- Table des transactions
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    category_id INTEGER,
    payment_method_id INTEGER,
    amount REAL,
    date TEXT,
    note TEXT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(category_id) REFERENCES expense_categories(id),
    FOREIGN KEY(payment_method_id) REFERENCES payment_methods(id)
);

-- Table des budgets
CREATE TABLE budgets (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    category_id INTEGER,
    amount REAL,
    start_date TEXT,
    end_date TEXT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(category_id) REFERENCES expense_categories(id)
);
