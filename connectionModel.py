import pyodbc
server_name =  "FRANKLYN-PC"
db_name = "spotper"

cnxn = pyodbc.connect('Driver={SQL Server};'
                      'Server='+server_name+';'
                      'Database='+db_name+';'
                      'Trusted_Connection=yes;')

cursor = cnxn.cursor()
cursor.execute("INSERT INTO dbo.gravadora values (1,'Sony','www.sony.com','Rua dos paranaue',5,'608717167')")
print()
cnxn.commit()
