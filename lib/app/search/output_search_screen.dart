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
  final HomeBloc homeBloc; ///
  OutputSearchScreen(this.homeBloc); ///
  @override
  _OutputSearchScreenState createState() => _OutputSearchScreenState();
}

/// _OutputSearchScreenState State<>
class _OutputSearchScreenState extends State<OutputSearchScreen> {
  ThemeData themeData; ///
  @override
  void initState() {
    super.initState(); ///
  }

  ///
  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme(); ///
    super.didChangeDependencies(); ///
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor, ///Background color
        elevation: 0,                                       ///

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); ///
          },

          child: Padding(
            padding: const EdgeInsets.all(15),              ///Padding
            child: Container(
              height: 30,                                   ///Container height
              width: 30,                                    ///Container width
              decoration: BoxDecoration(
                color: AppColors.buttonColor,               ///Box color
                borderRadius: BorderRadius.circular(10),    ///Box border
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,             ///Icon
                  color: themeData.scaffoldBackgroundColor, ///Icon color
                  size: 15,                                 ///Icon size
                ),
              ),
            ),
          ),
        ),

        centerTitle: true, ///

        title: Text(
          "Search".toUpperCase(),                   ///toUpperCase
          style: TextStyle(
            // ignore: deprecated_member_use
              color: themeData.textSelectionColor,  ///Text color
              fontSize: 20,                         ///Text size
              fontWeight: FontWeight.bold,          ///Text weight
              letterSpacing: 1,                     ///Text spacing
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<Account>(
                stream: widget.homeBloc.accountStream, ///
                ///builder
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: 40, ///width
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), ///Border box
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data.avatar), ///Image
                            fit: BoxFit.cover, ///Image fit
                          )
                      ),
                    );
                  } else
                    return LoadingBar(); ///Return LoadingBar
                }
            ),
          ),
        ],
      ),

      ///Body
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),

          Expanded(
            child: StreamBuilder<List<Room>>(
                stream: widget.homeBloc.listRoomStream, ///
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    return Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ItemSearch(snapshot.data[index]); ///
                        },
                        itemCount: snapshot.data.length, ///
                      ),
                    );
                  } else
                    return NoFoundWidget("No data"); ///
                }),
          ),
        ],
      ),
    );
  }
}
