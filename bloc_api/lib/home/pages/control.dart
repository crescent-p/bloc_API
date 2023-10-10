import 'package:bloc_api/authentication/models/database.dart';
import 'package:bloc_api/database/database_methods.dart';
import 'package:bloc_api/methods/storage/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  FireStoreServices _fireStoreServices = FireStoreServices();

  bool _isLoading = false;
  List<DateTime> _uploadedDates = [];
  List<DateTime> _selectedDates = [];

  refreshDatabase() async {
    setState(() {
      _isLoading = true;
    });
    try {
      MyDatabase _myDatabase = await DatabaseMethods.instance.readLast();
      _selectedDates = _myDatabase.timeDateList ?? [];
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    refreshDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  const Text("Selected Timings",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: StreamBuilder(
                            stream: _fireStoreServices.getDateTimes(
                                FirebaseAuth.instance.currentUser!.email!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                DocumentSnapshot<Object?> obj =
                                    snapshot.data as DocumentSnapshot<Object?>;
                                print(obj.data());
                                _uploadedDates[0] =
                                    DateTime.parse(obj["dateTime1"]);
                                _uploadedDates[1] =
                                    DateTime.parse(obj["dateTime2"]);
                                _uploadedDates[2] =
                                    DateTime.parse(obj["dateTime3"]);
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      tileColor: const Color.fromARGB(
                                          255, 205, 255, 199),
                                      title: Text(
                                          "${_uploadedDates[index].hour.toString()} : ${_uploadedDates[index].minute.toString()}"),
                                    );
                                  },
                                  itemCount: _uploadedDates.length,
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            })),
                  ),
                  const Text("Modify Timings",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: const Color.fromARGB(255, 205, 255, 199),
                            title: Text(
                                "${_selectedDates[index].hour.toString()} : ${_selectedDates[index].minute.toString()}"),
                          );
                        },
                        itemCount: _selectedDates.length,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await _fireStoreServices.uploadDateTimes(
                            FirebaseAuth.instance.currentUser!.email!,
                            _selectedDates[0].toIso8601String(),
                            _selectedDates[1].toIso8601String(),
                            _selectedDates[1].toIso8601String());

                        _selectedDates.clear();
                        setState(() {
                          _selectedDates = [];
                        });
                      },
                      icon: const Icon(Icons.done)),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          showSecondSelector: true,
                          context: context,
                          value: Time(hour: 3, minute: 5),
                          blurredBackground: true,
                          minuteInterval: TimePickerInterval.FIVE,
                          // Optional onChange to receive value as DateTime
                          onChangeDateTime: (DateTime dateTime) {
                            // print(dateTime);
                            _selectedDates.add(dateTime);
                          },
                          onChange: (time) {},
                        ),
                      );
                    },
                    child: const Text(
                      "Open time picker",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ));
  }
}
