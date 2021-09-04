Set global log_output= 'File';
set global general_log_file='C:/Users/Devraj.Gajurel/Desktop/general-query.log';
set global general_log=1;


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



-- -----------------------------------------------------
-- Schema resturant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Resturant` DEFAULT CHARACTER SET utf8 ;
USE `Resturant` ;

-- -----------------------------------------------------
-- Table `resturant`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`address` (
  `Address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Sreet` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NULL DEFAULT NULL,
  `Zip_Code` INT(5) NULL DEFAULT NULL,
  `State` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`Address_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`customer` (
  `Customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(25) NOT NULL,
  `Last_name` VARCHAR(25) NOT NULL,
  `Phone_No` VARCHAR(13) NULL DEFAULT NULL,
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`employeetype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`employeetype` (
  `EmployeeTypeID` INT(11) NOT NULL,
  `Description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeTypeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`employee` (
  `Employee_id` INT(11) NOT NULL,
  `First_name` VARCHAR(25) NOT NULL,
  `Last_name` VARCHAR(25) NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `AddressId` INT(11) NOT NULL,
  `EmployeeTypeId` INT(11) NOT NULL,
  PRIMARY KEY (`Employee_id`, `EmployeeTypeId`),
  INDEX `Address_id_idx` (`AddressId` ASC) ,
  INDEX `UserTypeID_idx` (`EmployeeTypeId` ASC) ,
  CONSTRAINT `Address_id`
    FOREIGN KEY (`AddressId`)
    REFERENCES `resturant`.`address` (`Address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserTypeID`
    FOREIGN KEY (`EmployeeTypeId`)
    REFERENCES `resturant`.`employeetype` (`EmployeeTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`table` (
  `Table_id` INT(11) NOT NULL,
  `max_capacity` ENUM('1', '2', '3', '4', '5', '6', '7') NOT NULL,
  `Is_Booked` TINYINT(4) NOT NULL,
  PRIMARY KEY (`Table_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`kwik_kiosk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`kwik_kiosk` (
  `Kiosk_id` INT(11) NOT NULL,
  `order_placed` DATETIME NULL,
  `TableId` INT(11) NOT NULL,
  `CustomerId` INT(11) NOT NULL,
  `EmployeeId` INT(11) NOT NULL,
  PRIMARY KEY (`Kiosk_id`, `EmployeeId`, `CustomerId`, `TableId`),
  INDEX `Table_id_idx` (`TableId` ASC) ,
  INDEX `Customer_id_idx` (`CustomerId` ASC) ,
  INDEX `Employee_id_idx` (`EmployeeId` ASC) ,
  CONSTRAINT `Customerid`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `resturant`.`customer` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Employeeid`
    FOREIGN KEY (`EmployeeId`)
    REFERENCES `resturant`.`employee` (`Employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Table_id`
    FOREIGN KEY (`TableId`)
    REFERENCES `resturant`.`table` (`Table_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`meals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`meals` (
  `Meal_id` INT(11) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Category` VARCHAR(15) NOT NULL,
  `Price` DOUBLE NOT NULL,
  PRIMARY KEY (`Meal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`serves`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`serves` (
  `Ordered_date` DATETIME NOT NULL,
  `EmployeeID` INT(11) NOT NULL,
  `CustomerId` INT(11) NOT NULL,
  PRIMARY KEY (`CustomerId`, `EmployeeID`),
  INDEX `Employee_id_idx` (`EmployeeID` ASC) ,
  INDEX `Customer_id_idx` (`CustomerId` ASC) ,
  CONSTRAINT `Cust_id`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `resturant`.`customer` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Emp_id`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `resturant`.`employee` (`Employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resturant`.`employee_prepares_meals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resturant`.`employee_prepares_meals` (
  `Employee_id` INT(11) NOT NULL,
  `Meal_id` INT(11) NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`Employee_id`, `Meal_id`),
  INDEX `fk_employee_has_meals_meals1_idx` (`Meal_id` ASC) ,
  INDEX `fk_employee_has_meals_employee1_idx` (`Employee_id` ASC) ,
  CONSTRAINT `fk_employee_has_meals_employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `resturant`.`employee` (`Employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_meals_meals1`
    FOREIGN KEY (`Meal_id`)
    REFERENCES `resturant`.`meals` (`Meal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

set global general_log=0;
-- -----------------------------------------------------
-- Data for table `resturant`.`address`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (1, '#1 Post Office Road, Suite 101', 'WALDORF', 20602, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (2, '#19 East Side Square', 'MACOMB', 61455, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (3, '#2 North Lake, Suite #945', 'PASADENA', 91101, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (4, '#2 Park Plaza, Suite 1100', 'IRVINE', 92614, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (5, '#37 Lindenleaf Ln.', 'BELLEVILLE', 62223, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (6, '#4 Bradley Park Court, suite 3-B', 'COLUMBUS', 31904, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (9, '.550 North Brand Blvd.,  #950', 'GLENDALE', 91203, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (10, '0150 Swissvale Rd.', 'SALIDA', 81201, 'CO');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (14, '1 Centerpointe Dr. #210', 'LA PALMA', 90623, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (15, '1 Centerpointe Dr. #260', 'LA PALMA', 90623, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (16, '1 Columbus Ctr.', 'VIRGINIA BEACH', 23462, 'VA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (17, '1 Commerce Sq., Ste 3510', 'PHILADELPHIA', 19103, 'PA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (19, '1 Corporate Blvd', 'BELLEVILLE', 62226, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (20, '1 Court Sq., Ste 290', 'HARRISONBURG', 22802, 'VA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (21, '1 Drake Knoll Rd, P.O. Box 206', 'LEWES', 19958, 'DE');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (23, '1 East Scott Street, Suite 1111', 'CHICAGO', 60610, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (24, '1 East Wacker', 'CHICAGO', 60601, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (25, '1 Executive Boulevard', 'YONKERS', 10701, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (26, '1 Executive Ctr Court S-110', 'LITTLE ROCK', 72211, 'AR');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (32, '1 Executive Drive', 'SOMERSET', 08875, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (33, '1 Fedarelli Square', 'NEW KENSINGTON', 15068, 'PA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (38, '1 Feldarelli Square', 'NEW KENSINGTON', 15068, 'PA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (41, '1 Greenway Plaza #1110', 'HOUSTON', 77046, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (42, '1 Greenwood Sq. Ste 220', 'BENSALEM', 19020, 'PA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (43, '1 Hampton Rd Bldg B S-307', 'EXETER', 03833, 'NH');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (62, '1 Independent Dr, suite 2901', 'JACKSONVILLE', 32202, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (64, '1 Independent Dr., suite 2901', 'JACKSONVILLE', 32202, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (65, '1 Independent Drive Suite 2901', 'JACKSONVILLE', 32202, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (66, '1 Indian Road', 'DENVILLE', 07834, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (68, '1 Kaiser Plaza #1333', 'OAKLAND', 94612, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (69, '1 Kalisa Way - Suite 202', 'PARAMUS', 07652, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (70, '1 Market Spear Street Tower, Ste. 6', 'SAN FRANCISCO', 94105, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (71, '1 Maryland Avenue', 'GAITHERSBURG', 20877, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (72, '1 N Dale Mabry #1100', 'TAMPA', 33609, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (74, '1 N Dale Mabry Hwy', 'TAMPA', 33609, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (75, '1 North 7th', 'PEKIN', 61554, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (77, '1 North Broadway, Suite 601', 'WHITE PLAINS', 10601, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (78, '1 NORTH DEARBORN, SUITE 1300', 'CHICAGO', 60602, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (79, '1 Old Country Rd Suite LL1', 'CARLE PLACE', 11514, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (81, '1 Ridenour Court', 'TOWSON', 21204, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (82, '1 Riverway, Suite 900', 'HOUSTON', 77056, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (83, '1 South Main St.', 'DAYTON', 45402, 'OH');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (84, '1 South Nevada Ave Suite 202', 'COLORADO SPRINGS', 80903, 'CO');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (87, '1 Tellina St', 'BAY CITY', 77414, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (88, '1 Tower Center - 16th floor', 'EAST BRUNSWICK', 08816, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (89, '1 TOWER CENTER BLVD 16TH FLOOR', 'EAST BRUNSWICK', 08816, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (90, '1506, Stelton Road', 'PISCATAWAY', 08854, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (91, '1 University Plaza', 'HACKENSACK', 07601, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (92, '1 W 4th St. Ste. 110', 'CINCINNATI', 45202, 'OH');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (93, '1 W Pennsylvania Ave Suite 300', 'TOWSON', 21204, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (94, '1 W. Elliot Rd. Ste. 114', 'TEMPE', 85284, 'AZ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (95, '1 W. Pennsylvania Avenue, Suite 300', 'TOWSON', 21204, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (96, '1 World Trade Center #2340', 'LONG BEACH', 90813, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (97, '10 Boars Head Road', 'FLEMINGTON', 08822, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (98, '10 Charles St', 'PROVIDENCE', 02904, 'RI');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (111, '10 E. Ontario Suite 2211', 'CHICAGO', 60611, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (112, '10 East 40th St., 25th Fl.', 'NEW YORK', 10016, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (113, '10 east Baltimore Street, Ste 1102', 'BALTIMORE', 21202, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (114, '10 Fairway Drive  Suite 303', 'DEERFIELD BEACH', 33441, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (115, '10 Franklin Rd. SE, Ste 575', 'ROANOKE', 24011, 'VA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (116, '10 Fringe Ct. Pob 2012', 'NEW CITY', 10956, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (117, '10 Joan Lane', 'MONSEY', 10952, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (119, '10 Lanidex Center West', 'PARSIPPANY', 07054, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (122, '10 Lanidex Center West, 3rd Floor', 'PARSIPPANY', 07054, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (123, '10 Lanidex Center West, Parsippany', 'PARSIPPANY', 07054, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (124, '10 Lanidex Center West, PO Box 608', 'PARSIPPANY', 07054, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (125, '10 Macarthur Road', 'FRANKLIN', 02038, 'MA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (126, '10 Manor Dr.', 'MAHWAH', 07430, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (127, '10 Maple St P.O. Box 56', 'FRANKLIN', 13775, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (128, '10 marmac Dt', 'LOVELAND', 80538, 'CO');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (129, '10 Martingale Road, Suite 400', 'SCHAUMBURG', 60173, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (130, '10 Mechanic St  Suite 400', 'WORCESTER', 01608, 'MA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (131, '10 Midland Ave', 'PORT CHESTER', 10573, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (132, '10 Ministerial Drive', 'MERRIMACK', 03054, 'NH');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (134, '10 N Calvert Street   Suite 540', 'BALTIMORE', 21202, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (135, '10 N Park Dr., Ste 400', 'COCKEYSVILLE', 21030, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (136, '10 N. Martingale Rd.', 'SCHAUMBURG', 60173, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (137, '10 N. Martingale Rd., 4th Floor', 'SCHAUMBURG', 60173, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (138, '10 Norrans Ridge Drive', 'RIDGEFIELD', 06877, 'CT');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (139, '10 Orchard Rd.', 'POMPTON PLAINS', 07444, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (141, '10 S. Jefferson St.', 'ROANOKE', 24011, 'VA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (142, '10 S. Lasalle Street Suite 3000', 'CHICAGO', 60603, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (143, '10 Saratoga', 'ALAMO', 94507, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (145, '80 Crossways Pk dr W', 'WOODBURY', 11797, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (146, '10 South Middle Neck Road', 'GREAT NECK', 11021, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (147, '10 Tower Drive', 'EAST HANOVER', 07936, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (148, '10 Trailsend Drive P.O. Box 433', 'CANTON', 06019, 'CT');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (149, '10 Twin Dolphin Drive Ste. B-500', 'REDWOOD CITY', 94065, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (150, '10 Universal City Plaza #2250', 'UNIVERSAL CITY', 91608, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (151, '10 Universal City Plaza, #2250', 'UNIVERSAL CITY', 91608, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (152, '10 UNIVERSAL PLAZA STE. 2250', 'UNIVERSAL CITY', 91608, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (154, '100 Austin Ave Suite 105', 'WEATHERFORD', 76086, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (155, '100 Bell Springs Rd', 'DRIPPING SPRINGS', 78620, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (156, '100 Broadway #100', 'GLENDALE', 91210, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (157, '100 Century Center Court, Suite 501', 'SAN JOSE', 95112, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (158, '100 CITY CENTER', 'OSHKOSH', 54901, 'WI');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (159, '100 Commercial Circle, Bldg B', 'CONROE', 77304, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (160, '100 Congress Ave, Suite 1520', 'AUSTIN', 78701, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (161, '100 Congress Ave. Ste. 250', 'AUSTIN', 78701, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (162, '100 Corporate Pointe #119', 'CULVER CITY', 90230, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (163, '100 Crescent Centre Parkway', 'TUCKER', 30084, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (164, '100 Cummings Center, # 101 F', 'BEVERLY', 01915, 'MA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (165, '100 Deerpath Court', 'OLDSMAR', 34677, 'FL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (166, '100 E RiverCenter Blvd', 'COVINGTON', 41011, 'KY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (167, '100 E Rivercenter Blvd. Ste. 1000', 'COVINGTON', 41011, 'KY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (168, '100 E Thousand Oaks Blvd', 'THOUSAND OAKS', 91362, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (170, '100 E. Corsicana St., Suite 211', 'ATHENS', 75751, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (171, '100 E. Telephone St.', 'SYLVANIA', 30467, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (172, '100 E. Thousand Oaks Blvd.,#187', 'THOUSAND OAKS', 91360, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (173, '100 East Thousand Oaks Blvd. #232', 'THOUSAND OAKS', 91360, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (174, '100 Enterprise Drive, Suite 160', 'ROCKAWAY', 07866, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (178, '100 Foden Road 203 West', 'SOUTH PORTLAND', 04106, 'ME');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (188, '100 Great Meadow Rd 2nd Fl', 'WETHERSFIELD', 06109, 'CT');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (196, '100 Harrow Lane  Suite 100', 'PRINCE FREDERICK', 20678, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (197, '100 Helfenbein Lane Suite 200', 'CHESTER', 21619, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (198, '100 I - 45 N. L.-p. Tower - B', 'CONROE', 77301, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (200, '100 Main St', 'AGAWAM', 01001, 'MA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (201, '100 Market Street, Suite 402', 'PORTSMOUTH', 03801, 'NH');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (203, '100 Matawan Rd., #130', 'MATAWAN', 07747, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (206, '100 Misty Lane', 'PARSIPPANY', 07054, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (207, '100 N Brand Blvd #200', 'GLENDALE', 91203, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (208, '100 N E Loop 410 S-1050', 'SAN ANTONIO', 78216, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (213, '100 N Riverside', 'CHICAGO', 60606, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (214, '100 N Stone Ave.  #1', 'TUCSON', 85701, 'AZ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (215, '100 N Washington', 'KOKOMO', 46901, 'IN');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (216, '100 N. 1st Street Ste. 301', 'BURBANK', 91502, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (217, '100 N. Brand Blvd., Suite 200', 'GLENDALE', 91203, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (218, '100 N. Citrus St. #620', 'WEST COVINA', 91791, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (219, '100 Nagog Pk 2nd Fl S-208', 'ACTON', 01720, 'MA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (226, '100 North Citrus Ave. # 340', 'WEST COVINA', 91791, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (227, '100 North Winchester Blvd., # 260', 'SANTA CLARA', 95050, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (228, '100 Oceangate Blvd. #401', 'LONG BEACH', 90802, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (229, '100 Oceangate Blvd., #401', 'LONG BEACH', 90802, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (230, '100 Oceangate Ste.#1200', 'LONG BEACH', 90802, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (231, '100 Oceangate, Suite 800', 'LONG BEACH', 90801, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (232, '100 Park Ave., #650', 'NEW YORK', 10017, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (233, '100 Park End Place', 'EAST ORANGE', 07018, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (234, '100 Park Place  Suite 220', 'SAN RAMON', 94583, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (235, '100 Pascoe Court', 'FOLSOM', 95630, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (236, '100 Patrick Dr. Jeannette, PA.', 'JEANNETTE', 15644, 'PA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (237, '100 Pine St Suite 250', 'SAN FRANCISCO', 94111, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (238, '100 Pine Street #3000', 'SAN FRANCISCO', 94111, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (239, '100 PINE STREET SUITE 3000', 'SAN FRANCISCO', 94111, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (258, '100 Pringle Ave Ste 450', 'WALNUT CREEK', 94596, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (259, '100 River Ridge Dr S-202', 'NORWOOD', 02062, 'MA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (263, '!351 Liberty Ave', 'HILLSIDE', 07205, 'NJ');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (266, '100 Riverfront Corporate Center Ste', 'BIRMINGHAM', 35243, 'AL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (267, '100 S Larkin Ave', 'JOLIET', 60436, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (268, '# 7 GIBSON PLACE', 'GAITHERSBURG', 20878, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (269, '100 S Main St', 'OCONOMOWOC', 53066, 'WI');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (270, '100 S Vincent Ave. 501#C', 'WEST COVINA', 91790, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (271, '100 S. Church St.', 'NEW CARLISLE', 45344, 'OH');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (272, '100 S. Main St.', 'OCONOMOWOC', 53066, 'WI');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (273, '#1 BRADLEY PARK COURT, SUITE C', 'COLUMBUS', 31904, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (274, '100 S. Prospect Avenue', 'PARK RIDGE', 60068, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (275, '100 S. Wacker', 'CHICAGO', 60610, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (276, '100 S. Wacker Dr. 16th Fl.', 'CHICAGO', 60606, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (277, '#1 POST OFFICE RD', 'WALDORF', 20602, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (278, '100 S. Wacker Dr., 16th Fl.', 'CHICAGO', 60606, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (279, '100 S. Wacker Drive, 16th Floor', 'CHICAGO', 60606, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (280, '100 S. Wacker, 16th Floor', 'CHICAGO', 60606, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (281, '100 Sedgewicke Drive', 'PEACHTREE CITY', 30269, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (282, '100 Smith Ranch Rd. Ste 104', 'SAN RAFAEL', 94903, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (283, '100 Smith Ranch Road  #110', 'SAN RAFAEL', 94903, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (284, '100 Smith Ranch Road Suite 122', 'SAN RAFAEL', 94903, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (285, '100 South Bedford Road', 'MOUNT KISCO', 10549, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (286, '100 South Broad Street', 'MONROE', 30655, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (287, '#1 N. 7th', 'PEKIN', 61554, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (288, '100 South Main Street', 'BAXLEY', 31513, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (289, '100 South Wacker Drive, 16th Floor', 'CHICAGO', 60606, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (292, '#1 Post Office Road', 'WALDORF', 20602, 'MD');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (293, '100 South West Washington St.', 'PEORIA', 61602, 'IL');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (294, '100 Stony Point Rd, Ste 210', 'SANTA ROSA', 95401, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (297, '100 Stony Point Road #130', 'SANTA ROSA', 95401, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (298, '100 Stony Point Road Ste 210', 'SANTA ROSA', 95401, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (299, '#4 Asbury Place', 'HOUSTON', 77007, 'TX');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (300, '100 Stony Point Road, suite 210', 'SANTA ROSA', 95401, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (301, ', 7130 Cresheim Road', 'PHILADELPHIA', 19119, 'PA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (302, '100 SUNNYSIDE BLVD.', 'WOODBURY', 11797, 'NY');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (303, '#5 BOAR\'S NEST LANE', 'SAVANNAH', 31411, 'GA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (304, '100 Tamal Plaza #190', 'CORTE MADERA', 94925, 'CA');
INSERT INTO `resturant`.`address` (`Address_id`, `Sreet`, `City`, `Zip_Code`, `State`) VALUES (305, '0093 J Rd.', 'SILVERTHORNE', 80498, 'CO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (1, 'Byrle', 'Asprey', '(352) 6527088');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (2, 'Francine', 'Beresfore', '(552) 1867675');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (3, 'Regen', 'Quirk', '(335) 7143829');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (4, 'Demetre', 'Bland', '(532) 6916002');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (5, 'Consolata', 'Rabjohns', '(521) 5757480');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (6, 'Thorny', 'Bruneton', '(270) 4474146');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (7, 'Bobbie', 'Bearne', '(375) 1999892');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (8, 'Jacklyn', 'Durie', '(466) 5456606');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (9, 'Wyatan', 'Chastel', '(760) 2063805');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (10, 'Niko', 'Wiltshaw', '(362) 3413020');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (11, 'Jandy', 'Preble', '(672) 6333452');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (12, 'Elwyn', 'MacAskie', '(741) 7422345');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (13, 'Celene', 'Bratcher', '(317) 6801522');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (14, 'Janette', 'Kunes', '(480) 4451300');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (15, 'Tomasine', 'Kavanagh', '(334) 1652313');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (16, 'Micki', 'Curnnok', '(195) 3130897');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (17, 'Jemima', 'Solley', '(726) 6523109');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (18, 'Maitilde', 'Rosie', '(330) 6959935');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (19, 'Barbey', 'Ipsgrave', '(116) 3840691');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (20, 'Vanessa', 'McCorry', '(843) 4201402');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (21, 'Vyky', 'Bawles', '(896) 2837652');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (22, 'Gray', 'Ohm', '(872) 9930942');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (23, 'Enriqueta', 'Tout', '(421) 1110609');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (24, 'Anet', 'Storrar', '(312) 6260776');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (25, 'Ingeberg', 'Friel', '(181) 7590416');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (26, 'Itch', 'Bradberry', '(253) 6715800');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (27, 'Cookie', 'Aisman', '(306) 1319308');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (28, 'Desirae', 'Rainton', '(779) 9162150');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (29, 'Kimberly', 'Gudge', '(526) 1429945');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (30, 'Garrott', 'Grishukhin', '(789) 5902658');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (31, 'Aubine', 'Chable', '(472) 8249946');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (32, 'Waldo', 'Newland', '(690) 2533333');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (33, 'Brnaba', 'Andreix', '(249) 7294275');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (34, 'Arda', 'Gonzalez', '(169) 5924640');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (35, 'Datha', 'Harnett', '(749) 7627116');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (36, 'Allene', 'Yakushkev', '(310) 8627454');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (37, 'Dorothee', 'Dunnett', '(230) 8317016');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (38, 'Costanza', 'Weetch', '(383) 7431071');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (39, 'Filide', 'Drysdell', '(532) 4957495');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (40, 'Art', 'Ralling', '(740) 1564755');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (41, 'Ralf', 'Nerne', '(210) 4958032');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (42, 'Dyann', 'Argile', '(312) 2092853');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (43, 'Natty', 'Longmire', '(197) 6066415');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (44, 'Samson', 'Manis', '(304) 5518888');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (45, 'Emelina', 'Sammut', '(391) 8170841');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (46, 'Brigitta', 'Berndtsson', '(436) 6433300');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (47, 'Kelly', 'Pourvoieur', '(208) 6357048');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (48, 'Selestina', 'Abbison', '(237) 5354559');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (49, 'Noel', 'Franklin', '(833) 1640383');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (50, 'Bunnie', 'Hamstead', '(217) 2854574');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (51, 'Thor', 'Higginbottam', '(839) 4955830');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (52, 'Michael', 'Hrinishin', '(278) 1842615');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (53, 'Katherine', 'Gorke', '(689) 7678759');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (54, 'Cori', 'Malthouse', '(144) 5295018');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (55, 'Lonni', 'Dredge', '(571) 2667270');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (56, 'Hillel', 'Gerger', '(715) 2091323');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (57, 'Wilfrid', 'Handling', '(724) 5744426');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (58, 'Reece', 'Mardlin', '(946) 6427782');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (59, 'Berk', 'Thompson', '(345) 2980771');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (60, 'Ricard', 'Tomkies', '(450) 1574940');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (61, 'Marys', 'Kynman', '(552) 7692596');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (62, 'Keven', 'Capoun', '(926) 6039740');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (63, 'Trish', 'Edelmann', '(291) 6396373');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (64, 'Hurlee', 'Locker', '(267) 3781550');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (65, 'Reta', 'Balderstone', '(191) 9427058');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (66, 'Manny', 'Issitt', '(693) 5921754');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (67, 'Rosie', 'Pessolt', '(355) 4104064');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (68, 'Corabelle', 'Learmont', '(900) 3581261');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (69, 'Ariela', 'Brookes', '(174) 4156279');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (70, 'Franciskus', 'Crenage', '(259) 6216577');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (71, 'Samson', 'Raselles', '(398) 2056514');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (72, 'Raynor', 'Bethel', '(822) 9825505');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (73, 'Joice', 'Pollen', '(483) 4335749');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (74, 'Thibaud', 'Ikins', '(765) 2196264');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (75, 'Auguste', 'Scuffham', '(896) 3561606');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (76, 'Holli', 'Minor', '(793) 2821630');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (77, 'Iona', 'Acomb', '(977) 3372151');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (78, 'Andy', 'Whymark', '(992) 4321830');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (79, 'Cleveland', 'Royce', '(143) 9470495');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (80, 'Kat', 'Raison', '(490) 4101497');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (81, 'Celka', 'Szabo', '(268) 3468744');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (82, 'Raynor', 'Bisacre', '(309) 8698292');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (83, 'Ara', 'Groucutt', '(975) 3822378');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (84, 'Artair', 'Vowell', '(247) 9529504');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (85, 'Micky', 'Ropcke', '(336) 4928217');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (86, 'Wolfie', 'Vink', '(219) 5575325');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (87, 'Elsie', 'Edwicke', '(216) 6934462');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (88, 'Giacomo', 'Gorler', '(156) 7342049');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (89, 'Torrie', 'Orneblow', '(736) 5649700');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (90, 'Vite', 'Fredi', '(884) 2919263');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (91, 'Mill', 'Villa', '(795) 5169197');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (92, 'Lorelei', 'Scholling', '(282) 9378429');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (93, 'Everard', 'Pitkeathley', '(925) 9911280');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (94, 'Faustina', 'Dibben', '(986) 2776642');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (95, 'Christopher', 'Althrope', '(730) 5898796');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (96, 'Moina', 'Grabeham', '(591) 3548743');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (97, 'Corney', 'Sapp', '(392) 8829080');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (98, 'Alister', 'Lambot', '(476) 7868744');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (99, 'Mildrid', 'Noulton', '(149) 3885346');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (100, 'Myrle', 'Kilday', '(104) 6876274');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (101, 'Lars', 'Boldison', '(866) 6194559');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (102, 'Domenic', 'Sergeant', '(688) 7906722');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (103, 'Ambrosius', 'Spacey', '(755) 8495638');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (104, 'Rollins', 'Avramovich', '(412) 3935140');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (105, 'Lian', 'Kopelman', '(277) 3804081');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (106, 'Costanza', 'MacGuigan', '(634) 3148368');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (107, 'Kakalina', 'Phillip', '(638) 2331052');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (108, 'Mitchael', 'Dibdin', '(135) 8210844');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (109, 'Winslow', 'Depper', '(973) 1333288');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (110, 'Ofilia', 'Belderson', '(984) 9438834');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (111, 'Davie', 'Sheffield', '(864) 3522860');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (112, 'Alex', 'McEnhill', '(378) 4435524');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (113, 'Bartholemy', 'Robelin', '(986) 6272512');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (114, 'Sean', 'Crissil', '(942) 2653758');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (115, 'Elmer', 'Slemming', '(919) 9288823');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (116, 'Lurlene', 'Corradeschi', '(514) 9012088');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (117, 'Padriac', 'Riolfi', '(570) 1107655');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (118, 'Iggie', 'MacConneely', '(439) 7396636');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (119, 'Foss', 'Battill', '(325) 5780868');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (120, 'Odell', 'Monument', '(368) 4528679');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (121, 'Veronike', 'Aslam', '(180) 2461691');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (122, 'Giselbert', 'Faithfull', '(396) 2962527');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (123, 'Simona', 'Filippozzi', '(930) 1734347');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (124, 'Iorgo', 'Melledy', '(881) 8271457');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (125, 'Loretta', 'Ramelot', '(486) 3859021');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (126, 'Kathrine', 'De Maria', '(661) 8754856');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (127, 'Margret', 'Loveridge', '(529) 8453575');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (128, 'Bridie', 'Uttridge', '(786) 8488337');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (129, 'Celestine', 'Gillibrand', '(690) 7315325');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (130, 'Carlo', 'Helleckas', '(343) 8542188');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (131, 'Berta', 'Korfmann', '(417) 8123942');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (132, 'Roi', 'O\' Reagan', '(635) 3865939');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (133, 'Netti', 'Swinburne', '(454) 9394501');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (134, 'Burt', 'Mellish', '(521) 3510551');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (135, 'Willyt', 'Potell', '(677) 7300986');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (136, 'Wenda', 'Prout', '(635) 2453891');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (137, 'Feodora', 'Turvie', '(514) 4286441');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (138, 'Kylie', 'Folke', '(881) 1339934');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (139, 'Tiffi', 'Tookill', '(481) 8752580');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (140, 'Erica', 'Tomsett', '(688) 8088613');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (141, 'Hewe', 'Fothergill', '(817) 4287448');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (142, 'Betta', 'Popple', '(421) 8215323');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (143, 'Findley', 'Beades', '(925) 6012594');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (144, 'Hurlee', 'Speke', '(129) 1896492');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (145, 'Meghan', 'Cockerell', '(312) 7733178');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (146, 'Curcio', 'Sambrook', '(541) 7205374');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (147, 'Jemmie', 'Starton', '(560) 6505808');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (148, 'Nita', 'Ainsby', '(952) 5277155');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (149, 'Eduardo', 'Pail', '(470) 7584292');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (150, 'Joby', 'Magne', '(293) 9682727');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (151, 'Hyacinth', 'Flux', '(445) 6422506');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (152, 'Emile', 'Claringbold', '(498) 5755228');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (153, 'Sharleen', 'Sibyllina', '(232) 7819299');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (154, 'Nadiya', 'Henrionot', '(225) 6410284');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (155, 'Willamina', 'Feathersby', '(171) 2241208');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (156, 'Noll', 'Mayhow', '(371) 5877383');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (157, 'Roselin', 'Knolles-Green', '(128) 8308034');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (158, 'Stefania', 'Denkin', '(917) 4091638');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (159, 'Danice', 'Balle', '(208) 7205244');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (160, 'Caroline', 'Hardinge', '(700) 1300209');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (161, 'Winny', 'Papis', '(871) 9703491');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (162, 'Cyrille', 'Gerbi', '(804) 9664756');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (163, 'Melesa', 'Shawyer', '(926) 7198174');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (164, 'Aubrey', 'Ast', '(163) 8113733');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (165, 'Marcelia', 'Petricek', '(925) 6427326');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (166, 'Harriott', 'Ormesher', '(590) 8136766');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (167, 'Kipp', 'Chable', '(801) 4710494');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (168, 'Nisse', 'Frango', '(247) 9998776');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (169, 'Kiel', 'McDowell', '(643) 6070046');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (170, 'Tobias', 'Ewebank', '(685) 6355457');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (171, 'Mimi', 'Lunny', '(846) 6248012');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (172, 'Evin', 'Slowey', '(275) 4285109');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (173, 'Lesley', 'Wyllie', '(155) 5906578');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (174, 'Jeremiah', 'McIlmurray', '(229) 1083870');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (175, 'Belle', 'Bank', '(198) 7355424');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (176, 'Shanta', 'Davenall', '(753) 8477416');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (177, 'Tommi', 'Lindhe', '(648) 6173397');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (178, 'Dominick', 'Lamkin', '(749) 4330260');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (179, 'Gusti', 'Ibberson', '(432) 9202579');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (180, 'Consolata', 'Fargher', '(563) 4499792');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (181, 'Emery', 'Brawley', '(256) 7712015');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (182, 'Maggy', 'Jex', '(726) 2721905');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (183, 'Bari', 'Brookes', '(288) 2109036');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (184, 'Bonnie', 'Cranke', '(673) 1256662');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (185, 'Reagen', 'Toner', '(627) 9446214');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (186, 'Marin', 'Burborough', '(308) 6090208');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (187, 'Alanna', 'Laurenceau', '(865) 1467226');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (188, 'Aubry', 'Schechter', '(442) 8666089');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (189, 'Chery', 'Fawthrop', '(534) 9676544');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (190, 'Kelley', 'Harme', '(572) 9781977');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (191, 'Erhard', 'Dunks', '(767) 7879948');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (192, 'Demetria', 'Tessyman', '(649) 8565076');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (193, 'Hedi', 'Yearnsley', '(556) 1304620');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (194, 'Rica', 'Hayer', '(817) 5535766');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (195, 'Chic', 'Maneylaws', '(485) 6249352');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (196, 'Moll', 'Kemson', '(689) 9477716');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (197, 'Janene', 'Fleckney', '(716) 6324343');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (198, 'Remington', 'Bortoluzzi', '(726) 7791991');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (199, 'Kimbra', 'Luter', '(718) 9117735');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (200, 'Mora', 'Bratch', '(651) 5309526');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (201, 'Catha', 'Moehler', '(482) 2460555');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (202, 'Franzen', 'Turnor', '(158) 2799257');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (203, 'Wini', 'Zylberdik', '(422) 3246963');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (204, 'Laurianne', 'Fantone', '(488) 2630172');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (205, 'Esteban', 'Wogdon', '(549) 6371507');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (206, 'Orbadiah', 'Blum', '(482) 3376561');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (207, 'Claribel', 'Dalrymple', '(320) 3074888');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (208, 'Rhys', 'Attoe', '(821) 8191977');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (209, 'Trudey', 'Gueste', '(590) 3249430');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (210, 'Findlay', 'Minillo', '(150) 9111902');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (211, 'Siusan', 'Deschelle', '(271) 7484418');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (212, 'Dedra', 'Darth', '(257) 8931873');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (213, 'Melodie', 'Franseco', '(255) 7823574');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (214, 'Micheal', 'Vescovo', '(777) 5590977');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (215, 'Mariska', 'Feria', '(566) 5435561');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (216, 'Adeline', 'Collingham', '(330) 6674215');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (217, 'Keir', 'Bransgrove', '(654) 6719460');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (218, 'Reilly', 'Beves', '(707) 8845558');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (219, 'Mohandis', 'Davenport', '(688) 8803609');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (220, 'Crosby', 'Apdell', '(858) 2472537');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (221, 'Thebault', 'Dyte', '(598) 9296035');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (222, 'Minny', 'Bawle', '(818) 4107873');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (223, 'Ashia', 'Cowling', '(181) 3392693');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (224, 'Gerrie', 'Biskupski', '(281) 4200672');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (225, 'Darryl', 'Simonelli', '(448) 7400851');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (226, 'Edmund', 'Barense', '(169) 2400123');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (227, 'Lira', 'Rowden', '(324) 1634882');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (228, 'Brinna', 'Stood', '(915) 5245880');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (229, 'Harlen', 'Sign', '(967) 4470275');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (230, 'Lionel', 'Pendre', '(471) 4456060');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (231, 'Burke', 'Doudny', '(651) 4670181');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (232, 'Jacquelin', 'Walisiak', '(937) 4654647');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (233, 'Elli', 'Audry', '(267) 1336763');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (234, 'Kerry', 'Wadeson', '(177) 9619543');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (235, 'Leesa', 'Skures', '(199) 1163877');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (236, 'Culver', 'Weight', '(624) 1719303');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (237, 'Gale', 'Symonds', '(698) 3083505');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (238, 'Sonja', 'Ennever', '(421) 8616191');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (239, 'Tabbatha', 'Ciccarello', '(825) 2614703');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (240, 'Cecil', 'Ludman', '(549) 1464293');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (241, 'Fairlie', 'Ingolotti', '(999) 5820814');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (242, 'Arney', 'Allden', '(399) 4410409');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (243, 'Ursala', 'Branson', '(503) 7915750');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (244, 'Yvonne', 'Symcock', '(188) 1635962');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (245, 'Benedick', 'Vedekhin', '(269) 3278351');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (246, 'Adriane', 'Mawd', '(262) 5359788');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (247, 'Barbette', 'Verner', '(282) 6115118');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (248, 'Mallissa', 'Greenig', '(438) 1195992');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (249, 'Judah', 'Andersson', '(184) 5877872');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (250, 'Mercy', 'Leport', '(846) 7823940');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (251, 'Perceval', 'Stannis', '(266) 3089495');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (252, 'Garrott', 'Redmell', '(836) 3461787');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (253, 'Dorian', 'Croix', '(411) 4885215');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (254, 'Daffi', 'Mathison', '(303) 9092458');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (255, 'Saunderson', 'Atwel', '(802) 1628019');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (256, 'Rutter', 'Watting', '(572) 9939841');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (257, 'Rhonda', 'Jack', '(253) 2962433');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (258, 'Olva', 'Challenger', '(884) 9647085');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (259, 'Alta', 'Le Barre', '(403) 3877548');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (260, 'Nata', 'Parkyns', '(431) 5970589');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (261, 'Erastus', 'Vears', '(953) 1723820');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (262, 'Carola', 'Lorman', '(184) 1580772');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (263, 'Beatriz', 'Damarell', '(883) 7802393');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (264, 'Dottie', 'Dady', '(610) 6271476');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (265, 'Ferdie', 'Scargle', '(293) 4638094');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (266, 'Bucky', 'Nicklinson', '(862) 5690692');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (267, 'Sayre', 'Pendre', '(974) 1883253');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (268, 'Gayelord', 'Iannetti', '(381) 1577095');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (269, 'Georgina', 'Tripney', '(195) 7758874');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (270, 'Jobye', 'Gockeler', '(572) 2023405');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (271, 'Jana', 'Grinyov', '(946) 6025715');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (272, 'Perle', 'Pittock', '(984) 9149208');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (273, 'Manny', 'Pooke', '(516) 8800193');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (274, 'Kermit', 'Erbain', '(230) 6763374');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (275, 'Jenna', 'Caffery', '(183) 1442513');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (276, 'Loni', 'Barford', '(680) 4847805');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (277, 'Rubi', 'Baysting', '(443) 6246333');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (278, 'Alberik', 'Cassely', '(308) 2906384');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (279, 'Eimile', 'Ferrant', '(236) 3836953');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (280, 'Erminie', 'Bernardotte', '(937) 2399198');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (281, 'Travus', 'Hobell', '(714) 4060964');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (282, 'Orsola', 'Tomala', '(699) 8380824');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (283, 'Monique', 'Dusting', '(851) 8448088');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (284, 'Dell', 'Cassedy', '(913) 3629003');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (285, 'Ludovika', 'Provest', '(178) 4937018');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (286, 'Amabelle', 'Prantl', '(175) 7994062');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (287, 'Allyson', 'Lampl', '(786) 2725309');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (288, 'Fletcher', 'Hardern', '(198) 5791572');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (289, 'Leeland', 'Lakenden', '(100) 9082414');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (290, 'Nealson', 'McCromley', '(188) 9536835');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (291, 'Meridith', 'McMenamie', '(801) 4982864');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (292, 'Horatio', 'Seedull', '(215) 7985897');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (293, 'Karissa', 'Goodchild', '(292) 5361922');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (294, 'Louie', 'Shervington', '(751) 7280235');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (295, 'Ilka', 'Brister', '(282) 8561984');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (296, 'Coretta', 'Armatidge', '(154) 4082999');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (297, 'Hillard', 'Giacomuzzi', '(870) 7576413');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (298, 'Blinny', 'Pettendrich', '(546) 3452100');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (299, 'Shaylah', 'Joskovitch', '(707) 8529775');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (300, 'Alan', 'Thomtson', '(649) 5649252');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (301, 'Sarah', 'Rope', '(790) 8258937');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (302, 'Sydney', 'Whitney', '(904) 5917860');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (303, 'Ephrayim', 'Vakhrushin', '(463) 8129530');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (304, 'Hyatt', 'Valder', '(481) 4298150');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (305, 'Sherlocke', 'Chadburn', '(182) 9266325');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (306, 'Alphard', 'Dungay', '(259) 3205864');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (307, 'Ty', 'Ohlsen', '(486) 8241645');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (308, 'Neal', 'Malby', '(186) 1894015');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (309, 'Lurlene', 'Woloschinski', '(161) 1725028');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (310, 'Dell', 'Glasscoo', '(888) 7893746');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (311, 'Garrot', 'Delepine', '(671) 3400302');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (312, 'Filippa', 'Litherborough', '(691) 8936037');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (313, 'Glenn', 'Sharphouse', '(559) 5247813');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (314, 'Melissa', 'Crut', '(141) 9201698');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (315, 'Kellina', 'Dani', '(411) 3908346');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (316, 'Burgess', 'Bowery', '(526) 3546022');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (317, 'Rhonda', 'Gitting', '(549) 1886747');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (318, 'Norry', 'Falkous', '(242) 1248725');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (319, 'Rozanna', 'Stogill', '(941) 9580640');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (320, 'Charissa', 'Christin', '(659) 3584913');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (321, 'Fred', 'Thamelt', '(822) 9763475');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (322, 'Leigh', 'Crellin', '(185) 2179634');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (323, 'Issiah', 'Brosoli', '(103) 9586002');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (324, 'Germain', 'Yerrington', '(170) 6838740');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (325, 'Jodie', 'Longo', '(143) 7846364');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (326, 'Shawnee', 'Lander', '(578) 5341379');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (327, 'Leonelle', 'Dunbar', '(461) 9649040');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (328, 'Moises', 'de Keep', '(321) 3722353');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (329, 'Jim', 'Pedel', '(565) 7946434');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (330, 'Pat', 'Ashenhurst', '(676) 3969326');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (331, 'Kim', 'Jobe', '(757) 8847212');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (332, 'Juliet', 'Coraini', '(645) 1629314');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (333, 'Isidor', 'Heymes', '(495) 6836457');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (334, 'Ursuline', 'Castro', '(796) 9535951');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (335, 'Tessa', 'Holberry', '(111) 3696881');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (336, 'Sybila', 'Challens', '(642) 1272275');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (337, 'Aubert', 'McFetrich', '(916) 2154307');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (338, 'Siward', 'Marchbank', '(225) 4591461');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (339, 'Aldrich', 'Porritt', '(485) 8466804');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (340, 'Matthus', 'Skillett', '(676) 3698658');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (341, 'Tiphany', 'Johanchon', '(792) 4048847');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (342, 'Dionysus', 'Shevlan', '(541) 4236434');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (343, 'Maurits', 'Symcock', '(772) 1438773');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (344, 'Joann', 'Kennerley', '(431) 2155033');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (345, 'Yetty', 'Crystal', '(901) 2274860');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (346, 'Archibold', 'Adie', '(256) 8751445');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (347, 'Arabella', 'Gall', '(878) 8973712');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (348, 'Hart', 'Cuerda', '(470) 5321577');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (349, 'Katherine', 'Thickin', '(768) 9835989');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (350, 'Lonni', 'Hymer', '(290) 9515483');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (351, 'Demetris', 'Paton', '(634) 6821865');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (352, 'Francklyn', 'Skeeles', '(198) 3173920');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (353, 'Chick', 'Burman', '(454) 9849474');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (354, 'Kearney', 'Aspden', '(913) 9174885');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (355, 'Olav', 'Cregeen', '(338) 4453990');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (356, 'Gertie', 'Scandwright', '(268) 4980830');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (357, 'Laurianne', 'Brilleman', '(718) 5580331');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (358, 'Rosco', 'Achrameev', '(751) 2158292');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (359, 'Dewie', 'Gutridge', '(965) 1421744');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (360, 'Deny', 'Fransoni', '(668) 1854037');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (361, 'Gavan', 'Fairholme', '(447) 1664735');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (362, 'Roman', 'Lemmertz', '(978) 9544813');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (363, 'Dollie', 'McGlone', '(651) 2520056');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (364, 'Gregoor', 'Batrop', '(486) 3152867');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (365, 'Deny', 'Nuzzi', '(178) 3457012');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (366, 'Muffin', 'Worsfold', '(593) 2856750');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (367, 'Garik', 'De Cleen', '(640) 2782965');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (368, 'Martie', 'Grebert', '(571) 1303770');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (369, 'Heall', 'Nutty', '(988) 9290659');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (370, 'Everard', 'Heaker', '(646) 9613759');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (371, 'Montgomery', 'Brosetti', '(958) 3849220');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (372, 'Nissa', 'Bridges', '(812) 7384659');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (373, 'Reider', 'Woodrough', '(926) 3271355');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (374, 'Tine', 'Pickthall', '(624) 2830238');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (375, 'Celka', 'Craisford', '(187) 4550065');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (376, 'Christian', 'Nemchinov', '(532) 1074571');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (377, 'Fran', 'Saul', '(840) 9318651');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (378, 'Pattin', 'Simionato', '(739) 5931657');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (379, 'Robbert', 'Drejer', '(584) 3120204');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (380, 'Benita', 'Barents', '(714) 5086426');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (381, 'Cicely', 'Lewer', '(485) 5893350');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (382, 'Elvina', 'Nutting', '(258) 5235501');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (383, 'Issy', 'Facer', '(160) 3390015');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (384, 'Phillis', 'Haylor', '(691) 1194315');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (385, 'Lura', 'Prott', '(209) 6909526');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (386, 'Gwenneth', 'Corby', '(704) 6250522');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (387, 'Ellsworth', 'Hammonds', '(835) 8743884');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (388, 'Nobe', 'Vaadeland', '(276) 2752088');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (389, 'Janessa', 'Fanshaw', '(409) 9659768');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (390, 'Zia', 'Domsalla', '(482) 4156542');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (391, 'Alard', 'Lymbourne', '(989) 3517816');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (392, 'Dorie', 'Claxton', '(721) 7663911');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (393, 'Bobbee', 'Durdan', '(998) 6470581');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (394, 'Fergus', 'Haldane', '(655) 2903228');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (395, 'Aubrey', 'Hamley', '(715) 3583836');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (396, 'Cristabel', 'Amner', '(794) 7732460');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (397, 'Pren', 'Harbison', '(670) 8129104');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (398, 'Marlo', 'Twatt', '(127) 9425352');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (399, 'Kalindi', 'Matveyev', '(140) 8039881');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (400, 'Herb', 'Herrieven', '(131) 7640036');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (401, 'Addison', 'Christy', '(891) 3782263');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (402, 'Kathlin', 'Macari', '(711) 4321117');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (403, 'Tildi', 'Hellings', '(277) 1481562');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (404, 'Carry', 'Netley', '(441) 6813389');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (405, 'Ingra', 'Wasson', '(695) 5405350');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (406, 'Rivi', 'Powers', '(323) 3067443');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (407, 'Dalia', 'Lockart', '(539) 8912625');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (408, 'Avigdor', 'Dungey', '(838) 9338854');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (409, 'Shoshanna', 'Egan', '(843) 1054893');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (410, 'Kylen', 'Squibb', '(380) 9871258');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (411, 'Wynn', 'Ducker', '(835) 7603839');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (412, 'Roland', 'Kowalik', '(887) 9106494');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (413, 'Dorris', 'Wozencroft', '(286) 7368542');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (414, 'Lisette', 'Jakes', '(257) 6137230');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (415, 'Carry', 'Chillingworth', '(947) 3371156');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (416, 'Nadiya', 'MacArd', '(471) 8411295');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (417, 'Carina', 'Dibbe', '(878) 9543248');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (418, 'Augustina', 'Mourton', '(533) 7536141');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (419, 'Clem', 'Geerdts', '(672) 8481840');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (420, 'Denys', 'Bevans', '(487) 3848885');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (421, 'Dena', 'O\'Kinedy', '(783) 2116564');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (422, 'Rita', 'Warratt', '(911) 5620649');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (423, 'Millie', 'Dugmore', '(856) 3566721');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (424, 'Jone', 'Swansborough', '(138) 9552219');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (425, 'Lind', 'Aylen', '(802) 2933987');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (426, 'Sigfrid', 'Ashpital', '(202) 4466564');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (427, 'Darryl', 'St Louis', '(592) 8202355');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (428, 'Marlee', 'Shall', '(442) 1562167');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (429, 'Esta', 'Guarin', '(805) 3891067');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (430, 'Cristy', 'Donwell', '(208) 9441356');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (431, 'Jason', 'Brands', '(400) 9875674');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (432, 'Roslyn', 'Pero', '(938) 9344456');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (433, 'Barton', 'Volage', '(511) 6542167');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (434, 'Angelico', 'Dunkerk', '(845) 9295823');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (435, 'Norene', 'Irlam', '(468) 8643417');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (436, 'Deck', 'Steels', '(632) 8554478');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (437, 'Francisco', 'Pettisall', '(330) 7276011');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (438, 'Tripp', 'Peperell', '(773) 1294869');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (439, 'Tyson', 'Messum', '(559) 9174609');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (440, 'Winnie', 'Sirman', '(703) 3632414');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (441, 'Goober', 'Trout', '(126) 8436043');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (442, 'Lorilyn', 'Croix', '(489) 8272781');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (443, 'Salvatore', 'Piletic', '(703) 3740222');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (444, 'Cale', 'Grafham', '(246) 4881214');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (445, 'Molli', 'Rudge', '(820) 6937550');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (446, 'Pietrek', 'Caban', '(286) 9195625');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (447, 'Kerry', 'Keeble', '(890) 7171441');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (448, 'Stearne', 'Wint', '(615) 1331935');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (449, 'Ulrike', 'Bliss', '(174) 5453669');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (450, 'Anatole', 'By', '(490) 9493734');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (451, 'Pryce', 'Lambillion', '(270) 1333597');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (452, 'Madeleine', 'Trahar', '(343) 5085862');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (453, 'Margie', 'Mumberson', '(347) 1677730');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (454, 'Ashton', 'Redwall', '(853) 2288777');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (455, 'Rivy', 'Leech', '(903) 3402819');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (456, 'Garrick', 'Wallman', '(945) 7414479');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (457, 'Carey', 'Schwand', '(992) 1312800');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (458, 'Victor', 'Tansley', '(489) 2455657');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (459, 'Judd', 'Woodhouse', '(451) 8180805');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (460, 'Ulrick', 'Giamitti', '(123) 9843971');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (461, 'Feliks', 'Samples', '(194) 4830546');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (462, 'Urban', 'Woolcocks', '(169) 8399266');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (463, 'Dianne', 'Lincoln', '(163) 8110582');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (464, 'Beau', 'Garrow', '(685) 8765563');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (465, 'Ezri', 'Josh', '(566) 6324916');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (466, 'Berget', 'Verrechia', '(222) 5611630');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (467, 'Rey', 'Geraud', '(348) 6364352');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (468, 'Iggie', 'Farry', '(532) 4460055');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (469, 'Anna-diane', 'Augie', '(371) 5150576');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (470, 'Jillene', 'Dionisii', '(803) 1225534');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (471, 'Chrissy', 'Rosenblath', '(185) 8461000');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (472, 'Donia', 'Skip', '(685) 7591673');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (473, 'Marthena', 'Tuison', '(987) 8842781');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (474, 'Fredrika', 'Banke', '(220) 4181769');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (475, 'Gabe', 'Vedenyakin', '(254) 2506833');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (476, 'Mart', 'Michieli', '(717) 5082060');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (477, 'Avril', 'Chitter', '(941) 9337644');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (478, 'Nathalie', 'Heenan', '(203) 4837042');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (479, 'Babs', 'Hebbes', '(480) 1139129');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (480, 'Donavon', 'Tarbett', '(552) 9375544');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (481, 'Jeanna', 'Ceccoli', '(992) 5175873');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (482, 'Giffie', 'Creboe', '(446) 7448407');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (483, 'Guillema', 'Applegate', '(985) 8214404');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (484, 'Agathe', 'Stiebler', '(322) 7554273');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (485, 'Rees', 'Oehme', '(466) 6247403');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (486, 'Waverly', 'Bracci', '(703) 7832420');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (487, 'Dominique', 'Kirdsch', '(603) 8900334');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (488, 'Britt', 'Bresnahan', '(912) 4943845');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (489, 'Tamarra', 'Horrod', '(247) 9096841');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (490, 'Kylila', 'Guillot', '(749) 5739730');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (491, 'Emelia', 'O\'Spellissey', '(139) 9458893');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (492, 'Thoma', 'Syce', '(223) 6121413');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (493, 'Lauren', 'Clotworthy', '(105) 1794795');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (494, 'Thedrick', 'Whisker', '(581) 9715609');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (495, 'Denise', 'Camp', '(923) 9621604');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (496, 'Camel', 'Storrah', '(662) 2664875');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (497, 'Regan', 'Chave', '(443) 3067751');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (498, 'Emery', 'Umpleby', '(269) 7171771');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (499, 'Marika', 'Lloyds', '(555) 5831760');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (500, 'Matti', 'Kenway', '(534) 8764230');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (501, 'Cassandry', 'Haggar', '(947) 4835555');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (502, 'Claudian', 'Beeken', '(443) 3438585');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (503, 'Glennis', 'Hastewell', '(949) 7395900');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (504, 'Ana', 'Shackleford', '(522) 8422494');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (505, 'Misha', 'Ventris', '(458) 8105071');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (506, 'Rodolfo', 'Dwelley', '(685) 4371251');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (507, 'Walliw', 'Winkless', '(700) 7852460');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (508, 'Nels', 'Garfath', '(199) 3466125');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (509, 'Gib', 'Deville', '(744) 6786008');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (510, 'Edgard', 'Stourton', '(455) 7979407');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (511, 'Maddalena', 'Dadson', '(609) 4160869');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (512, 'Elfreda', 'Cescot', '(585) 2148558');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (513, 'Clifford', 'Geeves', '(867) 5667791');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (514, 'Nanine', 'MacDwyer', '(538) 2192043');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (515, 'Wendie', 'Evers', '(215) 8057918');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (516, 'Mariya', 'Eburne', '(631) 5518324');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (517, 'Larina', 'Terese', '(162) 7488860');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (518, 'Ania', 'Johnes', '(902) 9618740');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (519, 'Tammy', 'Trussman', '(360) 7767831');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (520, 'Steffi', 'Heijnen', '(100) 9202496');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (521, 'Eduardo', 'Kleinhaus', '(414) 7337870');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (522, 'Cazzie', 'Mecco', '(666) 1477946');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (523, 'Berti', 'Shimman', '(401) 6976680');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (524, 'Briana', 'Clawe', '(883) 3118282');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (525, 'Josephine', 'Coils', '(219) 1835779');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (526, 'Sven', 'Stonbridge', '(552) 4440013');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (527, 'Jeanne', 'Kedwell', '(923) 5663273');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (528, 'Cora', 'Vesco', '(777) 1488014');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (529, 'Stefa', 'Chisolm', '(104) 8789685');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (530, 'Giorgio', 'Poppleton', '(950) 3589716');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (531, 'Lizzy', 'Mattaser', '(967) 5140245');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (532, 'Elden', 'Brewer', '(760) 8086885');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (533, 'Rivkah', 'Cattermull', '(206) 7079705');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (534, 'Marga', 'Tonbye', '(998) 4656362');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (535, 'Kelly', 'Griss', '(754) 7213711');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (536, 'Orton', 'Wibrew', '(445) 1107577');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (537, 'Cathy', 'Aveson', '(442) 5218192');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (538, 'Fancy', 'Doberer', '(728) 2019641');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (539, 'Ursulina', 'Robey', '(447) 7077136');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (540, 'Kelcie', 'Parrott', '(836) 6828817');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (541, 'Grayce', 'Bisgrove', '(161) 5227282');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (542, 'Elianore', 'Kerley', '(893) 2408174');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (543, 'Cedric', 'Ridett', '(969) 4268168');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (544, 'Ilse', 'Mingardo', '(688) 8341575');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (545, 'Susana', 'Burwood', '(586) 5554824');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (546, 'Alanah', 'Cokely', '(493) 9383308');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (547, 'Agnese', 'Ollington', '(345) 2853820');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (548, 'Clayson', 'Torricella', '(698) 6847014');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (549, 'Beitris', 'Gelder', '(353) 1151016');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (550, 'Joseito', 'Forster', '(159) 8685124');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (551, 'Jory', 'Zamboniari', '(112) 5793861');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (552, 'Xymenes', 'Armour', '(791) 8248975');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (553, 'Garreth', 'Sapauton', '(568) 5199434');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (554, 'Cherilynn', 'Ply', '(644) 8676057');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (555, 'Francis', 'Bukac', '(578) 2448073');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (556, 'Geoff', 'Tremathack', '(559) 3180639');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (557, 'Joscelin', 'Sporrij', '(929) 4818106');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (558, 'Andra', 'Langley', '(390) 2060907');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (559, 'Winne', 'Spillard', '(879) 7213093');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (560, 'Joane', 'Ruecastle', '(243) 3802358');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (561, 'Zorina', 'Klesel', '(147) 1715844');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (562, 'Jud', 'Aspenlon', '(863) 3156485');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (563, 'Josi', 'Lunnon', '(159) 2261294');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (564, 'Dulcie', 'Butner', '(762) 7519309');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (565, 'Hi', 'Hedon', '(285) 8964274');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (566, 'Wright', 'Maccrae', '(411) 6165088');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (567, 'Bessy', 'Caroli', '(880) 2952350');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (568, 'Etienne', 'Stapells', '(946) 4934697');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (569, 'Cherise', 'Grigoriev', '(867) 9130444');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (570, 'Ivor', 'Comsty', '(596) 3945910');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (571, 'Lizette', 'Pillman', '(150) 2658589');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (572, 'Rozella', 'Gashion', '(482) 9496940');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (573, 'Aura', 'Hussell', '(572) 9443038');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (574, 'Keene', 'Catcherside', '(691) 7761548');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (575, 'Deeyn', 'Woodus', '(474) 6236250');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (576, 'Meg', 'Munden', '(962) 3466153');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (577, 'Anne-corinne', 'MacGuiness', '(258) 5411366');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (578, 'Kristoforo', 'Shayes', '(822) 9001461');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (579, 'Micheil', 'Runge', '(469) 2674947');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (580, 'Cam', 'Tingey', '(248) 3848351');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (581, 'Audy', 'Picford', '(859) 8013810');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (582, 'Alejandrina', 'Brickham', '(524) 3892627');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (583, 'Judah', 'Mandeville', '(201) 3339448');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (584, 'Rickert', 'Fyfe', '(498) 8216902');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (585, 'Abbey', 'Maxwale', '(499) 8610657');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (586, 'Tamiko', 'Swigger', '(710) 3749043');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (587, 'Grata', 'Bourdon', '(637) 3721606');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (588, 'Tobias', 'Parry', '(220) 6390233');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (589, 'Dodie', 'Lunbech', '(490) 8602087');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (590, 'Tommie', 'Goddman', '(567) 6870197');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (591, 'Konstanze', 'Ambrosini', '(417) 2642220');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (592, 'Rena', 'Bidnall', '(126) 2086306');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (593, 'Mignonne', 'Disbrey', '(319) 7588492');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (594, 'Denis', 'Coaten', '(940) 9537083');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (595, 'Rudolph', 'Bumpus', '(212) 8274884');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (596, 'Wilek', 'Grzegorzewski', '(544) 9382916');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (597, 'Junie', 'Cardnell', '(615) 9223360');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (598, 'Sonny', 'Piletic', '(814) 4612912');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (599, 'Olivero', 'Cordelette', '(905) 3380077');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (600, 'Wallas', 'Thunderman', '(708) 6749181');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (601, 'Annalise', 'Cowthard', '(150) 3344417');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (602, 'Chuck', 'Rikkard', '(509) 3090878');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (603, 'Henrieta', 'Gouldstone', '(174) 8748467');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (604, 'Pascale', 'Ellens', '(515) 4966166');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (605, 'Morgan', 'Weare', '(381) 7120416');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (606, 'Wally', 'Hullot', '(564) 1828984');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (607, 'Griswold', 'Pickton', '(332) 9235869');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (608, 'Izak', 'Tregaskis', '(749) 7126602');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (609, 'Yorker', 'Balke', '(427) 7900348');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (610, 'Fernande', 'O\'Rudden', '(514) 1644954');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (611, 'Dennie', 'Bolter', '(185) 7574524');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (612, 'Salomo', 'Phette', '(479) 1983095');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (613, 'Tadeas', 'Bevans', '(979) 3129685');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (614, 'Antons', 'Pascall', '(207) 7396980');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (615, 'Merissa', 'Craigs', '(623) 4444369');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (616, 'Olympie', 'Welch', '(260) 9709928');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (617, 'Minnie', 'Reading', '(622) 1954041');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (618, 'Pattie', 'Tibols', '(859) 5323204');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (619, 'Ermin', 'Marchington', '(320) 1081688');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (620, 'Eolande', 'Rosengarten', '(410) 4378602');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (621, 'Leyla', 'Roof', '(258) 7774970');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (622, 'Thorvald', 'Koppes', '(990) 1642276');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (623, 'Nari', 'Slocum', '(321) 3459788');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (624, 'Brandise', 'Fellgate', '(601) 5642745');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (625, 'Tamma', 'Girardi', '(183) 9680559');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (626, 'Meryl', 'Grumble', '(882) 8838660');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (627, 'Lory', 'Creagh', '(719) 8412701');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (628, 'Chalmers', 'Marshal', '(205) 7199056');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (629, 'Noella', 'Zanini', '(922) 5768845');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (630, 'Felice', 'Jevon', '(263) 9309768');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (631, 'Tucky', 'Omand', '(858) 6154113');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (632, 'Ogdan', 'Lambrook', '(903) 3857594');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (633, 'Katie', 'Arnaudin', '(214) 2842003');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (634, 'Goldarina', 'Storre', '(184) 4036200');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (635, 'Frasier', 'Yarrow', '(193) 2369251');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (636, 'Ivar', 'Easterfield', '(626) 1393525');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (637, 'Cele', 'Jakubovitch', '(481) 4867551');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (638, 'Cory', 'Lindop', '(801) 7764020');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (639, 'Friedrick', 'Axel', '(914) 9626137');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (640, 'Boot', 'Pifford', '(252) 6988336');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (641, 'Evan', 'Annetts', '(140) 6249520');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (642, 'Alvy', 'Mityakov', '(952) 6080501');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (643, 'Annadiane', 'Midgely', '(426) 7649497');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (644, 'Rozelle', 'Menchenton', '(265) 5748724');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (645, 'Aleksandr', 'Clerc', '(207) 5743582');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (646, 'Jeanine', 'Lane', '(579) 1160173');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (647, 'Wilhelm', 'Frankton', '(417) 9511906');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (648, 'Thurston', 'Raddish', '(195) 2884375');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (649, 'Francesco', 'Banford', '(988) 2349345');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (650, 'Candis', 'Noye', '(927) 1301543');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (651, 'Katie', 'Bett', '(931) 5706876');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (652, 'Mehetabel', 'Valens-Smith', '(318) 8127290');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (653, 'Sibeal', 'Deshon', '(120) 5918899');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (654, 'Samson', 'Tudhope', '(271) 1237114');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (655, 'Sampson', 'Benjefield', '(892) 7531856');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (656, 'Bondon', 'Vockings', '(385) 4376435');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (657, 'Nerita', 'Bisco', '(221) 2045283');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (658, 'Freida', 'Finding', '(447) 4338563');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (659, 'Viviyan', 'Swaby', '(789) 4370522');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (660, 'Meade', 'Appleford', '(145) 4144430');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (661, 'Pru', 'Belk', '(288) 6938306');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (662, 'Constantino', 'Vail', '(929) 2566593');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (663, 'Dulci', 'Penson', '(406) 5746373');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (664, 'Griffin', 'Forster', '(884) 3305473');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (665, 'Gussie', 'Reaney', '(586) 7336732');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (666, 'Sindee', 'Whittet', '(932) 9188679');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (667, 'Con', 'Kliche', '(609) 2902985');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (668, 'Guinna', 'Lowrance', '(867) 5006574');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (669, 'Belinda', 'Ivashechkin', '(624) 6560964');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (670, 'Idaline', 'Guillart', '(802) 2586404');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (671, 'Cass', 'Mowne', '(922) 3610078');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (672, 'Mikey', 'Ullett', '(112) 5429698');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (673, 'Finn', 'Maccrae', '(136) 6360493');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (674, 'Sydel', 'Vasser', '(336) 3581718');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (675, 'Wendeline', 'Skase', '(449) 9324888');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (676, 'Ansel', 'Joplin', '(214) 1338695');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (677, 'Berti', 'Ketts', '(202) 3252281');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (678, 'Rosalyn', 'McGonigal', '(685) 9679232');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (679, 'Dorena', 'Deetlefs', '(540) 8027607');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (680, 'Wilone', 'Geggie', '(628) 5324095');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (681, 'Son', 'Lias', '(518) 1838769');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (682, 'Sidonnie', 'Cogdell', '(692) 7958091');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (683, 'Annabella', 'Vettore', '(231) 6388863');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (684, 'Chloe', 'Duesberry', '(876) 3283679');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (685, 'Buckie', 'Lackmann', '(877) 4401311');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (686, 'Tracy', 'Bierling', '(160) 9405875');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (687, 'Jeramey', 'Balbeck', '(916) 1502614');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (688, 'Mallory', 'Daniells', '(270) 8265027');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (689, 'Godfry', 'MacDirmid', '(324) 5624163');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (690, 'Brittne', 'Cooke', '(605) 5341406');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (691, 'Stirling', 'Pindar', '(580) 2534392');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (692, 'Libby', 'Kempshall', '(234) 4437586');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (693, 'Randie', 'Chasle', '(175) 2952507');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (694, 'Carina', 'Vernall', '(379) 1597037');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (695, 'Hewett', 'Minto', '(975) 8638199');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (696, 'Amelie', 'Jeal', '(126) 7680094');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (697, 'Forest', 'Gillyett', '(295) 5742774');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (698, 'Nerita', 'Fishlee', '(240) 1120810');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (699, 'Bondie', 'Marryatt', '(221) 3835342');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (700, 'Sanderson', 'Rafter', '(831) 2764805');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (701, 'Karna', 'Rey', '(692) 2727706');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (702, 'Shelley', 'Veevers', '(143) 9338890');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (703, 'Buddy', 'Yelyashev', '(478) 1440746');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (704, 'Buck', 'Lints', '(508) 3603950');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (705, 'Hamilton', 'Kemmet', '(617) 9532072');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (706, 'Roobbie', 'Glynne', '(891) 9504377');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (707, 'Martha', 'Simpkin', '(646) 7834551');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (708, 'Adolpho', 'Margach', '(925) 7049286');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (709, 'Cristine', 'Sire', '(875) 6362427');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (710, 'Ernestus', 'Perryman', '(485) 7026976');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (711, 'Constance', 'Metherell', '(839) 3120492');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (712, 'Hynda', 'Bassford', '(996) 4248756');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (713, 'Humfried', 'Matthewes', '(585) 7978675');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (714, 'Kane', 'Epine', '(299) 7112416');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (715, 'Tildy', 'Bickell', '(337) 7105016');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (716, 'Chandal', 'Greenhalf', '(280) 2841429');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (717, 'Barbee', 'Brisland', '(324) 4616338');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (718, 'Morganica', 'Fergyson', '(424) 4152589');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (719, 'Gregorius', 'Lowle', '(223) 7473943');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (720, 'Bard', 'Rosensaft', '(713) 9829991');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (721, 'Kahlil', 'Burgon', '(417) 2074674');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (722, 'Jonathan', 'Vigars', '(954) 4306835');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (723, 'Christophorus', 'Haggett', '(445) 5807639');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (724, 'Gwynne', 'Tansly', '(443) 2237251');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (725, 'Lionello', 'Duly', '(877) 7959930');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (726, 'Anallese', 'Hindenberger', '(671) 9371003');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (727, 'Minny', 'Clifforth', '(989) 7240789');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (728, 'Quill', 'Bohike', '(862) 1013768');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (729, 'Leonore', 'Tyght', '(218) 4039290');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (730, 'Griz', 'Overington', '(417) 6224301');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (731, 'Jacquie', 'Pieters', '(155) 3267510');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (732, 'Germaine', 'Fountian', '(367) 9433148');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (733, 'Pembroke', 'Abreheart', '(914) 3015039');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (734, 'Farlay', 'Kendred', '(724) 3655189');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (735, 'Worthington', 'Brassington', '(680) 1236227');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (736, 'Cary', 'Dunsmore', '(307) 6962409');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (737, 'Doralyn', 'Vennings', '(131) 7791879');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (738, 'Mira', 'Cross', '(831) 5421414');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (739, 'Stirling', 'Djurdjevic', '(678) 8975676');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (740, 'Ranna', 'Wakerley', '(552) 1523394');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (741, 'Stacia', 'Daelman', '(537) 9582553');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (742, 'Diannne', 'Rimmington', '(891) 2312747');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (743, 'Bird', 'Prendergast', '(379) 5356592');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (744, 'Osborn', 'Larkin', '(566) 9693353');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (745, 'Blondy', 'Vickery', '(172) 3044531');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (746, 'Francisca', 'Wilbraham', '(444) 8331150');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (747, 'Dyna', 'Ugolotti', '(770) 7479692');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (748, 'Mellie', 'O\'Scollee', '(962) 1293834');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (749, 'Blair', 'Middlemiss', '(126) 1878173');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (750, 'Carlina', 'Bielefeld', '(181) 4580184');
INSERT INTO `resturant`.`customer` (`Customer_id`, `First_Name`, `Last_name`, `Phone_No`) VALUES (751, 'Reta', 'Kollatsch', '(504) 1627452');

COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`employeetype`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (1, 'Manager');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (2, 'Exec-Chef');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (3, 'Sous-Chef');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (4, 'Bartender');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (5, 'Host');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (6, 'Hostess');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (7, 'Cleaning Crew');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (8, 'Valet');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (9, 'General chef');
INSERT INTO `resturant`.`employeetype` (`EmployeeTypeID`, `Description`) VALUES (10, 'Waiter');
COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (1, 'Mariana', 'Ca', 'mca0@businessinsider.com', 1, 1);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (2, 'Timothee', 'Peyes', 'tpeyes1@ftc.gov', 2, 2);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (3, 'Madelle', 'Keune', 'mkeune2@cbsnews.com', 3, 3);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (4, 'Herminia', 'Gladwin', 'hgladwin3@msu.edu', 4, 4);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (5, 'Bobbee', 'Yeandel', 'byeandel4@newyorker.com', 5, 1);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (6, 'Nance', 'Euels', 'neuels5@wikipedia.org', 6, 1);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (7, 'Hedi', 'Bengtson', 'hbengtson6@unesco.org', 7, 1);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (8, 'Armstrong', 'Eglinton', 'aeglinton7@blogger.com', 8, 6);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (9, 'Bea', 'Middlemass', 'bmiddlemass8@mozilla.org', 9, 6);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (10, 'Ivie', 'Brewood', 'ibrewood9@ucoz.ru', 10, 10);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (11, 'Pepillo', 'Stobart', 'pstobarta@sogou.com', 11, 3);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (12, 'Morlee', 'Harbin', 'mharbinb@biglobe.ne.jp', 12, 4);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (13, 'Dorena', 'Frisch', 'dfrischc@godaddy.com', 13, 4);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (14, 'Dani', 'Ivakhno', 'divakhnod@yelp.com', 14, 4);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (15, 'Jammie', 'Swynley', 'jswynleye@indiegogo.com', 15, 5);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (16, 'Gaspard', 'Beech', 'gbeechf@google.de', 16, 6);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (17, 'Cly', 'Gazey', 'cgazeyg@indiegogo.com', 17, 7);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (18, 'Shepperd', 'Wretham', 'swrethamh@slate.com', 18, 7);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (19, 'Gordy', 'Deesly', 'gdeeslyi@pinterest.com', 19, 7);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (20, 'Aksel', 'Commings', 'acommingsj@twitter.com', 20, 5);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (21, 'Letty', 'Rymmer', 'lrymmerk@sciencedaily.com', 21, 6);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (22, 'Gregg', 'Ortes', 'gortesl@zimbio.com', 22, 3);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (23, 'Farr', 'Curr', 'fcurrm@soundcloud.com', 23, 3);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (24, 'Darci', 'McSperrin', 'dmcsperrinn@shareasale.com', 24, 10);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (25, 'Callean', 'Snoddon', 'csnoddono@webnode.com', 25, 8);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (26, 'Nanni', 'Jaulmes', 'njaulmesp@amazonaws.com', 26, 7);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (27, 'Cristen', 'Shugg', 'cshuggq@rambler.ru', 27, 2);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (28, 'Yorgos', 'MacNamara', 'ymacnamarar@storify.com', 28, 3);
INSERT INTO `resturant`.`employee` (`Employee_id`, `First_name`, `Last_name`, `Email`, `AddressId`, `EmployeeTypeId`) VALUES (29, 'Northrop', 'Wallace', 'nwallaces@prlog.org', 29, 5);
COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`table`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (1, '4', 1);
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (2, '6', 1);
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (3, '6', 0);
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (4, '4', 0);
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (5, '7', 0);
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (6, '7', 0);
INSERT INTO `resturant`.`table` (`Table_id`, `max_capacity`, `Is_Booked`) VALUES (7, '3', 0);
COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`kwik_kiosk`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (1, curdate(), 1, 23, 12);
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (2, curdate(), 2, 12, 23);
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (3, curdate(), 3, 10, 20);
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (4, curdate(), 4, 1, 2);
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (5, curdate(), 5, 2, 1);
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (6, curdate(), 6, 5, 6);
INSERT INTO `resturant`.`kwik_kiosk` (`Kiosk_id`, `order_placed`, `TableId`, `CustomerId`, `EmployeeId`) VALUES (7, curdate(), 7, 15, 7);
COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`meals`
-- -----------------------------------------------------

USE `resturant`;
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (1, 'Grilled Sausage', 'Entree', 41.50);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (2, 'Pulled Beef Brisket', 'Entree', 36.02);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (3, 'Sliced Beef Brisket', 'Entree', 16.00);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (4, 'Smoked BBQ Ribs', 'Entree', 34.21);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (5, 'Deep Fried BBQ Ribs', 'Entree', 33.71);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (6, 'Grilled Pork Chops', 'Entree', 26.46);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (7, 'Lamb Chops', 'Entree', 22.28);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (8, 'Lollipop Lamb Chops', 'Entree', 22.35);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (9, 'VealÂ Chops', 'Entree', 21.53);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (10, 'Fried Tilapia', 'Entree', 40.58);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (11, 'Baked Salmon & Jumbo Shrimp', 'Entree', 47.31);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (12, 'Artichoke and Spinach Dip', 'Appetizers', 42.11);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (13, 'Cheesy Bread', 'Appetizers', 17.34);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (14, 'Guacamole with chips', 'Appetizers', 22.96);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (15, 'Guacamole with salsa', 'Appetizers', 48.01);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (16, 'Pepperoni Bread', 'Appetizers', 15.95);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (17, 'Chicken Wings', 'Appetizers', 17.37);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (18, 'Fried Pickles with Spicy Mayonnaise', 'Appetizers', 15.66);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (19, 'Mini Burgers', 'Appetizers', 27.47);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (20, 'Taco', 'Appetizers', 21.68);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (21, 'Fudge Brownie', 'Desserts', 21.89);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (22, 'Cupcake', 'Desserts', 49.91);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (23, 'Donut', 'Desserts', 45.71);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (24, 'Ice Cream', 'Desserts', 46.96);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (25, 'Wine', 'Drinks', 49.88);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (26, 'Soda', 'Drinks', 21.14);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (27, 'Oranje Juice', 'Drinks', 22.42);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (28, 'Water', 'Drinks', 38.23);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (29, 'Cocktail', 'Drinks', 42.49);
INSERT INTO `resturant`.`meals` (`Meal_id`, `Name`, `Category`, `Price`) VALUES (30, 'Milkshake', 'Drinks', 18.29);
COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`serves`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 1, 1);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 2, 10);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 1, 2);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 1, 3);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 26, 2);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 24, 20);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 19, 30);
INSERT INTO `resturant`.`serves` (`Ordered_date`, `EmployeeID`, `CustomerId`) VALUES (curdate(), 14, 40);
COMMIT;


-- -----------------------------------------------------
-- Data for table `resturant`.`employee_prepares_meals`
-- -----------------------------------------------------
START TRANSACTION;
USE `resturant`;
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (3, 2, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (4, 3, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (5, 4, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (1, 3, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (7, 13, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (4, 13, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (28, 12, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (29, 1, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (16, 29, curdate());
INSERT INTO `resturant`.`employee_prepares_meals` (`Employee_id`, `Meal_id`, `Date`) VALUES (10, 24, curdate());
COMMIT;





