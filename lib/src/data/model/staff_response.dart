class StaffResponse {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  double? nationalId;
  String? password;
  int? company;

  StaffResponse(
      {this.id,
        this.username,
        this.firstName,
        this.lastName,
        this.nationalId,
        this.password,
        this.company});

  StaffResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    nationalId = json['national_id'];
    password = json['password'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['national_id'] = nationalId;
    data['password'] = password;
    data['company'] = company;
    return data;
  }
}