import 'package:chat_application_new/chat/message_mod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('chat').orderBy('CreatedAt',descending: true).snapshots(),
        builder:(ctx,snapShot) {
          if(snapShot.connectionState == ConnectionState.waiting)
          {
            return CircularProgressIndicator();
          }
          final docs = snapShot.data.docs;
          final user =  FirebaseAuth.instance.currentUser;
          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) =>
                MessageMod(
                  docs[index]['text'],
                  docs[index]['username'],
                  docs[index]['userId'] == user.uid,
                  key: ValueKey(docs[index]),


                )
          );
        }
    );
  }
}
