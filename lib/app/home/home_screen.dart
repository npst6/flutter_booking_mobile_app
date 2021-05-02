///Note file home_screen.dart

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/utils/order_utils.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/app/login/login_screen.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/base/text_field_choose.dart';
import 'package:flutter_booking_mobile_app/app/home/bloc/home_bloc.dart';
import 'package:flutter_booking_mobile_app/app/profile/profile_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import 'package:flutter_booking_mobile_app/app/search/output_search_screen.dart';
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

///HomeScreen StatefulWidget
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// _HomeScreenState State<>
class _HomeScreenState extends State<HomeScreen> {
  ///themeData
  ThemeData themeData;

  ///homeBloc
  HomeBloc homeBloc;

  ///startDay
  String startDay;

  ///endDay
  String endDay;

  ///controllerSearch
  TextEditingController controllerSearch;

  ///controllerCity
  TextEditingController controllerCity;

  ///controllerTime
  TextEditingController controllerTime;

  ///adults
  int adults = 0;

  ///child
  int child = 0;

  ///numberRoom
  int numberRoom = 0;

  @override
  void initState() {
    controllerCity = new TextEditingController();
    controllerSearch = new TextEditingController();
    controllerTime = new TextEditingController();
    homeBloc = new HomeBloc()..init();
    homeBloc.searchStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OutputSearchScreen(homeBloc);
        }));
        homeBloc.searchStateStream.add(null);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  ///_formKey
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Background color
      backgroundColor: AppColors.grey,

      ///Body
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  ///Container padding
                  padding: const EdgeInsets.fromLTRB(15, 50, 10, 10),

                  child: Container(
                    ///Container height
                    height: 40,

                    child: Row(
                      ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProfileScreen();
                                },
                              ),
                            );
                            homeBloc.getAccount();
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
                                      image: NetworkImage(snapshot.data.avatar),

                                      ///Image fit
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else
                                return Center();
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            ///Icon
                            Icons.logout,

                            ///Icon color
                            color: AppColors.primaryColor,
                          ),

                          ///onPressed
                          onPressed: () {
                            showDialog(
                              ///context
                              context: context,

                              ///builder
                              builder: (_) => Scaffold(
                                ///backgroundColor
                                backgroundColor: Colors.transparent,

                                ///Body
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
                                            ///Text
                                            "Logout".toUpperCase(),

                                            style: TextStyle(
                                              ///Text size
                                              fontSize: 20,

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

                                              const SizedBox(
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
                                                        },
                                                      ),
                                                    );
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
                  flex: 4,

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
                        padding: const EdgeInsets.all(15),

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
                            padding: const EdgeInsets.fromLTRB(15, 2.5, 0, 0),

                            child: TextFormField(
                              ///controllerSearch
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

                                ///suffixIcon
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    ///Icon
                                    Icons.search,

                                    ///Icon color
                                    color: AppColors.primaryColor,
                                  ),

                                  ///onPressed
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      OrderUtils().setOrder(
                                          startDay, endDay, numberRoom);
                                      homeBloc.searchRoom(
                                        numberRoom: numberRoom,
                                        startDay: startDay,
                                        endDay: endDay,
                                        city: controllerCity.text,
                                        child: child,
                                        adults: adults,
                                      );
                                    }
                                  },
                                ),

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
                  ///Flex
                  flex: 5,

                  child: Container(
                    ///Container width
                    width: double.infinity,

                    decoration: BoxDecoration(
                      ///Color box
                      color: themeData.scaffoldBackgroundColor,

                      ///borderRadius
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),

                    child: Padding(
                      ///Padding
                      padding: const EdgeInsets.all(15),

                      child: SingleChildScrollView(
                        child: Column(
                          ///Using mainAxisAlignment in a Column will align its children vertically.
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            StreamBuilder<List<Province>>(
                              stream: homeBloc.listProvinceStream,
                              builder: (context, snapshot1) {
                                if (snapshot1.hasData) {
                                  List<ItemModel> items = [];
                                  snapshot1.data.forEach(
                                    (element) {
                                      items.add(
                                        new ItemModel(
                                          id: element.code,
                                          name: element.name,
                                        ),
                                      );
                                    },
                                  );
                                  return TextFieldChoose(
                                    ///Item
                                    items: items,

                                    ///Icon
                                    iconData: Icons.location_pin,

                                    ///Hint text
                                    hintText: "Where is Your Location ?",

                                    ///callBack
                                    callBack: (val) {
                                      controllerCity.text = val;
                                    },
                                  );
                                } else
                                  return SizedBox();
                              },
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            TextFieldChoose(
                              ///Icon
                              iconData: Icons.room_preferences,

                              ///Hint text
                              hintText: "How Many Rooms ?",

                              ///callBack
                              callBack: (val) {
                                numberRoom = int.parse(val);
                              },

                              ///items
                              items: [
                                ItemModel(id: '01', name: "01"),
                                ItemModel(id: '02', name: "02"),
                                ItemModel(id: '03', name: "03"),
                                ItemModel(id: '04', name: "04"),
                                ItemModel(id: '05', name: "05"),
                                ItemModel(id: '06', name: "06"),
                                ItemModel(id: '07', name: "07"),
                                ItemModel(id: '08', name: "08"),
                                ItemModel(id: '09', name: "09"),
                                ItemModel(id: '10', name: "10"),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            TextFieldChoose(
                              ///Icon
                              iconData: Icons.people,

                              ///Hint text
                              hintText: "How Many Adults ?",

                              ///callBack
                              callBack: (val) {
                                adults = int.parse(val);
                              },

                              ///items
                              items: [
                                ItemModel(id: '01', name: "01"),
                                ItemModel(id: '02', name: "02"),
                                ItemModel(id: '03', name: "03"),
                                ItemModel(id: '04', name: "04"),
                                ItemModel(id: '05', name: "05"),
                                ItemModel(id: '06', name: "06"),
                                ItemModel(id: '07', name: "07"),
                                ItemModel(id: '08', name: "08"),
                                ItemModel(id: '09', name: "09"),
                                ItemModel(id: '10', name: "10"),
                                ItemModel(id: '11', name: "11"),
                                ItemModel(id: '12', name: "12"),
                                ItemModel(id: '13', name: "13"),
                                ItemModel(id: '14', name: "14"),
                                ItemModel(id: '15', name: "15"),
                                ItemModel(id: '16', name: "16"),
                                ItemModel(id: '17', name: "17"),
                                ItemModel(id: '18', name: "18"),
                                ItemModel(id: '19', name: "19"),
                                ItemModel(id: '20', name: "20"),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            TextFieldChoose(
                              ///Icon
                              iconData: Icons.emoji_people,

                              ///Hint text
                              hintText: "How Many Children ?",

                              ///callBack
                              callBack: (val) {
                                child = int.parse(val);
                              },

                              ///items
                              items: [
                                ItemModel(id: '00', name: "00"),
                                ItemModel(id: '01', name: "01"),
                                ItemModel(id: '02', name: "02"),
                                ItemModel(id: '03', name: "03"),
                                ItemModel(id: '04', name: "04"),
                                ItemModel(id: '05', name: "05"),
                                ItemModel(id: '06', name: "06"),
                                ItemModel(id: '07', name: "07"),
                                ItemModel(id: '08', name: "08"),
                                ItemModel(id: '09', name: "09"),
                                ItemModel(id: '10', name: "10"),
                                ItemModel(id: '11', name: "11"),
                                ItemModel(id: '12', name: "12"),
                                ItemModel(id: '13', name: "13"),
                                ItemModel(id: '14', name: "14"),
                                ItemModel(id: '15', name: "15"),
                                ItemModel(id: '16', name: "16"),
                                ItemModel(id: '17', name: "17"),
                                ItemModel(id: '18', name: "18"),
                                ItemModel(id: '19', name: "19"),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Stack(
                              children: [
                                XTextFormField(
                                  ///enable

                                  ///controllerTime
                                  controller: controllerTime,

                                  ///Hint text
                                  hintText: "Check In - Check Out",

                                  ///Check empty field
                                  funcValidation: ValidateData.validEmpty,

                                  ///prefixIcon
                                  prefixIcon: Icon(
                                    ///Icon
                                    Icons.calendar_today,

                                    ///Icon color
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                GestureDetector(
                                  ///onTap
                                  onTap: () async {
                                    final List<DateTime> picked =
                                    await DateRagePicker.showDatePicker(
                                      ///context
                                      context: context,

                                      ///initialFirstDate
                                      initialFirstDate: new DateTime.now(),

                                      ///initialLastDate
                                      initialLastDate: (new DateTime.now()).add(
                                        new Duration(days: 7),
                                      ),

                                      ///firstDate
                                      firstDate: new DateTime(2015),

                                      ///lastDate
                                      lastDate: new DateTime(2025),
                                    );
                                    if (picked != null && picked.length == 2) {
                                      ///startDay
                                      startDay = picked[0].toIso8601String();

                                      ///endDay
                                      endDay = picked[1].toIso8601String();

                                      ///controllerTime
                                      controllerTime.text =
                                      "${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}";
                                    }
                                  },
                                  child: Container(
                                    height: 55,
                                    color: Colors.transparent,
                                    width: double.infinity,
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            ///Search for button
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: XButton(
                                "Search Home Stay",
                                () {
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
                                },
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<UIState>(
            stream: homeBloc.searchStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING)
                return LoadingBar();
              else
                return Center();
            },
          ),
        ],
      ),
    );
  }
}
