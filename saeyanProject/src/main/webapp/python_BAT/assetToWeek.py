import requests
from bs4 import BeautifulSoup

import cx_Oracle

conn = cx_Oracle.connect("STUDY", "STUDY", "localhost/XE")

conn.autocommit = True

cursor = conn.cursor()

cursor.execute("SELECT snum,sum(PAY_PRICE) AS A_PRICE,SNAME,sum(BUBBLE) FROM ORDERLIST o WHERE REFUND='N' AND PAY_DATE BETWEEN TO_CHAR(SYSDATE-8, 'yyyy-mm-dd') AND TO_CHAR(sysdate,'yyyy-mm-dd') GROUP BY SNUM,SNAME")
idx=0
row = cursor.fetchall()
for one in row:
    if one is None:
        break
    else:
        sql = """INSERT INTO ASSET (SNUM, A_PRICE,PERIODSTART, A_CHECK, PERIODEND, ASSET_SEQ,SNAME) 
                VALUES(:1, :2,sysdate-7, 'N', sysdate-1, ASSET_SEQ.nextval,:3)"""
        t= ((one[0]),(one[1])-(one[3]),(one[2]))
        cursor.execute(sql,t)
cursor.close()
