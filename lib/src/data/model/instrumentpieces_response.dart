class InstrumentPiecesResponse {
  int? id;
  String? name;
  String? image;
  int? serialCode;
  int? staffs;
  int? instruments;

  InstrumentPiecesResponse(
      {this.id,
        this.name,
        this.image,
        this.serialCode,
        this.staffs,
        this.instruments});

  InstrumentPiecesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    serialCode = json['serial_code'];
    staffs = json['staffs'];
    instruments = json['instruments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['serial_code'] = serialCode;
    data['staffs'] = staffs;
    data['instruments'] = instruments;
    return data;
  }
}
