///Note file profile_screen.dart

import 'bloc/profile_bloc.dart';
import 'widget/item_avatar.dart';
import 'widget/item_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/app/profile/widget/account_screen.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/my_home_stay_screen.dart';
import 'package:flutter_booking_mobile_app/app/history_booking/history_booking_screen.dart';

///ProfileScreen StatefulWidget
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

/// _ProfileScreenState  State<>
class _ProfileScreenState extends State<ProfileScreen> {
  ThemeData themeData;
  bool isDark = false;
  ProfileBloc profileBloc;
  Account account;

  @override
  void initState() {
    profileBloc = new ProfileBloc()..init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    if (themeData == ThemeData.dark().copyWith(
      ///Color of the main banner
      primaryColor: AppColors.buttonColor,

      ///Color
      accentColor: AppColors.buttonColor,

      ///Light background
      scaffoldBackgroundColor: Colors.black,

      ///Text color
      // ignore: deprecated_member_use
      textSelectionColor: Colors.white,
    )) {
      isDark = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          ///Container width
          width: double.infinity,

          ///Container height
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: -MediaQuery.of(context).size.width * 1.3,
          left: -MediaQuery.of(context).size.width / 2,
          child: Container(
            ///Container width
            width: MediaQuery.of(context).size.width * 2,

            ///Container height
            height: MediaQuery.of(context).size.width * 2,

            decoration: BoxDecoration(
              ///Color box
              color: AppColors.buttonColor,

              ///Shape box
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                ///Container width
                width: MediaQuery.of(context).size.width * 0.85,

                ///Container height
                height: MediaQuery.of(context).size.height * 0.7,

                child: Column(
                  children: [
                    Container(
                      ///Container height
                      height: 100,

                      ///Container width
                      width: double.infinity,
                    ),
                    Expanded(
                      child: Container(
                        ///Container width
                        width: double.infinity,

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],

                          ///Color container
                          color: themeData.scaffoldBackgroundColor,

                          ///Border container
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Padding(
                          ///Padding
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 90,
                              ),
                              StreamBuilder<Account>(
                                  stream: profileBloc.accountStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      account = snapshot.data;
                                      return Text(
                                        snapshot.data.name.toUpperCase(),
                                        style: TextStyle(
                                          ///Text size
                                          fontSize: 16,

                                          ///Text weight
                                          fontWeight: FontWeight.w900,

                                          ///Text spacing
                                          letterSpacing: 1.5,
                                        ),
                                      );
                                    } else
                                      return Text(
                                        "...".toUpperCase(),
                                        style: TextStyle(
                                          ///Text size
                                          fontSize: 16,

                                          ///Text weight
                                          fontWeight: FontWeight.w900,

                                          ///Text spacing
                                          letterSpacing: 1.5,
                                        ),
                                      );
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  ///Padding
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/dark.svg',
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Dark/Light",
                                                  style: TextStyle(
                                                    ///Text size
                                                    fontSize: 16,

                                                    ///Text spacing
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CupertinoSwitch(
                                              value: isDark,
                                              activeColor:
                                                  AppColors.buttonColor,
                                              onChanged: (v) {
                                                if (v) {
                                                  theme.setTheme(0);
                                                } else {
                                                  theme.setTheme(1);
                                                }
                                                setState(() {
                                                  isDark = v;
                                                });
                                              }),
                                        ],
                                      ),
                                      ItemFunction(
                                        // ignore: deprecated_member_use
                                        color: themeData.textSelectionColor,
                                        urlSVG: "assets/svg/user.svg",
                                        title: "Account",
                                        onTap: () {
                                          showAccount();
                                        },
                                      ),
                                      ItemFunction(
                                        // ignore: deprecated_member_use
                                        color: themeData.textSelectionColor,
                                        urlSVG: "assets/svg/house.svg",
                                        title: "My HomeStay",
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return MyHomeStayScreen();
                                          }));
                                        },
                                      ),
                                      ItemFunction(
                                        // ignore: deprecated_member_use
                                        color: themeData.textSelectionColor,
                                        urlSVG: "assets/svg/history.svg",
                                        title: "Transaction history",
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HistoryBookingScreen();
                                          }));
                                        },
                                      ),
                                      StreamBuilder<Account>(
                                          stream: profileBloc.accountStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return snapshot.data.permission ==
                                                      1
                                                  ? ItemFunction(
                                                      color: themeData
                                                          // ignore: deprecated_member_use
                                                          .textSelectionColor,
                                                      urlSVG:
                                                          "assets/svg/admin.svg",
                                                      title: "Admin",
                                                      onTap: () {},
                                                    )
                                                  : SizedBox();
                                            } else
                                              return SizedBox();
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///StreamBuilder
              StreamBuilder<Account>(
                  stream: profileBloc.accountStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ItemAvatar(
                        themeData.scaffoldBackgroundColor,
                        snapshot.data.avatar,
                        profileBloc,
                      );
                    } else
                      return SizedBox();
                  }),

              Text(
                "Profile",
                style: TextStyle(
                  ///Text size
                  fontSize: 20,

                  ///Text weight
                  fontWeight: FontWeight.w900,

                  ///Text spacing
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<UIState>(
          stream: profileBloc.accountStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == UIState.LOADING)
              return LoadingBar();
            else
              return Center();
          },
        ),
      ],
    ));
  }

  ///Show account
  void showAccount() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext _) {
        return Center(
          child: AccountScreen(
            themeData.scaffoldBackgroundColor,
            account,
            profileBloc,
          ),
        );
      },
      isScrollControlled: true,
    );
  }
}
