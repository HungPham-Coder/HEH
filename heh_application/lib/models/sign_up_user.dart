class SignUpUser {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String email;
  final int gender;
  final String dob;
  SignUpUser(  {required this.firstName, required this.lastName,required this.phone, required this.password,required this.email, required this.gender, required this.dob,});

  factory SignUpUser.fromJson(Map<String, dynamic> json){
    return SignUpUser(
        phone: json["Username"],
        password: json["Password"],
        email: json[''],
      dob: '',
      gender: 0,
      firstName: '',
      lastName: '',
    );
  }
}