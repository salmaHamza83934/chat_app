import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/room.dart';
import '../chat_screen.dart';

class RoomWidget extends StatelessWidget {
  List<Room> roomList;

  RoomWidget(this.roomList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 16.h),
            child: Text('Rooms:',style: GoogleFonts.poppins(
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,shadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(
                    2, 4), // changes position of shadow
              ),
            ], ),),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1 / 1.1),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ChatScreen.routeName,
                            arguments: roomList[index]);
                      },
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
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/${roomList[index].categoryId}.png',
                                height: 135.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                roomList[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )),
                    ),
                  ],
                );
              },
              itemCount: roomList!.length,
            ),
          ),
        ],
      ),
    );
  }
}
