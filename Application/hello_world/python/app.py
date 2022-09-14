import datetime
from flask import Flask, request, render_template
import pymysql
from datetime import date, timedelta

from sqlalchemy import null

def db_connector():
    
    db = pymysql.connect(host="192.168.35.41", user="jieun", passwd="1109", db="test", charset="utf8")

    # DB와 상호작용하기 위한 객체
    cur = db.cursor()

    sql = "SELECT * from DHT11"
    cur.execute(sql)

    data_list = cur.fetchall()
    db.close()

    return str(data_list)
    

app = Flask(__name__)

@app.route('/', methods = ['GET'])

def test():
    # args = request.args
    # print(args)
    a = db_connector()
    b = a.split(',')

    print(b[-8], b[-7], b[-6], b[-5], b[-4], b[-3], b[-2], b[-1])
    print(b.__len__())
    c = b[-8].split('(') #온도
    print('c = ', c)
    d = b[-7].split(' ') # 습도
    print('d = ', d[1])
    e = b[-6].split('(')
    print('e =', e[1])
    print(c)
    print('날짜 = ', b[-5], b[-4],)
    f = b[-1].split(')')
    print('시간 = ', b[-3], b[-2], f[0])

    i = (e[1]+b[-5]+b[-4]).split(' ')
    print('i = ',i)

    I = '/'.join(i)
    print('I = ', I)
    h = (b[-3]+b[-2]+f[0]).split(' ')
    H = ':'.join(h[1:])

    print('H = ',H)


    B = a.split('))),')
    print('B[-1] = ', B[-1])
    C = B[-1]
    C.split('))')
    print('C = ',C)


    json_dict = dict(Temperature = float(str(c[1])), Humidity = float(str(d[1])), Date = str(I), Time = str(H) )

    return json_dict

# @app.route('/logging_page', methods = ['GET'])
# def log():
#     if request:
#         log_dict = {}
#         db = pymysql.connect(host="192.168.123.182", user="jieun", passwd="1109", db="test", charset="utf8")
#         cur = db.cursor()
    
#         cur.execute('TRUNCATE TABLE logging')
    
#         today = datetime.now()
#         today_date = datetime.date(today) - timedelta(days=5)
#         num_of_days = 3

#         dates = []
#         for i in range(num_of_days):
#             dates.append(str(today_date-timedelta(i)))
            
#         dates.reverse()
    
#         Air_dates = []
#         Water_dates = []
#         for i in range(num_of_days):
#             Air_dates.append("SELECT * FROM Sensor_Air WHERE update_time >= " + "'" + str(dates[i]))
#             Water_dates.append("SELECT * FROM Sensor_Air WHERE update_time >= " + "'" + str(dates[i]))

#         hours = []
#         for i in range(2):
#             for j in range(10):
#                 hours.append(str(i)+str(j))
#         hours.extend(['20', '21', '22', '23'])
#         print(hours)

#         Air_query = []
#         Water_query = []
#         for i in range(num_of_days):
#             for j in range(24):
#                 Air_query.append(Air_dates[i]+" "+hours[j]+":00:00' AND update_time <= '"+str(dates[i])+" "+hours[j]+":00:10'")
#                 Water_query.append(Water_dates[i]+" "+hours[j]+":00:00' AND update_time <= '"+str(dates[i])+" "+hours[j]+":00:10'")
        
#         for i in range(num_of_days*24):
#             cur.execute(Air_query[i])
#             Air_data = cur.fetchone()
#             print(Air_data)
#             cur.execute(Water_query[i])
#             Water_data = cur.fetchone()
            
#             if (Air_data):
#                 insert_sql = ("INSERT INTO logging (Hour, Air_Temp, Air_Humi, Brightness, Co2, Water_Temp, Water_Levl, pH) VALUES ('%s', '%f', '%d', '%d', '%d', '%f', '%f', '%f')" 
#                           % (Air_data[1], Air_data[2], Air_data[3], Air_data[4], Air_data[5], Water_data[2], Water_data[3], Water_data[4]))
#                 cur.execute(insert_sql)
#                 log_dict[str(i)] = (str(Air_data[1]), str(Air_data[2]), str(Air_data[3]), str(Air_data[4]), str(Air_data[5]), str(Water_data[2]), str(Water_data[3]), str(Water_data[4]))
#             else:
#                 insert_sql = "INSERT INTO logging (Hour, Air_Temp, Air_Humi, Brightness, Co2, Water_Temp, Water_Levl, pH) VALUES ('0', '0', '0', '0', '0', '0', '0', '0')"
#                 cur.execute(insert_sql)

#         db.commit()

#     return render_template('log.html', log_dict=log_dict)
    


if __name__ == "__main__" :
    app.run(host="0.0.0.0", port="8081")



