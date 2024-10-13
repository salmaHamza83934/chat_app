import 'package:chat_app/ui/modules/home_screen/widgets/add_room_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/ui/modules/utils/utils.dart' as utils;
import '../../../data/models/category_model.dart';
import '../connector/connector.dart';
import 'home_screen.dart';
import 'home_screen_view_model.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add_room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> implements Connector{


  var formKey = GlobalKey<FormState>();

  var categoryList = CategoryModel.getCategory();

  late CategoryModel selectedItem;


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
                    AddRoomForm(viewModel, selectedItem, categoryList),
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
