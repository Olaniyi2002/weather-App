

import 'package:flutter/material.dart';
import 'package:weather_app/Screens/weather.dart';

const apiKey = '38623cc7dcfa38c5582fdb27871943f7';
class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();

}
var cityName;
int temperature;
double temp;
var data;
class _SearchState extends State<Search> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blue,
      body:SafeArea(
        minimum: EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: TextField(
                    onChanged: (val){
                      cityName=val;
                    },

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search your City',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90)
                      ),
                  ),

            ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black
                  ),
                    onPressed: (){
                    setState(() {
                      Navigator.pop(context,cityName);
                      loading=true;
                    });

                    },
                    child: Text('Search')
                )
          ],
        ),
    ]
      ),
    ),
    );
  }
}
