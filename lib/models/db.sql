CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT,
    password TEXT,
    prenom TEXT,
    lang TEXT
);

CREATE TABLE task_groups (
    id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT
);

CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    name TEXT,
    creation_date TEXT,
    is_ok INTEGER,
    modification_date TEXT,
    detail TEXT,
    user_id INTEGER,
    group_id INTEGER,
    priority INTEGER,
    status TEXT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(group_id) REFERENCES task_groups(id)
);

CREATE TABLE task_schedules (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    start_date TEXT,
    duration INTEGER,
    end_date TEXT,
    start_time TEXT,
    end_time TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE task_schedule_days (
    id INTEGER PRIMARY KEY,
    schedule_id INTEGER,
    day_of_week TEXT,
    start_time TEXT,
    end_time TEXT,
    FOREIGN KEY(schedule_id) REFERENCES task_schedules(id)
);

CREATE TABLE task_reports (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    date TEXT,
    completed INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE task_tags (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    tag TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE task_attachments (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    file_path TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE task_actions_history (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    action TEXT,
    action_date TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE task_collaborators (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
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

-- Table de liaison entre les tâches et les transactions
CREATE TABLE task_transactions (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    transaction_id INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(id),
    FOREIGN KEY(transaction_id) REFERENCES transactions(id)
);

-- Table de liaison entre les tâches et les budgets
CREATE TABLE task_budgets (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    budget_id INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(id),
    FOREIGN KEY(budget_id) REFERENCES budgets(id)
);

-- Insertions par défaut
INSERT INTO users(username, password, prenom, lang) VALUES("test", "1234", "John Doe", "fr");

INSERT INTO task_groups(name, description) VALUES("Groupe de tâches par défaut", "Description du groupe de tâches par défaut");

INSERT INTO tasks(name, creation_date, is_ok, modification_date, detail, user_id, group_id, priority, status) VALUES("Tâche par défaut", "2024-03-31", 0, "2024-03-31", "Détail de la tâche par défaut", 1, 1, 1, "En cours");

INSERT INTO task_schedules(task_id, start_date, duration, end_date, start_time, end_time) VALUES(1, "2024-03-31", 1, "2024-04-01", "09:00", "17:00");

INSERT INTO task_reports(task_id, date, completed) VALUES(1, "2024-03-31", 0);

INSERT INTO task_tags(task_id, tag) VALUES(1, "Tag de tâche par défaut");

INSERT INTO task_attachments(task_id, file_path) VALUES(1, "/chemin/vers/la/piece_jointe");

INSERT INTO task_actions_history(task_id, action, action_date) VALUES(1, "Action de tâche par défaut", "2024-03-31");

INSERT INTO task_collaborators(task_id, user_id) VALUES(1, 1);
