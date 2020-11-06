import requests
from bs4 import BeautifulSoup

import cx_Oracle

music_chart = []

conn = cx_Oracle.connect("STUDY", "STUDY", "localhost/XE")

conn.autocommit = True

cursor = conn.cursor()

cursor.execute("SELECT snum, count(ORDERNUM) AS ORDERCNT,sum(PAY_PRICE)AS Tprice,sum(BUBBLE) FROM ORDERLIST o WHERE pay_date BETWEEN TO_CHAR(SYSDATE-1, 'yyyy-mm-dd') AND TO_CHAR(sysdate,'yyyy-mm-dd') GROUP BY TO_CHAR(SYSDATE-1, 'yyyy-mm-dd'), SNUM")
idx=0
row = cursor.fetchall()
for one in row:
    if one is None:
        break
    else:
        sql = """INSERT INTO STATISTIC (SNO, SNUM, CDAY, OQ, OP) 
                VALUES (STATS_SEQ.nextval,:1,sysdate-1,:2,:3)"""
        t = (str(one[0]),(one[1]),(one[2])-(one[3]))
        cursor.execute(sql,t)
cursor.close()
