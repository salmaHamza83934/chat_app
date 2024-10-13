import 'package:chat_app/ui/modules/home_screen/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_txt_form_field.dart';
import '../../../../data/models/category_model.dart';

class AddRoomForm extends StatefulWidget {
HomeScreenViewModel viewModel;
CategoryModel selectedItem;
List<CategoryModel> categoryList;
  AddRoomForm(this.viewModel,this.selectedItem,this.categoryList);

  @override
  State<AddRoomForm> createState() => _AddRoomFormState();
}

class _AddRoomFormState extends State<AddRoomForm> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return                     Container(
      padding: EdgeInsets.all(30.r),
      height: 650.h,
      width: 350.w,
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
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              'Create New Room',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              'assets/images/room@3x.png',
              height: 120.h,
              width: 250.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
                label: 'Enter Room Name',
                controller: widget.viewModel.roomNameController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Enter room name';
                  }
                  return null;
                }),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 70.h,
              child: DropdownButton<CategoryModel>(
                  dropdownColor: Colors.white,
                  value: widget.selectedItem,
                  items: widget.categoryList
                      .map((category) =>
                      DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Row(
                            children: [
                              Text(category.title),
                              Image.asset(category.image),
                            ],
                          )))
                      .toList(),
                  onChanged: (newCategory) {
                    if (newCategory == null) return;
                    widget. selectedItem = newCategory;
                    setState(() {});
                  }),
            ),
            CustomTextFormField(
                label: 'Enter Room Description',
                controller: widget.viewModel.roomDescriptionController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Enter room description';
                  }
                  return null;
                }),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: (){
                if(formKey.currentState!.validate()){
                  widget.viewModel.addRoom(widget.viewModel.roomNameController.text, widget.viewModel.roomDescriptionController.text, widget.selectedItem.id);
                }
              },
              child: Container(
                height: 50.h,
                width: 250.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Center(
                  child: Text(
                    'Create',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
