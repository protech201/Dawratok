class AppUser{

  String email;
  String? id;
  String? password;
  String userName;
  String phone;
  bool? isTeacher = false;

  AppUser({required this.email,required this.userName,required this.phone,this.id,this.password, this.isTeacher});

  Map<String,dynamic> toMap(){
    return{
      "email" : email,
      "userName" : userName,
      "phone" : phone,
      "id" : id,
      "isTeacher" : isTeacher
    };
  }


  factory AppUser.fromMap(Map<String,dynamic> map){
    return AppUser(
      email: map["email"] ,
      userName: map["userName"] ,
      phone: map["phone"] ,
      isTeacher: map["isTeacher"] ,
    );
  }


}