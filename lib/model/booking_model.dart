class BookingModel {
  final int? id;
  final String date;
  final String time;

  BookingModel({this.id, required this.date, required this.time});

  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date, 'time': time};
  }

  static BookingModel fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      date: map['date'],
      time: map['time'],
    );
  }
}
