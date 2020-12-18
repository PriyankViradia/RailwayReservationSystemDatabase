Create Table Train
(
Train_Number int NOT NULL,
Train_Name varchar(20),
Source varchar(20),
Destination Varchar(20),
Ac_Cost varchar(20),
Gen_Cost varchar(20),
Sun_Available Varchar(20),
Sat_Available Varchar(20),
CONSTRAINT trainsid PRIMARY KEY (Train_Number)
);
Create Table TrainStatus
(
TrainDate Date,
Ac_Seat Number(20),
Gen_Seat Number(20),
BookedDate Date,
TrainNumber number(20),
CONSTRAINT TrainNumber FOREIGN KEY (TrainNumber) REFERENCES
Train(Train_Number)
);

Create Table Passenger
(
TicketID number(5),
PName varchar(20),
PAddress varchar(20),
PAge number(20),
PCategory varchar(20),
PStatus varchar(20),
PGender varchar(20),
BookedDate date,
TrainNumber number(20),
CONSTRAINT psngr PRIMARY KEY (TicketID) ,
CONSTRAINT TrainNumber1 FOREIGN KEY (TrainNumber) REFERENCES
Train(Train_Number)
);

Create Table BookedTicket
(
train_Number Number Not Null,
BookedDate date,
category varchar(10) ,
CONSTRAINT TrainNumber2 FOREIGN KEY (Train_Number) REFERENCES
Train(Train_Number)
); 

Create Table Cancel
(
TicketID Number(10),
Dateofbooked date,
CONSTRAINT TIDfk FOREIGN KEY(TicketID) REFERENCES
Passenger(TicketID)
);

Insert into Train Values (1,'Business Train', 'Hyderabad','Sukkur',2000,1200,'yes','no');
Insert into Train Values (2,' sukkur express', 'Sukkur', 'lahore',1200,700,'no','yes');
Insert into Train Values (3, 'Jaffer Express', 'lahore', 'quetta',1300, 1500,'yes','no');
Insert into Train Values (4,'Shalimar Express','quetta','KHI',1500,1200,'yes','yes');
Insert into Train Values (5,'karakarum','KHI','Sukkur',1500,1200,'yes','yes'); 
select * from train;
DESC TRAINSTATUS;
desc passenger; 
Insert into TrainStatus Values ('30/09/2018',23,20,'22/09/2018',1);
Insert into TrainStatus Values ('25/10/2018',19,19,'22/09/2018',2);
Insert into TrainStatus Values ('10/12/2018',17,16,'21/09/2018',4); 
Insert into TrainStatus Values ('26/09/2018',15,13,'20/09/2018',5);
Insert into TrainStatus Values ('27/09/2018',10,9,'25/09/2018',3);

Insert into Passenger Values(1,'PRIYANK','ADAJAN',18,'STUDENT','YES','MALE','22/09/2018',3);
Insert into Passenger Values(2,'ABHINANDAN','JAKATNAKA',19,'EMPLOYEE','YES','MALE','21/09/2018',4);
Insert into Passenger Values(3,'DIKSHA','KATARAGAM',23,'TEACHER','YES','FEMALE','20/09/2018',5);
DESC BOOKEDTICKET;
Insert into BookedTicket Values(3 ,'22/09/2018','AC');
Insert into  BookedTicket Values(4 ,'21/09/2018','General') ;
Insert into  BookedTicket Values(5 ,'20/09/2018','AC');
DESC CANCEL;
Insert into Cancel Values(2 ,'21/09/2018');


Select * from Train;
Select * from TrainStatus;
Select * from Passenger;
Select * from BookedTicket;
Select * from Cancel;
SELECT * INTO MERGE1 FROM TRAIN UNION SELECT * INTO TRAINSTATUS ;
create or replace  trigger trigger2
after insert on passenger referencing new as n

for each row
begin
  DBMS_OUTPUT.PUT_LINE('Proposed new value of CLOB column: '||:n.Pname);
END;
Insert into Passenger Values(4,'PRIYANK','ADAJAN',18,'STUDENT','YES','MALE','22/09/2018',3);
set serveroutput on;
COMMIT;

DECLARE
PRICE train.AC_COST%type;
CURSOR
C3 IS
SELECT AC_cost FROM train WHERE SAT_available='yes';
BEGIN
OPEN c3;
loop
FETCH c3 INTO PRICE;
IF c3%FOUND THEN
UPDATE train SET AC_cost=PRICE+500 ;
END IF;
exit when c3%notfound;
DBMS_OUTPUT.PUT_LINE('UPDATED TO '|| PRICE);
end loop;
CLOSE C3;
END;
