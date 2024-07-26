import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/models/room.dart';
import 'package:chat_app/modules/home_screen/add_room_screen.dart';
import 'package:chat_app/modules/home_screen/chat_screen.dart';
import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h,horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chat App',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 25),
              ),
            ],
          ),
        ),
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
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,childAspectRatio: 1/1.1),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){Navigator.pushNamed(context, ChatScreen.routeName,arguments: roomList[index]);},
                          child: Container(
                            padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset:
                                        Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/${roomList[index].categoryId}.png',height: 135.h,),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    roomList[index].title,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              )),
                        );
                      },
                      itemCount: roomList!.length,
                    ),
                  );
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
