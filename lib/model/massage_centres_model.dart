class MassageCentres {
  int id;
  String imageUrl;
  String title;
  String address;
  String phoneNumber;

  MassageCentres({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.phoneNumber,
  });

  factory MassageCentres.fromJson(Map<String, dynamic> json) {
    return MassageCentres(
      id: json['id'],
      imageUrl: json['image_url'],
      title: json['title'],
      address: json['address'],
      phoneNumber: json['phone_number'],
    );
  }
}
