from flask import Flask, jsonify, request
from sqlalchemy import create_engine, text
import pymysql

def db_connector():
    
    db = pymysql.connect(host="localhost", user="jieun", passwd="1109", db="test", charset="utf8")

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




if __name__ == "__main__" :
    app.run(host="0.0.0.0", port="8081")



