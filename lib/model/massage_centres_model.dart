// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MassageCentre {
  final int id;
  final String imageUrl;
  final String title;
  final String address;
  final String phoneNumber;
  int? bookingCount;

  MassageCentre({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.phoneNumber,
    required this.bookingCount,
  });

  MassageCentre copyWith({
    int? id,
    String? imageUrl,
    String? title,
    String? address,
    String? phoneNumber,
    int? bookingCount,
  }) {
    return MassageCentre(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bookingCount: bookingCount ?? this.bookingCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'address': address,
      'phoneNumber': phoneNumber,
      'bookingCount': bookingCount,
    };
  }

  factory MassageCentre.fromMap(Map<String, dynamic> map) {
    return MassageCentre(
      id: map['id'] as int,
      imageUrl: map['imageUrl'] as String,
      title: map['title'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      bookingCount: map['bookingCount'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  // factory MassageCentre.fromJson(String source) =>
  //     MassageCentre.fromMap(json.decode(source) as Map<String, dynamic>);
  factory MassageCentre.fromJson(String? source) {
    if (source == null || source.isEmpty) {
      throw Exception("Invalid source: $source");
    }

    return MassageCentre.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'MassageCentre(id: $id, imageUrl: $imageUrl, title: $title, address: $address, phoneNumber: $phoneNumber, bookingCount: $bookingCount)';
  }

  @override
  bool operator ==(covariant MassageCentre other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.title == title &&
        other.address == address &&
        other.phoneNumber == phoneNumber &&
        other.bookingCount == bookingCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        title.hashCode ^
        address.hashCode ^
        phoneNumber.hashCode ^
        bookingCount.hashCode;
  }
}
