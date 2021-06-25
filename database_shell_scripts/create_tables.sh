#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
CREATE TABLE Person (
    BirthDate DATE,
    Email VARCHAR2(20) NULL,
    Phone VARCHAR2(25),
    FirstName VARCHAR2(20) NULL,
    LastName VARCHAR2(20) NULL,
    PostalCode VARCHAR2(6),
    Province VARCHAR2(20),
    City VARCHAR2(20),
    Country VARCHAR2(20),
    StreetNumber INT,
    StreetName VARCHAR2(20),
    PRIMARY KEY (email)
);


CREATE TABLE Membership (
    MembershipId INT,
    NumOfBooksAllowed INT NOT NULL,
    MembershipExpiration DATE,
    MembershipName VARCHAR2(10),
    PRIMARY KEY (MembershipId)
);

CREATE TABLE PaymentMethod(
    PaymentMethodId INT PRIMARY KEY,
    PaymentType VARCHAR(10)
);

CREATE TABLE Customer(
    CustomerId INT PRIMARY KEY,
    Email VARCHAR(20),
    PaymentMethodId INT,
    MembershipId Int,
    FOREIGN KEY(Email) REFERENCES Person(Email) ON DELETE CASCADE,
    FOREIGN KEY(PaymentMethodId) REFERENCES PaymentMethod(PaymentMethodId) ON DELETE CASCADE,
    FOREIGN KEY(MembershipId) REFERENCES Membership(MembershipId) ON DELETE CASCADE
);


CREATE TABLE LibraryItem (
    ItemId INT,
    Genre VARCHAR(20),
    AvailabilityStatus INT NOT NULL,
    DatePublished DATE NOT NULL,
    Rating INT,
    PRIMARY KEY(ItemId)
);


CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Author VARCHAR(20) NOT NULL,
    LibraryItemNumber INT NOT NULL,
    FOREIGN KEY(LibraryItemNumber) REFERENCES LibraryItem(ItemId) ON DELETE CASCADE
);

CREATE TABLE Videos (
    VideoId INT PRIMARY KEY,
    LibraryItemNumber INT NOT NULL,
    ProductionStudio VARCHAR(20) NOT NULL,
    KeyCast VARCHAR(20),
    Director VARCHAR(20) NOT NULL,
    FOREIGN KEY(LibraryItemNumber) REFERENCES LibraryItem(ItemId) ON DELETE CASCADE
);


CREATE TABLE RentalOrder(
    LibraryItemId INT,
    PaymentMethodId INT,
    CustomerId INT,
    Quantity INT not NULL,
    OverdueAmount INT,
    ReturnDate DATE,
    RentalDate DATE,
    FOREIGN KEY(LibraryItemId) REFERENCES LibraryItem(ItemId) ON DELETE CASCADE,
    FOREIGN KEY(PaymentMethodId) REFERENCES PaymentMethod(PaymentMethodId) ON DELETE CASCADE,
    FOREIGN KEY(CustomerId) REFERENCES Customer(CustomerId) ON DELETE CASCADE
);


CREATE TABLE Suppliers(
    SupplierId INT NOT NULL PRIMARY KEY,
    SupplierName VARCHAR(40) NOT NULL
);


CREATE TABLE  SupplierItems(
    SupplierItemId INT NOT NULL PRIMARY KEY,
    SupplierId INT NOT NULL,
    ItemName VARCHAR(40),
    ItemType VARCHAR(40),
    FOREIGN KEY(SupplierId) REFERENCES Suppliers(SupplierId) ON DELETE SET NULL
);

CREATE TABLE Orders(
    OrderId INT NOT NULL PRIMARY KEY,
    SupplierId INT NOT NULL,
    SupplierItemId INT NOT NULL,
    OrderStatus INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate DATE,
    FOREIGN KEY(SupplierId) REFERENCES Suppliers(SupplierId) ON DELETE SET NULL,
    FOREIGN KEY(SupplierItemId) REFERENCES SupplierItems(SupplierItemId) ON DELETE SET NULL
);


CREATE TABLE Employee(
    EmployeeId INT NOT NULL PRIMARY KEY,
    ManagerId VARCHAR(40),
    Email VARCHAR(20) not NULL,
    FOREIGN KEY(email) REFERENCES Person(email) ON DELETE SET NULL
);


  exit;
EOF
