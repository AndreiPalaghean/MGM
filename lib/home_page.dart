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
        title: const Text('MGM APP'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 235, 211),
      ),
      backgroundColor: const Color.fromARGB(255, 60, 60, 59),
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
                          const SnackBar(content: Text('Water pump started')),
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
                          const SnackBar(content: Text('Water pump stopped')),
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
              icon: const Icon(Icons.water_drop,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: const Text('Water Pump'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 235, 211),
                foregroundColor: const Color.fromARGB(255, 60, 60, 59),
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
                          backgroundColor:
                              const Color.fromARGB(255, 235, 235, 211),
                          title: const Text('Soil Humidity'),
                          content: Text('Humidity Level: $soilData'),
                          actions: [
                            Theme(
                              data: ThemeData(
                                textTheme: const TextTheme(
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
              icon: const Icon(Icons.thermostat,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: const Text('Soil Humidity'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 235, 211),
                foregroundColor: const Color.fromARGB(255, 60, 60, 59),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final data = await fetchData(context);
                  if (data.containsKey('light')) {
                    var pumpStatus = data['light'];
                    var updatedData = json.decode(json.encode(data));
                    if (pumpStatus == 'off') {
                      updatedData['light'] = 'on';
                      // Send a request to turn on the water pump
                      var response = await http.post(
                        Uri.parse(
                            'https://mgm-hns-firebase-server.onrender.com/post'),
                        body: json.encode(updatedData),
                        headers: {'Content-Type': 'application/json'},
                      );
                      if (response.statusCode == 200) {
                        print('Lights are ON');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lights turned ON')),
                        );
                      } else {
                        print('Failed to turn on the lights');
                      }
                    } else if (pumpStatus == 'on') {
                      updatedData['light'] = 'off';
                      // Send a request to turn off the lights
                      var response = await http.post(
                        Uri.parse(
                            'https://mgm-hns-firebase-server.onrender.com/post'),
                        body: json.encode(updatedData),
                        headers: {'Content-Type': 'application/json'},
                      );
                      if (response.statusCode == 200) {
                        print('Lights are off');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Lights are turned OFF')),
                        );
                      } else {
                        print('Failed to turn off the lights');
                      }
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              icon: const Icon(Icons.lightbulb,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: const Text('Light Control'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 235, 211),
                foregroundColor: const Color.fromARGB(255, 60, 60, 59),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final data = await fetchData(context);
                  if (data.containsKey('light_intesity')) {
                    var lightData = data['light_intesity'];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 235, 235, 211),
                          title: const Text('Light Intensity'),
                          content: Text('Light Intensity: $lightData'),
                          actions: [
                            Theme(
                              data: ThemeData(
                                textTheme: const TextTheme(
                                  button: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 59)),
                                ),
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
              icon: const Icon(Icons.light_mode,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: const Text('Light Sensor'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 235, 211),
                foregroundColor: const Color.fromARGB(255, 60, 60, 59),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final data = await fetchData(context);
                  if (data.containsKey('humidity')) {
                    var humidityData = data['humidity'];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 235, 235, 211),
                          title: const Text('Air Humidity'),
                          content: Text('Air Humidity: $humidityData'),
                          actions: [
                            Theme(
                              data: ThemeData(
                                textTheme: const TextTheme(
                                  button: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 59)),
                                ),
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
              icon: const Icon(Icons.water_damage_rounded,
                  color: Color.fromARGB(255, 60, 60, 59)),
              label: const Text('Humidity'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 235, 211),
                foregroundColor: const Color.fromARGB(255, 60, 60, 59),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
