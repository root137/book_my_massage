import 'package:book_my_massage/model/massage_centres_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../pages/booking_screen.dart';

class MassageListItem extends StatelessWidget {
  const MassageListItem({
    Key? key,
    required this.massageCentre,
    required this.onBookingComplete,
    required this.bookingCount,
  }) : super(key: key);

  final MassageCentre massageCentre;
  final VoidCallback onBookingComplete;
  final int bookingCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                massageCentre.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    massageCentre.title,
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
                        const Icon(
                          Icons.location_on,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          massageCentre.address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      launchDialer();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.phone, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          massageCentre.phoneNumber,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Text(
                    "Bookings:$bookingCount",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 130),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, backgroundColor: Colors.black38),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookingScreen()),
                      );

                      if (result != null && result == true) {
                        onBookingComplete();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void launchDialer() async {
  final Uri url = Uri(
    scheme: 'tel',
    path: "9803736532",
  );
  await launchUrl(url);
}

void launchMap() async {
  const String lat = "42.3540";
  const String lng = "71.0586";
  const String mapUrl = "geo:$lat,$lng";
  if (await canLaunchUrlString(mapUrl)) {
    await launchUrlString(mapUrl);
  } else {
    print("Couldn't launch Map");
  }
}
