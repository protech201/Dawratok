class Course {
  late String IdCourse;
  late String nameCourse;
  late String nameCourseEn;
  late String nameTeacher;
  late String nameTeacherEn;
  late String address;
  late String addressEn;
  late String content;
  late String contentEn;
  late String imageUrl;
  late bool isOnline;
  late String stars;
  Course({
    required this.nameCourse,
    required this.nameCourseEn,
    required this.nameTeacher,
    required this.nameTeacherEn,
    required this.address,
    required this.addressEn,
    required this.content,
    required this.contentEn,
    required this.imageUrl,
    required this.isOnline,
    required this.stars,
  });

  Course.fromMap(Map<String,dynamic> map){

    nameCourse = map['nameCourse'];
    nameCourseEn = map['nameCourseEn'];
    nameTeacher = map['nameTeacher'];
    nameTeacherEn = map['nameTeacherEn'];
    address = map['address'];
    addressEn = map['addressEn'];
    content = map['content'];
    contentEn = map['contentEn'];
    imageUrl = map['imageUrl'];
    isOnline = map['isOnline'];
    stars = map['stars'];
  }

  toMap(){
    return{
      'nameCourse' : nameCourse,
      'nameCourseEn' : nameCourseEn,
      'nameTeacher' : nameTeacher,
      'nameTeacherEn' : nameTeacherEn,
      'address' : address,
      'addressEn' : addressEn,
      'content' : content,
      'contentEn' : contentEn,
      'imageUrl' : imageUrl,
      'isOnline' : isOnline,
      'stars' : stars
    };
  }

}