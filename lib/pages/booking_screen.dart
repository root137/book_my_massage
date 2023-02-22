import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        backgroundColor: Colors.black38,
        title: Center(
          child: Text(
            "Bookings",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              'http://massage4you.in/wp-content/uploads/2020/02/female-body-massage.jpg',
              height: 300,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'BEAUTY HEALTH SPA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      launchMap();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'New Baneshwor, Kathmandu',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      launchDialer();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.phone, size: 16),
                        SizedBox(width: 5),
                        Text(
                          '9803736532',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        labelText: 'Select Date',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2050, 12, 31),
                          onConfirm: (date) {
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.access_time),
                        labelText: 'Select Time',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (time) {
                            final selectedDateTime = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              time.hour,
                              time.minute,
                            );
                            timeController.text =
                                DateFormat('hh:mm a').format(selectedDateTime);
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 50),
                    elevation: 12,
                    backgroundColor: Colors.black38),
                onPressed: () {
                  if (dateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please select a date.'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  } else if (timeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please select a time.'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  } else {
                    //  for booking and storing data in local storage
                  }
                },
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
