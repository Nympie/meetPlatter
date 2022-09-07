from flask import Flask, request, render_template
from AI_inference.inference import AI_Diagnosis
import json
import pymysql
from datetime import datetime, timedelta



def db_connector():
    db = pymysql.connect(host="192.168.123.182", user="jieun", passwd="1109", db="test", charset="utf8")
    cur = db.cursor()
    
    Water_data = "SELECT * FROM Sensor_Water ORDER BY id DESC LIMIT 1;"
    cur.execute(Water_data)
    Water_list = cur.fetchall()

    Air_data = "SELECT * FROM Sensor_Air ORDER BY id DESC LIMIT 1;"
    cur.execute(Air_data)
    Air_list = cur.fetchall()
    
    data_list = Water_list[0][1:]+ Air_list[0][2:]
    true_data_list = []

    for i in range(len(data_list)):
        true_data_list.append(data_list[i])
    
    data_dict = dict(list=true_data_list)

    db.close()

    return data_dict



app = Flask(__name__)


@app.route('/home', methods = ['GET'])

def DB():
    a = db_connector()
    b = a['list']

    date_time = str(b[0])
    wtemp = b[1]
    wlevel = b[2]
    wph = b[3]
    atemp = b[4]
    ahumi = b[5]
    aco2 = b[6]
    alux = b[7]

    json_dict = dict(Time = str(date_time), WaterTemp = float(str(wtemp)), WaterLevel = float(str(wlevel)), pH = float(str(wph)), AirTemp = float(str(atemp)), AirHumidity = int(str(ahumi)), AirCO2 = int(str(aco2)), Lux = int(str(alux)))
  
    return render_template('home.html', **json_dict)


Data = ''
Switch = False

@app.route('/motor_control', methods=['POST', 'GET'])
def test():
    global Data, Switch
    if (request.method == 'GET'):
        if (Switch):
            Switch = False
            return Data
        return 'D'

    if (request.method == 'POST'):
        Switch = True
        Data = str(request.data)
        print(Data)
    return ''


@app.route('/logging_page', methods = ['GET'])
def log():
    if request:
        log_dict = {}
        db = pymysql.connect(host="192.168.123.182", user="jieun", passwd="1109", db="test", charset="utf8")
        cur = db.cursor()
    
        # cur.execute('TRUNCATE TABLE logging')
    
        today = datetime.now()
        # today_date = datetime.date(today) - timedelta(days=5)
        today_date = datetime.date(today)
        num_of_days = 3

        dates = []
        for i in range(num_of_days):
            dates.append(str(today_date-timedelta(i)))
            
        dates.reverse()
    
        Air_dates = []
        Water_dates = []
        for i in range(num_of_days):
            Air_dates.append("SELECT * FROM Sensor_Air WHERE update_time >= " + "'" + str(dates[i]))
            Water_dates.append("SELECT * FROM Sensor_Air WHERE update_time >= " + "'" + str(dates[i]))

        hours = []
        for i in range(2):
            for j in range(10):
                hours.append(str(i)+str(j))
        hours.extend(['20', '21', '22', '23'])

        Air_query = []
        Water_query = []
        for i in range(num_of_days):
            for j in range(24):
                Air_query.append(Air_dates[i]+" "+hours[j]+":00:00' AND update_time <= '"+str(dates[i])+" "+hours[j]+":00:10'")
                Water_query.append(Water_dates[i]+" "+hours[j]+":00:00' AND update_time <= '"+str(dates[i])+" "+hours[j]+":00:10'")
        
        for i in range(num_of_days*24):
            cur.execute(Air_query[i])
            Air_data = cur.fetchone()
    
            cur.execute(Water_query[i])
            Water_data = cur.fetchone()
            
            if (Air_data):
                insert_sql = ("INSERT INTO logging (Hour, Air_Temp, Air_Humi, Brightness, Co2, Water_Temp, Water_Levl, pH) VALUES ('%s', '%f', '%d', '%d', '%d', '%f', '%f', '%f')" 
                          % (Air_data[1], Air_data[2], Air_data[3], Air_data[4], Air_data[5], Water_data[2], Water_data[3], Water_data[4]))
                cur.execute(insert_sql)
                log_dict[str(i)] = (Air_data[1], Air_data[2], Air_data[3], Air_data[4], Air_data[5], Water_data[2], Water_data[3], Water_data[4])
            else:
                insert_sql = "INSERT INTO logging (Hour, Air_Temp, Air_Humi, Brightness, Co2, Water_Temp, Water_Levl, pH) VALUES ('0', '0', '0', '0', '0', '0', '0', '0')"
                cur.execute(insert_sql)

        db.commit()

    return render_template('log.html', log_dict=log_dict)


