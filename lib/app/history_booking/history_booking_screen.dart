///Note history_booking_screen.dart

import 'widget/item_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/history_booking_bloc.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/no_fount.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/transaction.dart';

///HistoryBookingScreen StatefulWidget
class HistoryBookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

/// _BookingScreenState State<>
class _BookingScreenState extends State<HistoryBookingScreen> {
  ///themeData
  ThemeData themeData;

  ///historyBookingBloc
  HistoryBookingBloc historyBookingBloc;

  @override
  void initState() {
    historyBookingBloc = new HistoryBookingBloc()..init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
                color: AppColors.primaryColor,

                ///Border box
                borderRadius: BorderRadius.circular(10),
              ),

              child: Center(
                ///Icon
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

        ///Tittle
        title: Text(
          ///Text
          "History Booking".toUpperCase(),

          style: TextStyle(
            ///Text size
            fontSize: 20,

            // ignore: deprecated_member_use
            color: themeData.textSelectionColor,

            ///Text weight
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      ///Body
      body: Stack(
        children: [
          DefaultTabController(
            ///length
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
                      ///isScrollable
                      isScrollable: false,

                      ///labelColor
                      labelColor: AppColors.primaryColor,

                      ///unselectedLabelColor
                      unselectedLabelColor: Colors.grey,

                      ///indicatorWeight
                      indicatorWeight: 2,

                      ///indicatorColor
                      indicatorColor: AppColors.primaryColor,

                      ///tabs
                      tabs: [
                        Tab(icon: Text("Confirmed")),
                        Tab(icon: Text("Cancelled")),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      StreamBuilder<List<Transactions>>(
                        stream: historyBookingBloc.historyBookingStream1,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data.length > 0)
                            return Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: snapshot.data
                                      .map(
                                        (e) => ItemHistory(
                                          themeData,
                                          e,
                                          historyBookingBloc,
                                          isCancel: true,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            );
                          else
                            return NoFoundWidget("No data");
                        },
                      ),
                      StreamBuilder<List<Transactions>>(
                        stream: historyBookingBloc.historyBookingStream4,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data.length > 0)
                            return Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: snapshot.data
                                      .map(
                                        (e) => ItemHistory(
                                            themeData, e, historyBookingBloc),
                                      )
                                      .toList(),
                                ),
                              ),
                            );
                          else
                            return NoFoundWidget("No data");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<UIState>(
            stream: historyBookingBloc.historyBookingStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING)
                return LoadingBar();
              else
                return Center();
            },
          )
        ],
      ),
    );
  }
}
