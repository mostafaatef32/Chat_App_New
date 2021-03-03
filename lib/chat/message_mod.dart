import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessageMod extends StatelessWidget {
  MessageMod(this.message,this.userName,this.isMe, {this.key});
  final Key key;
  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: !isMe ? Colors.grey : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(14),
              bottomRight: isMe ? Radius.circular(0) :Radius.circular(14),
            )
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Column(
            crossAxisAlignment: !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isMe ? Colors.black :
                      Theme.of(context).accentTextTheme.headline6.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isMe ? Colors.black :
                  Theme.of(context).accentTextTheme.headline6.color,
                ),
                textAlign: !isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