@app.route('/log', methods = ['GET'])

def LOG():
    db = pymysql.connect(host="192.168.123.182", user="jieun", passwd="1109", db="test", charset="utf8")
    sql = "SELECT * FROM logging"
    cur = db.cursor()
    cur.execute(sql)
    logging = cur.fetchall()
    log_dict = {}
    LOGG = []

    for i in range(len(logging)):
        LOGG.append(logging[i][1:])


    log_dict = dict(list=LOGG)
    
    db.close()

    return log_dict


@app.route('/', methods = ['GET'])
def home():
    data_dict= db_connector()
    data_list = data_dict['list']

    date_time = data_list[0]
    wtemp = data_list[1]
    wlevel = data_list[2]
    wph = data_list[3]
    atemp = data_list[4]
    ahumi = data_list[5]
    aco2 = data_list[6]
    alux = data_list[7]

    
    json_dict = dict(Time = str(date_time), WaterTemp = float(str(wtemp)), WaterLevel = float(str(wlevel)), pH = float(str(wph)),
                     AirTemp = float(str(atemp)), AirHumidity = int(str(ahumi)), AirCO2 = int(str(aco2)), Lux = int(str(alux)))

    print(json_dict)
    
    return json_dict



@app.route('/monitoringWater', methods = ['POST'])
def wWter_data_receiver():
    if request:
        db = pymysql.connect(host="192.168.123.182", user="jieun", passwd="1109", db="test", charset="utf8")
        cur = db.cursor()

        content = request.get_json()
        key = 'waterTemp'
        Water_value = content.get(key)
        
        print(content)

        if Water_value:
            waterTemp = float(content['waterTemp'][0])
            content['waterTemp'] = waterTemp

            waterLevel = float(content['waterLevel'][0])
            content['waterLevel'] = waterLevel

            pH = float(content['pH'][0])
            content['pH'] = pH

            insert_sql = ("INSERT INTO Sensor_Water (WaterTemp, WaterLevel, pH) VALUES ('%f', '%f', '%f')" %(waterTemp, waterLevel, pH))
            cur.execute(insert_sql)
            
            db.commit()
            
            return ''
        


@app.route('/monitoringAir', methods = ['POST'])
def Air_data_receiver():
    if request:
        db = pymysql.connect(host="192.168.123.182", user="jieun", passwd="1109", db="test", charset="utf8")
        cur = db.cursor()

        content = request.get_json()
        key = 'AirHumi'
        Air_value = content.get(key)

        print(content)

        if Air_value:
            Temperature = float(content['AirTemp'][0])
            content['AirTemp'] = Temperature
            
            Humidity = float(content['AirHumi'][0])
            content['AirHumi'] = Humidity

            CO2 = float(content['Co2'][0])
            content['Co2'] = CO2

            LUX = float(content['LUX'][0])
            content['LUX'] = LUX

            insert_sql2 = ("INSERT INTO Sensor_Air (Temperature,Humidity,CO2,LUX) VALUES ('%f','%d','%d','%d')" %(Temperature,Humidity,CO2,LUX))
            cur.execute(insert_sql2)
            
            db.commit()

            return ''
        



@app.route('/cam', methods=['POST'])
def AI_Diag():
    if request.files['file']:
        raw_image = request.files['file']
        image = raw_image.read()
        
        ai_image = AI_Diagnosis(image)
        ai_image.result_of_inference(4)
        
        StringToDict=ai_image.toJson(ai_image.result)
        DictToJson = json.dumps(StringToDict)
        
    return DictToJson




















if __name__ == "__main__":
    app.run(host='0.0.0.0', port= 9090)
    