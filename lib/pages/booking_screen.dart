import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

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
            style: TextStyle(color: Colors.black54),
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
            Text(
              'Massage Therapy',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Icon(Icons.location_on),
                SizedBox(width: 8.0),
                Text(
                  'Baneshwor, KTM',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Icon(Icons.phone),
                SizedBox(width: 8.0),
                Text(
                  '555-555-5555',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2100, 12, 31),
                        onConfirm: (date) {
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(date);
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: 'Select Time',
                      border: OutlineInputBorder(),
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
                  ),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10, backgroundColor: Colors.black38),
                onPressed: () {},
                child: Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
