///Note file home_screen.dart

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/utils/order_utils.dart';
import 'package:flutter_booking_mobile_app/app/login/login_screen.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/base/text_field_choose.dart';
import 'package:flutter_booking_mobile_app/app/home/bloc/home_bloc.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
// import 'package:flutter_booking_mobile_app/app/profile/profile_screen.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
// import "package:flutter_booking_mobile_app/app/search/output_search_screen.dart";
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

/// class HomeScreen extends StatefulWidget
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// class _HomeScreenState extends State<HomeScreen>
class _HomeScreenState extends State<HomeScreen> {
  ThemeData themeData;
  HomeBloc homeBloc;
  String startDay;
  String endDay;
  TextEditingController controllerSearch;
  TextEditingController controllerCity;
  TextEditingController controllerTime;
  int adults = 0;
  int child = 0;
  int numberRoom = 0;

  ///
  @override
  void initState() {
    controllerCity = new TextEditingController();
    controllerSearch = new TextEditingController();
    controllerTime = new TextEditingController();
    homeBloc = new HomeBloc()..init();
    super.initState();
  }

  ///
  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  ///
  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    homeBloc.searchStateStream.listen((value) {
      if (value == UIState.SUCCESS) {

        homeBloc.searchStateStream.add(null);
      }
    });
    super.didChangeDependencies();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 15, 10),
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ProfileScreen();
                              }));
                        },
                        child: StreamBuilder<Account>(
                            stream: homeBloc.accountStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data.avatar),
                                          fit: BoxFit.cover)),
                                );
                              } else
                                return LoadingBar();
                            }),
                      ),

                      IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: AppColors.buttonColor,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Center(
                                  child: Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color:
                                      themeData.scaffoldBackgroundColor,
                                      borderRadius:
                                      BorderRadius.circular(7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Logout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18,
                                                letterSpacing: 1),
                                          ),
                                          Text(
                                            "Do you want to log out?",
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: MButton(
                                                  "Cancel",
                                                      () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: MButton(
                                                  "OK",
                                                      () {
                                                    FirAuth().signOut();
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) {
                                                              return LoginScreen();
                                                            }));
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/home.png'),
                          fit: BoxFit.fitWidth)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                          child: TextFormField(
                            controller: controllerSearch,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: AppColors.buttonColor,
                                    ),
                                    onPressed: () {}),
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Expanded (
                flex: 4,
                child: Container (
                  width: double.infinity, ///Container width
                  decoration: BoxDecoration (
                    color: themeData.scaffoldBackgroundColor, ///Color box
                    borderRadius: BorderRadius.only (
                        topRight: Radius.circular (25),
                        topLeft: Radius.circular (25),
                    ),
                  ),

                  child: Padding (
                    padding: const EdgeInsets.all (15),
                    child: SingleChildScrollView (
                      child: Form (
                        key: _formKey,
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox (
                              height: 15,
                            ),

                            StreamBuilder<List<Province>>(
                                stream: homeBloc.listProvinceStream,
                                builder: (context, snapshot1) {
                                  if (snapshot1.hasData) {
                                    List<ItemModel> items = [];
                                    snapshot1.data.forEach((element) {
                                      items.add(new ItemModel(
                                          id: element.code,
                                          name: element.name));
                                    });
                                    return TextFieldChoose(
                                      iconData: Icons.location_pin,
                                      callBack: (val) {
                                        controllerCity.text = val;
                                      },
                                      hintText: "Choose city",
                                      items: items,
                                    );
                                  } else
                                    return SizedBox();
                                }
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            GestureDetector(
                              onTap: () async {
                                final List<DateTime> picked =
                                await DateRagePicker.showDatePicker(
                                    context: context,
                                    initialFirstDate:
                                    new DateTime.now(),
                                    initialLastDate:
                                    (new DateTime.now()).add(
                                        new Duration(days: 7)),
                                    firstDate: new DateTime(2015),
                                    lastDate: new DateTime(2022));
                                if (picked != null &&
                                    picked.length == 2) {
                                  startDay = picked[0].toIso8601String();
                                  endDay = picked[1].toIso8601String();
                                  controllerTime.text =
                                  "${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}";
                                }
                              },

                              child: MTextFormField (
                                hintText: "Check in and check out",
                                enable: false,
                                controller: controllerTime,
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Icon (
                                  Icons.calendar_today,
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            TextFieldChoose (
                              iconData: Icons.room_preferences,
                              callBack: (val) {
                                numberRoom = int.parse(val);
                              },
                              hintText: "Room",
                              items: [
                                ItemModel(id: '1', name: "01"),
                                ItemModel(id: '2', name: "02"),
                                ItemModel(id: '3', name: "03"),
                                ItemModel(id: '4', name: "04"),
                                ItemModel(id: '5', name: "05"),
                                ItemModel(id: '6', name: "06"),
                                ItemModel(id: '7', name: "07"),
                                ItemModel(id: '8', name: "08"),
                                ItemModel(id: '9', name: "09"),
                                ItemModel(id: '10', name: "10"),
                              ],
                            ),

                            SizedBox (
                              height: 15,
                            ),

                            TextFieldChoose(
                              iconData: Icons.people,
                              callBack: (val) {
                                adults = int.parse(val);
                              },
                              hintText: "Adults",
                              items: [
                                ItemModel(id: '1', name: "01"),
                                ItemModel(id: '2', name: "02"),
                                ItemModel(id: '3', name: "03"),
                                ItemModel(id: '4', name: "04"),
                                ItemModel(id: '5', name: "05"),
                                ItemModel(id: '6', name: "06"),
                                ItemModel(id: '7', name: "07"),
                                ItemModel(id: '8', name: "08"),
                                ItemModel(id: '9', name: "09"),
                                ItemModel(id: '10', name: "10"),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldChoose(
                              iconData: Icons.emoji_people,
                              callBack: (val) {
                                child = int.parse(val);
                              },
                              hintText: "Child",
                              items: [
                                ItemModel(id: '1', name: "01"),
                                ItemModel(id: '2', name: "02"),
                                ItemModel(id: '3', name: "03"),
                                ItemModel(id: '4', name: "04"),
                                ItemModel(id: '5', name: "05"),
                                ItemModel(id: '6', name: "06"),
                                ItemModel(id: '7', name: "07"),
                                ItemModel(id: '8', name: "08"),
                                ItemModel(id: '9', name: "09"),
                                ItemModel(id: '10', name: "10"),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MButton("Search for", () {

                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

          StreamBuilder<UIState>(
              stream: homeBloc.searchStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == UIState.LOADING)
                  return LoadingBar();
                else
                  return Center();
              })
        ],
      ),
    );
  }
}
