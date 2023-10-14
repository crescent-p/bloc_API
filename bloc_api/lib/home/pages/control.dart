import 'package:bloc_api/shared_preferences/shared.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  bool _isLoading = false;
  List<DateTime>? _uploadedDates = [];
  List<DateTime>? _selectedDates = [];

  @override
  initState() {
    super.initState();
    _uploadedDates = UserSimplePreferences.getTimeData();
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
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 205, 255, 199),
                              title: _uploadedDates == null
                                  ? Text("data")
                                  : Text(
                                      "${_uploadedDates![index].hour.toString()} : ${_uploadedDates![index].minute.toString()}"),
                            );
                          },
                          itemCount: _uploadedDates == null
                              ? 0
                              : _uploadedDates!.length,
                        )),
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
                            title: _selectedDates == null
                                ? Text("data")
                                : Text(
                                    "${_selectedDates![index].hour.toString()} : ${_selectedDates![index].minute.toString()}"),
                          );
                        },
                        itemCount:
                            _selectedDates == null ? 0 : _selectedDates!.length,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (_selectedDates != null) {
                          await UserSimplePreferences.setTimeData(
                              _selectedDates!);
                          _selectedDates!.clear();
                        }

                        setState(() {
                          _uploadedDates = UserSimplePreferences.getTimeData();
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
                            _selectedDates!.add(dateTime);
                            setState(() {
                              _selectedDates = _selectedDates;
                            });
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
