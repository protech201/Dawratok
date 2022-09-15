

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawratok/Modle/Course.dart';
import 'package:firebase_core/firebase_core.dart';

import '../Modle/UserApp.dart';


class StoreHelper{

  StoreHelper._();
  static StoreHelper storeHelper = StoreHelper._();
  CollectionReference <Map<String,dynamic>> userCollection =  FirebaseFirestore.instance.collection('Users');
  CollectionReference <Map<String,dynamic>> courseCollection =  FirebaseFirestore.instance.collection('Courses');

  addUserToFirestore(AppUser appUser)async{
    await userCollection.doc(appUser.id).set(appUser.toMap());
    // await userCollection.add(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id)async{
    DocumentSnapshot <Map<String,dynamic>> documentSnapshot = await userCollection.doc(id).get();
    Map<String,dynamic>? data = documentSnapshot.data();
    return AppUser.fromMap(data!);
  }

  Future<Course> addNewCourse(Course course)async{
    DocumentReference<Map<String,dynamic>> documentReference = await courseCollection.add(course.toMap());
    course.IdCourse = documentReference.id;
    return course;

    await courseCollection.add(course.toMap());

  }

  Future<List<Course>> getAllCourses()async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await courseCollection.get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents =querySnapshot.docs;
    List<Course> courses =
            documents.map((e) {
              Course course = Course.fromMap(e.data());
              course.IdCourse = e.id; //عملنا هيك لان id  مش داتا حقيقية "داتا وصفية"
              return course;
            } ).toList();
    return courses;
  }

  deleteCourse(Course course)async{
    await courseCollection.doc(course.IdCourse).delete();
  }

  updateCourse(Course course)async{
    await courseCollection.doc(course.IdCourse).update(course.toMap());
  }

  addNewStudent(AppUser appUser,String CourseId)async{
    await FirebaseFirestore.instance
        .collection('Courses')
        .doc(CourseId)
        .collection('Student')
        .doc(appUser.id)
        .set(appUser.toMap());
  }
  Future<List<AppUser>> getAllStudents(String CourseId)async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Courses')
        .doc(CourseId)
        .collection('Student')
        .get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents =querySnapshot.docs;

    List<AppUser> Students = documents.map((e) {
      AppUser appUser = AppUser.fromMap(e.data());
      appUser.id = e.id;
      return appUser;
    }).toList();
    return Students;
  }

  deleteStudent(String StudentId,String CourseId)async{
    await FirebaseFirestore.instance.collection('Courses').doc(CourseId).collection('Student').doc(StudentId).delete();
  }

  Future<List<AppUser>> getAllUsers()async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await userCollection.get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents =querySnapshot.docs;
    List<AppUser> users =
    documents.map((e) {
      AppUser appUser = AppUser.fromMap(e.data());
      appUser.id = e.id; //عملنا هيك لان id  مش داتا حقيقية "داتا وصفية"
      return appUser;
    } ).toList();
    return users;
  }

  // Future<void> getAllData() async {
  //   List<AppUser> allUser = [];
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await userCollection.get();
  //
  //   // Get data from docs and convert map to List
  //   final List<Object?> allData =
  //   querySnapshot.docs.map((doc) => doc.data()).toList();
  //
  //
  //
  //   //for a specific field
  //   // final  allData = querySnapshot.docs.map((doc) => doc.get('userName')).toList();
  //
  //   print(allData);
  // }




}