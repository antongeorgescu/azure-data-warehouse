import pyodbc
import pandas as pd
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = 'STDLHVY5K13\SQLEXPRESS' 
database = 'StudentCourses' 
username = 'alvianda' 
password = 'dana2606'  
cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

query = "SELECT * FROM vwInstructorCourseDepartment;"
df = pd.read_sql(query, cnxn)
print(df.head(26))
df.to_parquet('instructorCourses.parquet',engine='fastparquet',compression=None)  
pd.read_parquet('instructorCourses.parquet') 

query = "SELECT * FROM vwStudentCourseGrade;"
df = pd.read_sql(query, cnxn)
print(df.head(26))
df.to_parquet('studentCourses.parquet',engine='fastparquet',compression=None)  
pd.read_parquet('studentCourses.parquet') 

query = "SELECT * FROM vwAllCourses;"
df = pd.read_sql(query, cnxn)
print(df.head(26))
df.to_parquet('allCourses.parquet',engine='fastparquet',compression=None)  
pd.read_parquet('allCourses.parquet') 


