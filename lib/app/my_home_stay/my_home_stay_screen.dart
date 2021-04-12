///Note

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

///class MyHomeStayScreen extends StatefulWidget
class MyHomeStayScreen extends StatefulWidget {
  @override
  _MyHomeStayScreenState createState() => _MyHomeStayScreenState();
}

///class _MyHomeStayScreenState extends State<MyHomeStayScreen>
class _MyHomeStayScreenState extends State<MyHomeStayScreen> {
  ThemeData themeData;
  HomeStayBloc homeStayBloc;

  @override
  void didChangeDependencies() {
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

  MyHomeStay myHomeStay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: themeData.scaffoldBackgroundColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 1,
        centerTitle: true,
        title: Text(
          "My home stay".toUpperCase(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.edit,
                color: AppColors.buttonColor,
              ),
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return EditHomeStay(myHomeStay);
                    }));
                homeStayBloc.getMyHomeStay();
              })
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder<MyHomeStay>(
              stream: homeStayBloc.myHomeStayStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  myHomeStay = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data.urlImage),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data.name.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30,
                                      letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: AppColors.buttonColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data.phone,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15,
                                          letterSpacing: 1.5),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "room list".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 1.5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: Divider(
                            height: 2,
                            color: AppColors.buttonColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              StreamBuilder<List<Room>>(
                                  initialData: [],
                                  stream: homeStayBloc.listRoomStream,
                                  builder: (context, snapshot1) {
                                    return Column(
                                        children: snapshot1.data
                                            .map(
                                              (e) => ItemMyRoom(
                                              themeData, e, homeStayBloc),
                                        )
                                            .toList());
                                  }),
                              XButton("Add room", () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return NewRoom();
                                    }));
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 200,
                            height: 200,
                            child: NoFoundWidget("Don`t home stay")),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: XButton("Add", () async {
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return NewHomeStay();
                                }));

                            homeStayBloc.getMyHomeStay();
                          }),
                        )
                      ],
                    ),
                  );
                }
              }),
          StreamBuilder<UIState>(
              stream: homeStayBloc.myHomeStayStateStream,
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
