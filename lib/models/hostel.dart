class Hostel {
  final String roomType;
  final String seater;
  final String hostel;
  final String roomNumber;
  final String bed;

  Hostel({
    required this.roomType,
    required this.seater,
    required this.hostel,
    required this.roomNumber,
    required this.bed,
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      roomType: json['room_type'],
      seater: json['seater'],
      hostel: json['hostel'],
      roomNumber: json['room_number'],
      bed: json['bed'],
    );
  }
}
