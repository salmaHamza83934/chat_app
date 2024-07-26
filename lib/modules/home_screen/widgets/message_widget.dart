import 'package:chat_app/models/message.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<UserProvider>(context);
    return provider.user?.id==message.senderId?SentMessage(message):ReceiverMessage(message);
  }

}


class SentMessage extends StatelessWidget {
  Message message;

  SentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var dt = DateTime.fromMillisecondsSinceEpoch(message.dateTime);
    var date = DateFormat('hh:mm a').format(dt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topRight: Radius.circular(12.r),topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r)),
          ),
          child: Text(message.content,style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),),
        ),
        Text(date,style: theme.textTheme.bodySmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10.sp),)
      ],
    );
  }
}


class ReceiverMessage extends StatelessWidget {

  Message message;

  ReceiverMessage(this.message);

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var dt = DateTime.fromMillisecondsSinceEpoch(message.dateTime);
    var date = DateFormat('hh:mm a').format(dt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topRight: Radius.circular(12.r),topLeft: Radius.circular(12.r),bottomRight: Radius.circular(12.r)),
          ),
          child: Text(message.content,style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),),
        ),
        Text(date,style: theme.textTheme.bodySmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10.sp),)
      ],
    );
  }
}
