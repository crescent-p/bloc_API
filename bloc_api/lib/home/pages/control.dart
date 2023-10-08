import 'package:bloc_api/authentication/models/database.dart';
import 'package:bloc_api/database/database_methods.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  bool _isLoading = false;
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

  Time _time = Time(hour: 12, minute: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Color.fromARGB(255, 205, 255, 199),
                            title: Text(
                                "${_selectedDates[index].hour.toString()} : ${_selectedDates[index].minute.toString()}"),
                          );
                        },
                        itemCount: _selectedDates.length,
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.done)),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          showSecondSelector: true,
                          context: context,
                          value: _time,
                          minuteInterval: TimePickerInterval.FIVE,
                          // Optional onChange to receive value as DateTime
                          onChangeDateTime: (DateTime dateTime) {
                            // print(dateTime);
                            _selectedDates.add(dateTime);
                            setState(() {});
                          },
                          onChange: (Time) {},
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
