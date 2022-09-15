import 'package:dawratok/AppRouter.dart';
import 'package:dawratok/Provider/Chat_Provider.dart';
import 'package:dawratok/Views/Screens/ChatApp/Screen_Chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Colors.dart';

class ChatUsersScreen extends StatelessWidget {
  const ChatUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger'),
        centerTitle: true,
        backgroundColor: Colors_Ui.mainColor,
      ),
      body: Consumer<ChatProvider>(
        builder: (context,provider,x) {
          return ListView.builder(
            itemCount: provider.ChatUsers.length,
              itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                AppRouter.NavigatorToWidget(ChatScreen(provider.ChatUsers[index]));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors_Ui.mainColor,
                      radius: 25.r,
                      child:  Text(provider.ChatUsers[index].userName.characters.first.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp
                      ),),
                    ),
                    SizedBox(width: 20.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(provider.ChatUsers[index].userName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors_Ui.mainColor,
                          ),),
                        Text(provider.ChatUsers[index].email,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors_Ui.mainColor,
                          ),),
                      ],
                    ),
                  ],
                ),

              ),
            );
          });
        }
      ));
  }
}
