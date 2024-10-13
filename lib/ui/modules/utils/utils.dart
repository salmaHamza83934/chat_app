import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLoading(context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(8.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
            Text('Loading...')
          ],
        ),
      ),
    ),
  );
}

void hideLoading(context) {
  Navigator.pop(context);
}

void showMessage(
    context, String message, String posActionTxt, Function posAction,
    {String? negActionTxt, Function? negAction}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(8.r),
        child: Text(message),
      ),
      actions: [
        GestureDetector(
          onTap: () => posAction(context),
          child: Container(
            height: 35.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: Text(
                posActionTxt,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
