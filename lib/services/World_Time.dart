import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //location name for the UI
  String time; //time name for the UI
  String flag; //URL to an asset flag icon
  String url; //location URL for api endpoints
  bool isDaytime; //true or false

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      print(offset);


      //create Datetime object
      DateTime now = DateTime.parse(datetime);
      print('before formatting $now');
      now = now.add(Duration(hours: int.parse(offset)));
      print('after formatting $now');
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      //set time property
      time  = DateFormat.jm().format(now);
      print('this is the time after using date format $time');
    }
    catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
    }


  }

}

