class CategoryResponse {
  int? id;
  String? name;
  int? company;
  int? parent;
  String? parentName;

  CategoryResponse(
      {this.id, this.name, this.company, this.parent, this.parentName});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
    parent = json['parent'];
    parentName = json['parent_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['company'] = company;
    data['parent'] = parent;
    data['parent_name'] = parentName;
    return data;
  }
}


class CreateCategoryResponse {
  String? type;
  String? details;

  CreateCategoryResponse({this.type, this.details});

  CreateCategoryResponse.fromJson(Map<String, dynamic> json) {
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
