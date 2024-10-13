import 'package:chat_app/ui/modules/home_screen/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreenFormField extends StatelessWidget {
  HomeScreenViewModel viewModel;


  ChatScreenFormField(this.viewModel);

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Form(
      key: viewModel.formKey,
      child: Row(
        children: [
          Container(
            width: 230.h,
            height: 60.h,
            child: TextFormField(
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return '';
                }
                return null;
              },
              controller: viewModel.messageController,
              decoration: InputDecoration(
                label: Text('Type a message',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: theme.primaryColor,
                      width: 2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red,
                      width: 2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r)),
                ),
                focusedErrorBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red,
                      width: 2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: theme.primaryColor,
                      width: 2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r)),
                ),
                errorStyle: const TextStyle(
                  height: 0, // Set the height to 0 to hide the error text
                  color: Colors.transparent, // Make the text transparent
                ),
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if (viewModel.formKey.currentState!.validate()) {
                viewModel
                    .sendMessage(viewModel.messageController.text);
                viewModel.messageController.clear();
              }
            },
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: 8.w),
              width: 100.w,
              height: 60.h,
              decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius:
                  BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Text(
                    'Send',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  Icon(
                    Icons.send,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
