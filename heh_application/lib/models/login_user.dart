class LoginUser {
  final String phone;
  final String password;

  LoginUser( {required this.phone,  required this.password});
  factory LoginUser.fromJson(Map<String, dynamic> json){
    return LoginUser(
      phone: json["phoneNumber"],
        password: json["password"]
    );
  }
}