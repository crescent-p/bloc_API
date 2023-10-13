import 'package:bloc_api/methods/weather/weather_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User value = FirebaseAuth.instance.currentUser!;
  WeatherData? weatherData;
  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    weatherData = await WeatherData().getWeatherData();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 172, 249, 192)),
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Irrigated On: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text("Next Irrigation On: ",
                            style: TextStyle(fontSize: 20)),
                        // Text("Weather Data: ${weatherData!.description!}",
                        //     style: const TextStyle(fontSize: 20)),
                        Text("data", style: TextStyle(fontSize: 20)),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
