const char MAIN_page[] PROGMEM = R"=====(
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport"content="width=device-width,initial-scale=1,user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<style>
body{text-align:center;font-family:verdana;}
h2{font-size: 2.0rem}
button{border:0;border-radius:1.5rem;background-color:#0066ff;color:rgb(255, 255, 255);line-height:2.4rem;font-size:1.2rem;width:100%}
p { font-size: 1.6rem; }
​​.units { font-size: 1.2rem; }
​​.dht-heading{
​​​​font-size: 1.5rem;
​​​​vertical-align:middle;
​​​​padding-bottom: 5px; padding-top: 15px;
​​}
</style>
</head>

<TITLE>
WIFI Controller
</TITLE>

<BODY>
<div style="text-align:center;display:inline-block;min-width:280px;">
<h2>온습도 모니터링</h2>
<p>
​​<span class="dht-heading">온도/습도</span>
</p>
<p>
​​<span>
​​<i class="fas fa-thermometer-half" style="color:#059e8a;"></i>
​​​​<sup id="temperature">@@TEMP@@</sup>
​​​​<sup class="units">&deg;C / </sup>
​​</span> 
​​<span>
​​<i class="fas fa-tint" style="color:#00add6;"></i> 
​​​​<sup id="humidity">@@HUMI@@</sup>
​​​​<sup class="units">%</sup>
​​</span>
</p>
</div>
</BODY>

<script>
​​​​setInterval(function ( ) {
​​​​​​var xhttp = new XMLHttpRequest();
​​​​​​xhttp.onreadystatechange = function() {
​​​​​​​​if (this.readyState == 4 && this.status == 200) {
​​​​​​​​​​document.getElementById("temperature").innerHTML = this.responseText;
​​​​​​​​}
​​​​​​};
​​​​​​xhttp.open("GET", "/temperature", true);
​​​​​​xhttp.send();
​​​​}, 10000 ) ;
​​​​
​​​​setInterval(function ( ) {
​​​​​​var xhttp = new XMLHttpRequest();
​​​​​​xhttp.onreadystatechange = function() {
​​​​​​​​if (this.readyState == 4 && this.status == 200) {
​​​​​​​​​​document.getElementById("humidity").innerHTML = this.responseText;
​​​​​​​​}
​​​​​​};
​​​​​​xhttp.open("GET", "/humidity", true);
​​​​​​xhttp.send();
​​​​}, 10000 ) ;
​​​​</script>

</HTML>
)=====";