import 'package:chat_app/components/custom_txt_form_field.dart';
import 'package:chat_app/models/category_model.dart';
import 'package:chat_app/modules/connector/connector.dart';
import 'package:chat_app/modules/home_screen/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils/utils.dart' as utils ;

import '../login_screen/login_screen.dart';
import 'home_screen.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add_room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> implements Connector{
  TextEditingController roomNameController = TextEditingController();

  TextEditingController roomDescriptionController = TextEditingController();

  var categoryList = CategoryModel.getCategory();

  late CategoryModel selectedItem;
  var formKey = GlobalKey<FormState>();


  HomeScreenViewModel viewModel =HomeScreenViewModel();

  @override
  void initState() {
    selectedItem = categoryList[0];
    viewModel.connector=this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(50.r),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        'Chat App',
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
                                controller: roomNameController,
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
                                  value: selectedItem,
                                  items: categoryList
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
                                    selectedItem = newCategory;
                                    setState(() {});
                                  }),
                            ),
                            CustomTextFormField(
                                label: 'Enter Room Description',
                                controller: roomDescriptionController,
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
                                  viewModel.addRoom(roomNameController.text, roomDescriptionController.text, selectedItem.id);
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
utils.hideLoading(context);  }

  @override
  void showLoading() {
utils.showLoading(context);  }

  @override
  void showMessage(String message) {
utils.showMessage(context, message, 'Ok', (context){Navigator.pushNamed(context, HomeScreen.routeName);} ); }
}
