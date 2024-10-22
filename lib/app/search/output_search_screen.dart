import 'package:flutter_booking_mobile_app/app/profile/profile_screen.dart';

///Note file output_search_screen.dart

import 'widget/item_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/no_fount.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/app/home/bloc/home_bloc.dart';

///OutputSearchScreen StatefulWidget
class OutputSearchScreen extends StatefulWidget {
  ///homeBloc
  final HomeBloc homeBloc;

  OutputSearchScreen(this.homeBloc);

  @override
  _OutputSearchScreenState createState() => _OutputSearchScreenState();
}

/// _OutputSearchScreenState State<>
class _OutputSearchScreenState extends State<OutputSearchScreen> {
  ///themeData
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ///themeData
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///Background color
        backgroundColor: themeData.scaffoldBackgroundColor,

        ///Elevation
        elevation: 0,

        ///Leading
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
                ///Box color
                color: AppColors.primaryColor,

                ///Box border
                borderRadius: BorderRadius.circular(10),
              ),

              child: Center(
                child: Icon(
                  ///Icon
                  Icons.arrow_back_ios_rounded,

                  ///Icon color
                  color: themeData.scaffoldBackgroundColor,

                  ///Icon size
                  size: 15,
                ),
              ),
            ),
          ),
        ),

        ///Title center
        centerTitle: true,

        ///Title
        title: Text(
          ///Text, toUpperCase
          "Search".toUpperCase(),

          style: TextStyle(
            ///Text color
            // ignore: deprecated_member_use
            color: themeData.textSelectionTheme.selectionColor,

            ///Text size
            fontSize: 20,

            ///Text weight
            fontWeight: FontWeight.bold,

            ///Text spacing
            letterSpacing: 1,
          ),
        ),

        actions: [
          Padding(
            ///Padding
            padding: const EdgeInsets.all(8.0),

            child: StreamBuilder<Account>(
              stream: widget.homeBloc.accountStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      ///Container width
                      width: 40,

                      decoration: BoxDecoration(
                        ///Border box
                        borderRadius: BorderRadius.circular(10),

                        image: DecorationImage(
                          ///Image
                          image: NetworkImage(snapshot.data.avatar),

                          ///Image fit
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else
                  return LoadingBar();
              },
            ),
          ),
        ],
      ),

      ///Body
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<Room>>(
              stream: widget.homeBloc.listRoomStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ItemSearch(snapshot.data[index]);
                      },
                      itemCount: snapshot.data.length,
                    ),
                  );
                } else
                  return NoFoundWidget("No data");
              },
            ),
          ),
        ],
      ),
    );
  }
}
