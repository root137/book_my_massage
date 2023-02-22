import 'package:book_my_massage/pages/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        backgroundColor: Colors.black38,
        title: Center(
          child: Text(
            "Massage Centers",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        'http://massage4you.in/wp-content/uploads/2020/02/female-body-massage.jpg',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Row(
                        children: [
                          Text(
                            "Bookings: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 150),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10, backgroundColor: Colors.black38),
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BookingScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
