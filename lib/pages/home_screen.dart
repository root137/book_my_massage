import 'package:book_my_massage/helper/massage_centre_data.dart';
import 'package:book_my_massage/widgets/massage_list_item.dart';
import 'package:flutter/material.dart';

import '../helper/database_helper.dart';
import '../model/massage_centres_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bookingCount = 0;

  @override
  void initState() {
    super.initState();
    _loadBookingCount();
  }

  Future<void> _loadBookingCount() async {
    final dbHelper = DatabaseHelper.instance;
    final count = await dbHelper.totalBookings();
    setState(() {
      _bookingCount = count!;
    });
  }

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
      body: FutureBuilder<List<MassageCentre>>(
          future: DataUtils.loadDataFromDb(),
          builder: (_, snapShot) {
            debugPrint('snapshot: ${snapShot.data}');
            if (snapShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapShot.hasData) {
              final massagesList = snapShot.data;
              return ListView.separated(
                itemCount: massagesList!.length,
                separatorBuilder: ((context, index) => SizedBox(
                      height: 8,
                    )),
                itemBuilder: ((context, index) => MassageListItem(
                      bookingCount: _bookingCount,
                      massageCentre: massagesList[index],
                      onBookingComplete: () {
                        _loadBookingCount();
                        setState(() {});
                      },
                    )),
              );
            }
            if (snapShot.hasError) {
              return Text('Error Occurred: ${snapShot.error}');
            }
            return Container();
          }),
    );
  }
}
