import 'package:dawratok/Modle/UserApp.dart';
import 'package:flutter/material.dart';

import '../../Colors.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({Key? key}) : super(key: key);
  AppUser otherUser;
  ChatScreen(this.otherUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(otherUser.userName),
        centerTitle: true,
        backgroundColor: Colors_Ui.mainColor,
      ),
    );
  }
}
