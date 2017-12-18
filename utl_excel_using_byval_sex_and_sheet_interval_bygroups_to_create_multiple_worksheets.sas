Using #byval(sex) and sheet_interval='bygroups' to create multiple excel worksheets

see
https://goo.gl/sWcRcQ
https://communities.sas.com/t5/ODS-and-Base-Reporting/ungroup-xlsx-worksheets/td-p/265187

profile gdsilva
https://communities.sas.com/t5/user/viewprofilepage/user-id/28313


INPUT
=====

  WORK.HAVE total obs=2

   SEX    A    B

    F     2    2
    M     1    1


WORKING CODE
============
   options (sheet_interval='bygroups' suppress_bylines='no' sheet_name='#byval(sex)');
   proc report data=abc;
     by sex;


OUTPUT
======
    d:/xls/bygroup.xlsx

      +--------------------------------------+
      |     A      |    B       |     C      |
      +--------------------------------------+
   1  |sex=F                                 |
      +--------------------------------------+
   2
      +--------------------------------------+
   3  |   SEX      |    A       |     B      |
      +------------+------------+------------+
   4  |    F       |    2       |     2      |
      +------------+------------+------------+
  [F]



      +--------------------------------------+
      |     A      |    B       |     C      |
      +--------------------------------------+
   1  |sex=M                                 |
      +--------------------------------------+
   2
      +--------------------------------------+
   3  |   SEX      |    A       |     B      |
      +------------+------------+------------+
   4  |    M       |    `       |     `      |
      +------------+------------+------------+
  [M]


*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;


%utlfkil(d:/xls/bygroup.xlsx); * just in case it exists;

data have;
  retain sex;
  a=2;b=2;sex='F';output;
  a=1;b=1;sex='M';output;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

ods excel file="d:/xls/bygroup.xlsx"

options (sheet_interval='bygroups' suppress_bylines='no' sheet_name='#byval(sex)');
proc report data=abc;
  by sex;
run;quit;

ods excel close;


