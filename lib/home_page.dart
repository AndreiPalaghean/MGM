import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData(BuildContext context) async {
  final response = await http
      .get(Uri.parse('https://mgm-hns-firebase-server.onrender.com/get'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load data from the API');
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MGM APP'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 235, 235, 211),
      ),
      backgroundColor: Color.fromARGB(255, 60, 60, 59),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final data = await fetchData(context);
                  if (data.containsKey('pump')) {
                    var pumpStatus = data['pump'];
                    var updatedData = json.decode(json.encode(data));
                    if (pumpStatus == 'off') {
                      updatedData['pump'] = 'on';
                      // Send a request to turn on the water pump
                      var response = await http.post(
                        Uri.parse(
                            'https://mgm-hns-firebase-server.onrender.com/post'),
                        body: json.encode(updatedData),
                        headers: {'Content-Type': 'application/json'},
                      );
                      if (response.statusCode == 200) {
                        print('Water pump turned on');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Water pump started')),
                        );
                      } else {
                        print('Failed to turn on the water pump');
                      }
                    } else if (pumpStatus == 'on') {
                      updatedData['pump'] = 'off';
                      // Send a request to turn off the water pump
                      var response = await http.post(
                        Uri.parse(
                            'https://mgm-hns-firebase-server.onrender.com/post'),
                        body: json.encode(updatedData),
                        headers: {'Content-Type': 'application/json'},
                      );
                      if (response.statusCode == 200) {
                        print('Water pump turned off');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Water pump stopped')),
                        );
                      } else {
                        print('Failed to turn off the water pump');
                      }
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.water_drop,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: Text('Water Pump'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 235, 235, 211),
                foregroundColor: Color.fromARGB(255, 60, 60, 59),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final data = await fetchData(context);
                  if (data.containsKey('soil')) {
                    var soilData = data['soil'];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 235, 235, 211),
                          title: Text('Soil Humidity'),
                          content: Text('Humidity Level: $soilData'),
                          actions: [
                            Theme(
                              data: ThemeData(
                                textTheme: TextTheme(
                                    button: TextStyle(
                                        color:
                                            Color.fromARGB(255, 60, 60, 59))),
                              ),
                              child: TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.thermostat,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: Text('Temperature'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 235, 235, 211),
                foregroundColor: Color.fromARGB(255, 60, 60, 59),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Add functionality for Button 1
              },
              icon:
                  Icon(Icons.lightbulb, color: Color.fromARGB(255, 60, 60, 59)),
              label: Text('Light Control'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 235, 235, 211),
                foregroundColor: Color.fromARGB(255, 60, 60, 59),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
