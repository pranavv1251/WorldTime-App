import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String flag;
  String time = "";
  String location;
  String url;
  bool isDayTime = true;

  WorldTime(
      {required this.location,
      required this.flag,
      required this.url,});

  Future<void> getTime() async {
    try {
      //var url = Uri.http('worldtimeapi.org','api/timezone/Europe/London');
      http.Response response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create DateTime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not load data';
    }
  }
}
