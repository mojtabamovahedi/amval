
class UnitResponse {
  int? id;
  String? name;
  int? company;

  UnitResponse({this.id, this.name, this.company});

  UnitResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['company'] = company;
    return data;
  }

  bool isNotEmpty(){
    if (id == null && name == null && company == null){
      return false;
    }
    return true;
  }
}


class CreateUnitResponse {
  String? type;
  String? details;

  CreateUnitResponse({this.type, this.details});

  CreateUnitResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['details'] = details;
    return data;
  }
}