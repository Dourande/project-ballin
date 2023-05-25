CREATE TABLE MEMBERS (
    NAME VARCHAR(20) NOT NULL,
    ADDRESS VARCHAR(100) NOT NULL,
    PHONE_NUMBER VARCHAR(20),
    EMAIL VARCHAR(100) NOT NULL,
    ID INT(4) ZEROFILL PRIMARY KEY
);

INSERT INTO MEMBERS (NAME, ADDRESS, PHONE_NUMBER, EMAIL, ID)
VALUES
    ('John Smith', '123 Main St.', '4081234567', 'john@example.com', 1001),
    ('Emma Johnson', '456 Elm St.', '4089876543', 'emma@example.com', 1002),
    ('Michael Davis', '789 Oak St.', '4084567890', 'michael@example.com', 1003),
    ('Sarah Wilson', '321 Pine St.', '4085551234', 'sarah@example.com', 1004),
    ('David Thompson', '654 Maple St.', '4087778888', 'david@example.com', 1005),
    ('Jennifer Anderson', '987 Birch St.', '4082223333', 'jennifer@example.com', 1006),
    ('Christopher Martin', '654 Walnut St.', '4084445555', 'christopher@example.com', 1007),
    ('Jessica Taylor', '321 Cedar St.', '4089990000', 'jessica@example.com', 1008),
    ('Matthew Harris', '654 Ash St.', '4081112222', 'matthew@example.com', 1009),
    ('Emily Clark', '987 Pine St.', '4083334444', 'emily@example.com', 1010),
    ('Daniel Walker', '654 Oak St.', '4086667777', 'daniel@example.com', 1011);

