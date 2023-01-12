USE dealership;

INSERT INTO cylinders(cylinder)
VALUES ('L4');


INSERT INTO make(make)
VALUES ('Buick'),
('Chevrolet'), ('Chrysler'), ('Dodge'),
('Hummer'), ('Jeep'), ('Ram'), ('Saturn'),
('Tesla'), ('Acura'), ('Honda'), ('Hyundai'),
('Lexus'), ('Mazda'), ('Nissan'), ('Subaru');

INSERT INTO model(model)
VALUES ('Rogue'), ('Titan'), ('Altima'),
('Frontier'), ('Atenza'), ('CX-3'), ('Axela'),
('Demio'), ('Renegade'), ('Compass'), ('Wrangler');

INSERT INTO transmission(transmission)
VALUES ('9 Speed Automatic');

CREATE table makeModel(
    makeID int not null,
    modelId int not null,
    PRIMARY KEY(makeID, modelId),
);

ALTER table makeModel
ADD FOREIGN KEY (makeID) REFERENCES make(ID);

ALTER table makeModel
ADD FOREIGN KEY (modelId) REFERENCES model(ID);

INSERT into makeModel(makeID)
SELECT DISTINCT ID from make;

INSERT into makeModel(model)
SELECT DISTINCT ID from model;



///////////////////////


USE dealership;

CREATE table cityState(
    city varchar(90) not null,
    STATE char(2) not null,
    zipCode char(5) not null UNIQUE
    PRIMARY KEY(zipCode)
);

INSERT into cityState(city, STATE, zipCode)
VALUES ('Piscataway', 'NJ', '08854'),
('Clover', 'SC', '29710'),
('Duluth', 'GA', '30096'),
('Nashville', 'TN', '37205'),
('Willoughby', 'OH', '44094'),
('Jupiter', 'FL', '33458'),
('Huntington Beach', 'CA', '92647'),
('Memphis', 'TN', '38117'),
('Abingdon', 'VA', '24210'),
('San Marcos', 'CA', '92078'),
('Jefferson', 'LA', '70121'),
('Covington', 'LA', '70433'),
('Ontario', 'CA', '91764'),
('Cuyahoga Falls', 'OH', '44223'),
('Battle Creek', 'MI', '49016'),
('Scottsdale', 'AZ', '85260'),
('Glenarden', 'MD', '20706');

ALTER TABLE employee
ADD FOREIGN KEY(zipCode) REFERENCES cityState(zipCode);

ALTER TABLE customers
ADD FOREIGN KEY(zipCode) REFERENCES cityState(zipCode);


CREATE view customerView AS
SELECT customers.firstName, customers.lastName, customers.address,
cityState.city, cityState.state, customers.zipCode, customers.phone, customers.email
from customers, cityState
where customers.zipcode=cityState.zipCode;

CREATE view employeeView AS
SELECT employee.firstName, employee.lastName, employee.address,
cityState.city, cityState.state, employee.zipCode,
employee.phone, employee.email
from employee, cityState
where employee.zipCode=cityState.zipCode;

CREATE table sale(
    employeeID int not null,
    customerID int not null,
    vehicleID int not null,
    salePrice decimal(8,2) not null,
    PRIMARY KEY(employeeID, customerID, vehicleID),
    FOREIGN KEY(employeeID) REFERENCES employee(ID),
    FOREIGN KEY(customerID) REFERENCES customers(ID),
    FOREIGN KEY(vehicleID) REFERENCES vehicle(ID)
);