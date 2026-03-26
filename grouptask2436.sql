CREATE DATABASE `IS436` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE Category (
    category_id INT,
    category_name VARCHAR(100),
    primary key (category_id)
);

CREATE TABLE Product (
    product_id INT,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10,2),
    category_id INT,
    primary key (product_id),
    foreign key (category_id) references Category(category_id)
);

CREATE TABLE Product_Image (
    image_id INT,
    product_id INT,
    image_url VARCHAR(255),
    primary key (image_id),
    foreign key (product_id) references Product(product_id)
);

CREATE TABLE Customer (
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    primary key (customer_id)
);

CREATE TABLE Review (
    review_id INT,
    product_id INT,
    customer_id INT,
    rating INT,
    comment TEXT,
    primary key (review_id),
    foreign key (product_id) references Product(product_id),
    foreign key (customer_id) references Customer(customer_id)
);

CREATE TABLE Cart (
    cart_id INT,
    customer_id INT,
    primary key (cart_id),
    foreign key (customer_id) references Customer(customer_id)
);

CREATE TABLE Cart_Item (
    cart_item_id INT,
    cart_id INT,
    product_id INT,
    quantity INT,
    primary key (cart_item_id),
    foreign key (cart_id) references Cart(cart_id),
    foreign key (product_id) references Product(product_id)
);

CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    primary key (order_id),
    foreign key (customer_id) references Customer(customer_id)
);

CREATE TABLE Order_Item (
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    primary key (order_item_id),
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Product(product_id)
);

insert into Category values
(1, 'Foosball Balls'),
(2, 'Accessories'),
(3, 'Kits');

insert into Product values
(1, 'Deluxe Ball Kit', 'High-quality foosball balls set', 19.99, 3),
(2, 'Pro Foosball Ball', 'Professional grade ball', 5.99, 1),
(3, 'Foosball Handle Grip', 'Comfortable grip', 7.99, 2);

insert into Product_Image values
(1, 1, 'img1.jpg'),
(2, 1, 'img2.jpg'),
(3, 2, 'img3.jpg');

insert into Customer values
(1, 'John Doe', 'john@email.com'),
(2, 'Jane Smith', 'jane@email.com'),
(3, 'Ali Khan', 'ali@email.com');

insert into Review values
(1, 1, 1, 5, 'Great quality'),
(2, 1, 2, 4, 'Good value'),
(3, 2, 3, 5, 'Excellent');

insert into Cart values
(1, 1),
(2, 2);

insert into Cart_Item values
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 3, 3);

insert into Orders values
(1, 1, '2026-03-20', 45.97),
(2, 2, '2026-03-21', 23.97);

insert into Order_Item values
(1, 1, 1, 2, 19.99),
(2, 1, 2, 1, 5.99),
(3, 2, 3, 3, 7.99);
