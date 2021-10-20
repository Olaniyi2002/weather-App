import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import 'package:weather_app/Utils/weathermodel.dart';

import 'Search.dart';
import 'loading.dart';

const apiKey = '38623cc7dcfa38c5582fdb27871943f7';

class Weather extends StatefulWidget {


  @override
  _WeatherState createState() => _WeatherState();
}
bool loading=true;
class _WeatherState extends State<Weather> {
  var latitude;
  var longitude;
  var  wind, humidity, feel, pressure;
  var respond,citi,icon,des,webIcon;

  @override
  void initState(){
    super.initState();

    location();
    getWeather();
  }

  void location() async {
    WeatherModel weather = WeatherModel();
    await weather.getLocation();
    latitude = weather.latitude;
    longitude = weather.longitude;
    print(latitude);
    getWeather();
  }


  Future<dynamic> getWeather() async {

    http.Response response = await http.get("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric");
    print(response.body);
    respond=response.statusCode;
   setState(() {
     loading=true;
     if(response.statusCode==200){
       data=response.body;
      citi = jsonDecode(data)['name'];
      temp = jsonDecode(data)['main']['temp'];
       temperature = temp.toInt();
       wind=jsonDecode(data)['wind']['speed'];
       humidity=jsonDecode(data)['main']['humidity'];
       pressure=jsonDecode(data)['main']['pressure'];
       feel=jsonDecode(data)['main']['feels_like'];
       icon=jsonDecode(data)['weather'][0]['icon'];
       des=jsonDecode(data)['weather'][0]['description'];
       webIcon='https://openweathermap.org/img/wn/$icon@4x.png';
       loading=false;
     }else{
   print(response.statusCode);
     }
   });

  }
  Future<void> getData(var city)async{
    loading=true;

    http.Response response = await http.get("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    setState(() {
      if(response.statusCode==200){
        data=response.body;
        citi = jsonDecode(data)['name'];
        temp = jsonDecode(data)['main']['temp'];
        temperature = temp.toInt();
        wind=jsonDecode(data)['wind']['speed'];
        humidity=jsonDecode(data)['main']['humidity'];
        pressure=jsonDecode(data)['main']['pressure'];
        feel=jsonDecode(data)['main']['feels_like'];
        icon=jsonDecode(data)['weather'][0]['icon'];
        des=jsonDecode(data)['weather'][0]['description'];
        webIcon='https://openweathermap.org/img/wn/$icon@4x.png';
        print(data);
        loading=false;
      }else{
        print(response.statusCode);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return  loading==true ? Loading() : Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        if(cityName==null) {
                          Loading();
                        }else{
                          return await getWeather();
                        }
                      }),
                  Text(
                   citi.toString(),
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(icon: Icon(Icons.search,
                    color: Colors.white,
                    size: 30,),
                      onPressed: ()async{
                   var typed= await Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Search();
                    }));//This is the city name passed from the search.dart
                   if(icon==null){
                     return Navigator.push(context, MaterialPageRoute(builder: (context){
                       return Loading();
                     }));
                   }
                   if(typed!=null){
                    getData(typed);
                   }else{

                   }

                  })
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.network(webIcon,scale: 0.7,
                          ),
                        ),
                  Text(temperature.toString() + "°C",
                      style: TextStyle(fontSize: 50, color: Colors.white70)),
                  Text(des,style: TextStyle(fontSize: 20, color: Colors.white60)),
                ],
              ),
            ),
            Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("Wind", " $wind mps"),
                    box("Humidity", "$humidity\u2105"),
                    box("Feels Like", "$feel\u2103"),
                    box("Pressure", "$pressure pas")
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Padding box(String text, String sub) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [Text(text,
              style: TextStyle(fontWeight:FontWeight.w900,color:Colors.blue[900] ),), Text(sub,
                style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue[900]  ))],
          ),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[300],
            border: Border.all(width: 3, color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ]),
      ),
    );
  }
}
