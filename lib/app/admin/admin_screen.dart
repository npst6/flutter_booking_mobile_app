///Note file admin_screen.dart

import 'widget/item_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/no_fount.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/app/admin/bloc/admin_bloc.dart';
import 'package:flutter_booking_mobile_app/app/admin/widget/item_new_room.dart';

/// AdminScreen StatefulWidget
class AdminScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

///_BookingScreenState State<>
class _BookingScreenState extends State<AdminScreen> {
  ///Initialization
  ///themeData
  ThemeData themeData;

  ///adminBloc
  AdminBloc adminBloc;

  @override
  void initState() {
    adminBloc = new AdminBloc()..init();
    super.initState();
  }

  ///After exiting the screen, the variables in this function will clear
  @override
  void dispose() {
    adminBloc.dispose();
    super.dispose();
  }

  ///Listen to stream during execution
  @override
  void didChangeDependencies() {
    ///Get the app's theme if Dark Mode is enabled
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  ///Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///Background color
        backgroundColor: themeData.scaffoldBackgroundColor,

        ///Elevation
        elevation: 0,

        leadingWidth: 70,

        leading: Padding(
          ///Padding
          padding: const EdgeInsets.only(left: 10),

          child: GestureDetector(
            ///onTap
            onTap: () {
              Navigator.pop(context);
            },

            child: Padding(
              ///Padding
              padding: const EdgeInsets.all(10),

              child: Container(
                ///Container height
                height: 20,

                ///Container width
                width: 20,

                decoration: BoxDecoration(
                  ///Color box
                  color: AppColors.primaryColor,

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
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),

        ///Title spacing
        titleSpacing: 1,

        ///Title center
        centerTitle: true,

        title: Text(
          ///Text
          "Administrator".toUpperCase(),

          style: TextStyle(
            ///Text size
            fontSize: 20,

            ///Text weight
            fontWeight: FontWeight.bold,

            ///Text spacing
            letterSpacing: 2,

            ///Text color
            // ignore: deprecated_member_use
            color: themeData.textSelectionColor,
          ),
        ),
      ),

      ///Body
      body: DefaultTabController(
        ///Length
        length: 2,

        child: Column(
          children: [
            Padding(
              ///Padding
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),

              child: Container(
                ///Container width
                width: double.infinity,

                child: TabBar(
                  ///Label color
                  labelColor: AppColors.primaryColor,

                  ///Unselected label color
                  unselectedLabelColor: Colors.grey,

                  ///Indicator weight
                  indicatorWeight: 2,

                  ///Indicator color
                  indicatorColor: AppColors.primaryColor,

                  ///Tabs
                  tabs: [
                    Tab(icon: Text("Approve Room")),
                    Tab(icon: Text("Permission Account")),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ///List Room
                  StreamBuilder<List<Room>>(
                    stream: adminBloc.listRoomStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return Container(
                            child: SingleChildScrollView(
                              child: Column(
                                  children: snapshot.data
                                      .map(
                                        (e) => ItemNewRoom(
                                            themeData, e, adminBloc),
                                      )
                                      .toList()),
                            ),
                          );
                        } else {
                          return NoFoundWidget("No news");
                        }
                      } else {
                        return LoadingBar();
                      }
                    },
                  ),

                  ///List Account
                  StreamBuilder<List<Account>>(
                    stream: adminBloc.accountStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data
                                  .map(
                                    (e) => ItemUser(
                                      themeData,
                                      account: e,
                                      adminBloc: adminBloc,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      } else
                        return LoadingBar();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
