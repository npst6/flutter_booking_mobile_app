///Note file my_home_stay_screen.dart

import 'new_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/no_fount.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/new_home_stay.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/edit_home_stay.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/widget/item_room.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/bloc/my_home_stay_bloc.dart';

///MyHomeStayScreen StatefulWidget
class MyHomeStayScreen extends StatefulWidget {
  @override
  _MyHomeStayScreenState createState() => _MyHomeStayScreenState();
}

/// _MyHomeStayScreenState State<>
class _MyHomeStayScreenState extends State<MyHomeStayScreen> {
  ///themeData
  ThemeData themeData;

  ///homeStayBloc
  HomeStayBloc homeStayBloc;

  ///myHomeStay
  MyHomeStay myHomeStay;

  @override
  void didChangeDependencies() {
    ///themeData
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    homeStayBloc = new HomeStayBloc()..init();
    super.initState();
  }

  @override
  void dispose() {
    homeStayBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///backgroundColor
        backgroundColor: themeData.scaffoldBackgroundColor,

        ///elevation
        elevation: 0,

        leading: GestureDetector(
          ///onTap
          onTap: () {
            Navigator.pop(context);
          },

          child: Padding(
            ///Padding
            padding: const EdgeInsets.all(10),

            child: Container(
              ///Container height
              height: 30,

              ///Container width
              width: 30,

              decoration: BoxDecoration(
                ///Color box
                color: AppColors.buttonColor,

                ///Border box
                borderRadius: BorderRadius.circular(10),
              ),

              child: Center(
                child: Icon(
                  ///Icon
                  Icons.home,

                  ///Icon color
                  color: themeData.scaffoldBackgroundColor,

                  ///Icon size
                  size: 15,
                ),
              ),
            ),
          ),
        ),

        ///Title spacing
        titleSpacing: 1,

        ///Title center
        centerTitle: true,

        ///Title
        title: Text(
          ///Text
          "My Home Stay".toUpperCase(),

          style: TextStyle(
            ///Text size
            fontSize: 20,

            // ignore: deprecated_member_use
            color: themeData.textSelectionColor,

            ///Text weight
            fontWeight: FontWeight.bold,

          ),
        ),

        ///actions
        actions: [
          StreamBuilder<MyHomeStay>(
            stream: homeStayBloc.myHomeStayStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Icon(
                    ///Icon
                    Icons.edit,

                    ///Icon color
                    color: AppColors.buttonColor,
                  ),

                  ///onPressed
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditHomeStay(myHomeStay);
                        },
                      ),
                    );
                    homeStayBloc.getMyHomeStay();
                  },
                );
              } else
                return const SizedBox();
            },
          )
        ],
      ),

      ///Body
      body: Stack(
        children: [
          StreamBuilder<MyHomeStay>(
            stream: homeStayBloc.myHomeStayStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ///myHomeStay
                myHomeStay = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        ///Container height
                        height: 250,

                        ///Container width
                        width: double.infinity,

                        decoration: BoxDecoration(
                          ///borderRadius
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),

                          image: DecorationImage(
                            ///Image
                            image: NetworkImage(snapshot.data.urlImage),

                            ///Image fit
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          ///Padding
                          padding: const EdgeInsets.all(15),

                          child: Column(
                            ///Using mainAxisAlignment in a Column will align its children vertically.
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              Text(
                                ///Text
                                snapshot.data.name.toUpperCase(),

                                style: TextStyle(
                                  ///Text size
                                  fontSize: 30,

                                  ///Text spacing
                                  letterSpacing: 1.5,

                                  ///Text color
                                  color: Colors.white,

                                  ///Text weight
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    ///Icon
                                    Icons.phone,

                                    ///Icon color
                                    color: AppColors.buttonColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ///Text
                                    snapshot.data.phone,

                                    style: TextStyle(
                                      ///Text size
                                      fontSize: 15,

                                      ///Text spacing
                                      letterSpacing: 1.5,

                                      ///Text color
                                      color: Colors.white,

                                      ///Text weight
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        ///Text
                        "Room list".toUpperCase(),

                        style: TextStyle(
                          ///Text size
                          fontSize: 20,

                          ///Text spacing
                          letterSpacing: 1.5,

                          ///Text weight
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        ///width
                        width: 200,

                        child: Divider(
                          ///height
                          height: 2,

                          ///color
                          color: AppColors.buttonColor,
                        ),
                      ),
                      Padding(
                        ///Padding
                        padding: const EdgeInsets.all(10),

                        child: Column(
                          children: [
                            StreamBuilder<List<Room>>(
                              ///initialData
                              initialData: [],

                              ///stream
                              stream: homeStayBloc.listRoomStream,

                              ///builder
                              builder: (context, snapshot1) {
                                return Column(
                                  children: snapshot1.data
                                      .map(
                                        (e) => ItemMyRoom(
                                            themeData, e, homeStayBloc),
                                      )
                                      .toList(),
                                );
                              },
                            ),

                            ///Add room button
                            XButton(
                              "New Room",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return NewRoom();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    ///Using mainAxisAlignment in a Column will align its children vertically.
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        ///Container width
                        width: 200,

                        ///Container height
                        height: 200,

                        child: NoFoundWidget("Don`t have home stay"),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      ///Add button
                      SizedBox(
                        ///width
                        width: 200,

                        child: XButton(
                          "Create New",
                          () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NewHomeStay();
                                },
                              ),
                            );
                            homeStayBloc.getMyHomeStay();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          StreamBuilder<UIState>(
            stream: homeStayBloc.myHomeStayStateStream,
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
