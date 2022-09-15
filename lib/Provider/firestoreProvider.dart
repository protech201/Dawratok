import 'dart:io';

import 'package:dawratok/Data/Storage_helper.dart';
import 'package:dawratok/Modle/Course.dart';
import 'package:dawratok/Modle/UserApp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../AppRouter.dart';
import '../Data/Firestore_helper.dart';
import '../Views/Screens/AllStudentsScreen.dart';
import '../Views/Screens/ControlScreen.dart';

class FirestoreProvider extends ChangeNotifier{
  FirestoreProvider(){
    getAllCourses();
    getAllUsers();
  }
  TextEditingController nameCourseController = TextEditingController();
  TextEditingController nameCourseEnController = TextEditingController();
  TextEditingController nameTeacherController = TextEditingController();
  TextEditingController nameTeacherEnController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressEnController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController contentEnController = TextEditingController();
  TextEditingController starsController = TextEditingController();
  bool isOnline = false;
  File? selectedImage;
  GlobalKey<FormState> CourseKey = GlobalKey();

  List<Course> Courses = [];
  List<AppUser> Students = [];
  List<AppUser> Users = [];

  nullValidation(String v){
    if(v.isEmpty) {
      return 'required'.tr();
    }}


    isOnlineFun(bool value){
      isOnline = value;
      notifyListeners();
      print(isOnline);
    }

    imagePickerProvider()async{
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery) ;
    selectedImage = File(xFile!.path);
    notifyListeners();
    }

    addNewCourse()async{
    if(selectedImage != null){
      String urlImage =
          await StorageHelper.storageHelper.uploadImage(selectedImage!);
      Course course =Course(
          nameCourse: nameCourseController.text,
          nameCourseEn: nameCourseEnController.text,
          nameTeacher: nameTeacherController.text,
          nameTeacherEn: nameTeacherEnController.text,
          address: addressController.text,
          addressEn: addressEnController.text,
          content: contentController.text,
          contentEn: contentEnController.text,
          stars: starsController.text,
          imageUrl: urlImage,
          isOnline: isOnline
      );
      Course newCourse = await StoreHelper.storeHelper.addNewCourse(course);
      selectedImage = null;
      Courses.add(newCourse);
      // getAllCourses();
      // notifyListeners();

    }}

    getAllCourses()async{
      Courses = await StoreHelper.storeHelper.getAllCourses();
      notifyListeners();
    }

    updateCourse(Course course)async{
      String? urlImage;
      if(selectedImage != null){
         urlImage =
            await StorageHelper.storageHelper.uploadImage(selectedImage!);
      }
      Course newCourse =Course(
          nameCourse: nameCourseController.text,
          nameCourseEn: nameCourseEnController.text,
          nameTeacher: nameTeacherController.text,
          nameTeacherEn: nameTeacherEnController.text,
          address: addressController.text,
          addressEn: addressEnController.text,
          content: contentController.text,
          contentEn: contentEnController.text,
          stars: starsController.text,
          imageUrl: urlImage?? course.imageUrl,
          isOnline: isOnline
      );
      newCourse.IdCourse = course.IdCourse;
      await StoreHelper.storeHelper.updateCourse(newCourse);
      // getAllCourses();
     int index = Courses.indexOf(
        Courses.where((element) => element.IdCourse==course.IdCourse).first);
        Courses[index] = newCourse;
        notifyListeners();
    }

    deleteCourse(Course course){
        StoreHelper.storeHelper.deleteCourse(course);
        // getAllCourses();

        Courses.removeWhere((element) => element.IdCourse==course.IdCourse);
        notifyListeners();

    }

    addNewStudent(AppUser appUser , String CourseId)async{
      await StoreHelper.storeHelper.addNewStudent(appUser, CourseId);
    }

    getAllStudents(String CourseId)async{
      Students = await StoreHelper.storeHelper.getAllStudents(CourseId);
      notifyListeners();

    }

    deleteStudent(String StudentId,String CourseId){
    StoreHelper.storeHelper.deleteStudent(StudentId, CourseId);
    getAllStudents(CourseId);

    // Students.removeWhere((element) => element.IdCourse==course.IdCourse);
    notifyListeners();

  }

    getAllUsers()async{
      Users = await StoreHelper.storeHelper.getAllUsers();
      notifyListeners();
    }












}