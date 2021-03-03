import 'package:chat_application_new/chat/messages.dart';
import 'package:chat_application_new/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
           actions: [
             DropdownButton(
                 icon: Icon(
                   Icons.more_vert ,
                   color: Theme.of(context).primaryIconTheme.color,),
                   items: [
                     DropdownMenuItem(child: Row(
                       children: [
                         Icon(Icons.exit_to_app),
                         SizedBox(width: 8,),
                         Text('Logout'),
                       ],
                     ),
                       value: 'logout',
                     ),
                   ],
                   onChanged: (itemIdentifier){
                     if(itemIdentifier =='logout')
                       {
                         FirebaseAuth.instance.signOut();
                       }
                   }),
           ],
      ),
       body: Container(
           child: Column(
             children: [
               Expanded(child: Messages()
               ),
               NewMessage(),
             ],
           ),

       ),
    );
  }
}
