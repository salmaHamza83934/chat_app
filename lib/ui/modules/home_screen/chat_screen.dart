import 'package:chat_app/ui/modules/home_screen/widgets/chat_screen_form_field.dart';
import 'package:chat_app/ui/modules/home_screen/widgets/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/ui/modules/utils/utils.dart' as utils;
import '../../../data/models/message.dart';
import '../../../data/models/room.dart';
import '../connector/connector.dart';
import '../providers/user_provider.dart';
import 'home_screen_view_model.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements Connector {

  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  void initState() {
    viewModel.connector = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var theme = Theme.of(context);
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.myUser = provider.user!;
    viewModel.listenForUpdateMessages();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Image.asset(
            'assets/images/background@3x.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        '${args.title}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 25),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.r),
                      height: 700.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: StreamBuilder<QuerySnapshot<Message>>(
                              stream: viewModel.streamMessage,
                              builder: (context, asyncSnapshot) {
                                var messageList = asyncSnapshot.data?.docs
                                    .map((doc) => doc.data())
                                    .toList();
                                if (asyncSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: theme.primaryColor,
                                    ),
                                  );
                                } else if (asyncSnapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      asyncSnapshot.error.toString(),
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                  );
                                } else if (messageList?.length == 0) {
                                  return Center(
                                    child: Text(
                                      'No messages yet.',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemBuilder: (context, index) =>
                                        MessageWidget(messageList[index]),
                                    itemCount: messageList!.length,
                                  );
                                }
                              },
                            ),
                          ),
                          ChatScreenFormField(viewModel),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, 'Ok', (context) {
      Navigator.pop(context);
    });
  }
}
