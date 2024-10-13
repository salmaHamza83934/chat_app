import 'package:chat_app/ui/modules/home_screen/widgets/home_screen_app_bar.dart';
import 'package:chat_app/ui/modules/home_screen/widgets/room_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/database/database_utils.dart';
import '../../../data/models/room.dart';
import 'add_room_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Image.asset(
          'assets/images/background@3x.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        HomeScreenAppBar(),
        Padding(
          padding: EdgeInsets.only(top: 200.h),
          child: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseUtils.getRooms(),
              builder: (context, asyncSnapshot) {
                var roomList =
                    asyncSnapshot.data?.docs.map((doc) => doc.data()).toList();
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
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
                } else if (roomList?.length == 0) {
                  return Center(
                    child: Text(
                      'No Available rooms',
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                } else {
                  return RoomWidget(roomList ?? []);
                }
              }),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRoomScreen.routeName);
        },
        backgroundColor: theme.primaryColor,
        shape: OvalBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40.r,
        ),
      ),
    );
  }
}
