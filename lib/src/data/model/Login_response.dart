class LoginResponse {
  String? access;
  String? refresh;

  LoginResponse({required this.access, required this.refresh});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
  }
}