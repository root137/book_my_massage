// ignore_for_file: use_build_context_synchronously

import 'package:book_my_massage/model/massage_centres_model.dart';
import 'package:book_my_massage/widgets/massage_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../helper/database_helper.dart';
import '../model/booking_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, required this.massageCentre})
      : super(key: key);

  final MassageCentre massageCentre;

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
        title: const Center(
          child: Text(
            "Bookings",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              widget.massageCentre.imageUrl,
              height: 300,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.massageCentre.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      launchMap();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          widget.massageCentre.address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      launchDialer(widget.massageCentre.phoneNumber);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.phone, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          widget.massageCentre.phoneNumber,
                          style: const TextStyle(
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
            const SizedBox(height: 30),
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
                      decoration: const InputDecoration(
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextFormField(
                      controller: timeController,
                      decoration: const InputDecoration(
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
                onPressed: () async {
                  if (dateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text('Please select a date.'),
                        duration: const Duration(seconds: 2),
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
                        content: const Text('Please select a time.'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  } else {
                    // Store data in the database
                    final booking = BookingModel(
                      date: dateController.text,
                      time: timeController.text,
                    );
                    final dbHelper = DatabaseHelper.instance;
                    // ignore: unused_local_variable
                    final id = await dbHelper.insertBooking(booking);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text('Booked Successfully!!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                    Navigator.of(context).pop(true);
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
