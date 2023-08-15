class UserlLocationFilds {
  static const String lat = "latitude";
  static const String long = "longitude";
  static const String Id = "Id";
  static const String address = "address";
  static const String created = "created";
  static const String locationTable = "newsTable";
}

class UserLocation {
  final double lat;
  final double long;
  final int? Id;
  final String address;
  final String created;
  UserLocation({
    required this.lat,
    required this.long,
    this.Id,
    required this.address,
    required this.created,
  });
  UserLocation copyWith({
    double? latitude,
    double? longitude,
    int? Id,
    String? address,
    String? created,
  }) {
    return UserLocation(
      lat: latitude ?? this.lat,
      long: longitude ?? this.long,
      Id: Id ?? this.Id,
      address:address ?? this.address,
      created: created ?? this.created,
    );
  }

  factory UserLocation.fromjson(Map<String, dynamic> json) {
    return UserLocation(
      lat: json[UserlLocationFilds.lat] as double? ?? 0.0,
      long: json[UserlLocationFilds.long]as double? ?? 0.0,
      Id: json[UserlLocationFilds.Id]?? 0 ,
      address: json[UserlLocationFilds.address] as String? ?? "" ,
      created: json[UserlLocationFilds.created]as String? ?? "" ,
    );
  }
  Map<String, dynamic> toJson() => {
        UserlLocationFilds.lat: lat,
        UserlLocationFilds.long: long,
        UserlLocationFilds.Id: Id,
        UserlLocationFilds.address: address,
        UserlLocationFilds.created: created,
      };
  @override
  String toString() {
    return """
        ${UserlLocationFilds.lat}:$lat,
        ${UserlLocationFilds.long}:$long,
        ${UserlLocationFilds.Id}:$Id,
        ${UserlLocationFilds.address}:$address,
        ${UserlLocationFilds.created}:$created,
        """;
  }
}
