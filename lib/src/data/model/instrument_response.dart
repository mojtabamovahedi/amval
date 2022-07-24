class InstrumentResponse {
  int? id;
  String? name;
  String? image;
  int? serialCode;
  int? company;
  int? category;
  int? unit;
  int? staffs;
  String? state;
  String? categoryName;
  String? staffName;
  String? unitName;

  InstrumentResponse(
      {this.id,
        this.name,
        this.image,
        this.serialCode,
        this.company,
        this.category,
        this.unit,
        this.staffs,
        this.state,
        this.categoryName,
        this.staffName,
        this.unitName});

  InstrumentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    serialCode = json['serial_code'];
    company = json['company'];
    category = json['category'];
    unit = json['unit'];
    staffs = json['staffs'];
    state = json['state'];
    categoryName = json['category_name'];
    staffName = json['staff_name'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['serial_code'] = serialCode;
    data['company'] = company;
    data['category'] = category;
    data['unit'] = unit;
    data['staffs'] = staffs;
    data['state'] = state;
    data['category_name'] = categoryName;
    data['staff_name'] = staffName;
    data['unit_name'] = unitName;
    return data;
  }
}