///Note file home_screen.dart

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/app/profile/profile_screen.dart';
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
import 'package:flutter_booking_mobile_app/app/profile/profile_screen.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import "package:flutter_booking_mobile_app/app/search/output_search_screen.dart";
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

///HomeScreen StatefulWidget
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// _HomeScreenState State<>
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

  @override
  void initState() {
    controllerCity = new TextEditingController();
    controllerSearch = new TextEditingController();
    controllerTime = new TextEditingController();
    homeBloc = new HomeBloc()..init();
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Background color
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                ///Container padding
                padding: const EdgeInsets.fromLTRB(30, 50, 15, 10),
                child: Container(
                  ///Container height
                  height: 40,
                  child: Row(
                    ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
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
                                  ///Container width
                                  width: 40,
                                  decoration: BoxDecoration(
                                    ///Border box
                                      borderRadius: BorderRadius.circular(10),
                                      ///Image
                                      image: DecorationImage(
                                        ///Image
                                          image: NetworkImage(
                                              snapshot.data.avatar),
                                        ///Image fit
                                        fit: BoxFit.cover,
                                      ),
                                  ),
                                );
                              } else
                                return LoadingBar();
                            }),
                      ),
                      IconButton(
                        icon: Icon(
                          ///Icon
                          Icons.logout,
                          ///Icon color
                          color: AppColors.buttonColor,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Center(
                                child: Container(
                                  ///Container height
                                  height: 150,
                                  ///Container width
                                  width: 200,
                                  decoration: BoxDecoration(
                                    ///Color box
                                    color: themeData.scaffoldBackgroundColor,
                                    ///Border box
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    ///Padding
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 15),
                                    child: Column(
                                      ///Using mainAxisAlignment in a Column will align its children vertically.
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                            ///Text size
                                            fontSize: 18,

                                            ///Text weight
                                            fontWeight: FontWeight.w900,

                                            ///Text spacing
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        Text(
                                          "Do you want to log out?",
                                        ),
                                        Row(
                                          children: [
                                            ///Cancel button
                                            Expanded(
                                              child: XButton(
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

                                            ///Ok button
                                            Expanded(
                                              child: XButton(
                                                "OK",
                                                () {
                                                  FirAuth().signOut();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return LoginScreen();
                                                  }));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                ///Flex
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    ///Image
                    image: DecorationImage(
                      ///Image
                      image: AssetImage('assets/images/home.png'),

                      ///Image fit
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Align(
                    ///Alignment
                    alignment: Alignment.topCenter,
                    child: Padding(
                      ///Padding
                      padding: const EdgeInsets.all(25),
                      child: Container(
                        decoration: BoxDecoration(
                          ///Color box
                          color: Colors.white,

                          ///Border box
                          borderRadius: BorderRadius.circular(10),
                        ),

                        ///Container height
                        height: 50,

                        ///Container width
                        width: double.infinity,
                        child: Padding(
                          ///Padding
                          padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                          child: TextFormField(
                            controller: controllerSearch,
                            style: TextStyle(
                              ///Text color
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              ///Hint Text
                              hintText: "Search",
                              hintStyle: TextStyle(
                                ///Hint text color
                                color: Colors.grey,

                                ///Hint text weight
                                fontWeight: FontWeight.w600,
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    ///Icon
                                    Icons.search,

                                    ///Icon color
                                    color: AppColors.buttonColor,
                                  ),
                                  onPressed: () {}),

                              ///Border box
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,

                  ///Container width
                  decoration: BoxDecoration(
                    color: themeData.scaffoldBackgroundColor,

                    ///Color box
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),

                  child: Padding(
                    ///Padding
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          ///Using mainAxisAlignment in a Column will align its children vertically.
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
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
                                      ///Item
                                      items: items,

                                      ///Icon
                                      iconData: Icons.location_pin,

                                      ///Hint text
                                      hintText: "Where Do You Want To Stay?",
                                      callBack: (val) {
                                        controllerCity.text = val;
                                      },
                                    );
                                  } else
                                    return SizedBox();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final List<DateTime> picked =
                                    await DateRagePicker.showDatePicker(
                                        context: context,
                                        initialFirstDate: new DateTime.now(),
                                        initialLastDate: (new DateTime.now())
                                            .add(new Duration(days: 7)),
                                        firstDate: new DateTime(2015),
                                        lastDate: new DateTime(2025));
                                if (picked != null && picked.length == 2) {
                                  startDay = picked[0].toIso8601String();
                                  endDay = picked[1].toIso8601String();
                                  controllerTime.text =
                                      "${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}";
                                }
                              },
                              child: XTextFormField(
                                controller: controllerTime,
                                enable: false,

                                ///Hint text
                                hintText: "Check In - Check Out",

                                ///Check empty field
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Icon(
                                  ///Icon
                                  Icons.calendar_today,

                                  ///Icon color
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldChoose(
                              ///Icon
                              iconData: Icons.room_preferences,

                              ///Hint text
                              hintText: "Number of Rooms to Book",
                              callBack: (val) {
                                numberRoom = int.parse(val);
                              },
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
                              ///Icon
                              iconData: Icons.people,

                              ///Hint text
                              hintText: "Adults Number",
                              callBack: (val) {
                                adults = int.parse(val);
                              },
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
                              ///Icon
                              iconData: Icons.emoji_people,

                              ///Hint text
                              hintText: "Children Number",
                              callBack: (val) {
                                child = int.parse(val);
                              },
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

                            ///Search for button
                            XButton("Search for", () {
                              if (_formKey.currentState.validate()) {
                                OrderUtils()
                                    .setOrder(startDay, endDay, numberRoom);
                                homeBloc.searchRoom(
                                  numberRoom: numberRoom,
                                  startDay: startDay,
                                  endDay: endDay,
                                  city: controllerCity.text,
                                  child: child,
                                  adults: adults,
                                );
                              }
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
