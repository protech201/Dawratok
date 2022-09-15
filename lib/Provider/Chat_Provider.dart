import 'package:flutter/material.dart';

import '../Data/Firestore_helper.dart';
import '../Modle/UserApp.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider(){
    getAllChatUsers();
  }
  List<AppUser> ChatUsers = [];

  getAllChatUsers ()async{
    ChatUsers = await StoreHelper.storeHelper.getAllUsers();
    notifyListeners();
  }
}