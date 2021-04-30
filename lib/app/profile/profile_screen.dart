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
import 'package:flutter_booking_mobile_app/app/admin/admin_screen.dart';
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
  ///themeData
  ThemeData themeData;

  ///isDark
  bool isDark = false;

  ///profileBloc
  ProfileBloc profileBloc;

  ///account
  Account account;

  @override
  void initState() {
    profileBloc = new ProfileBloc()..init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ///themeData
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    if (themeData ==
        ThemeData.dark().copyWith(
          ///Color of the main banner
          primaryColor: AppColors.primaryColor,

          ///Color
          accentColor: AppColors.primaryColor,

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
    ///theme
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
            ///top
            top: -MediaQuery.of(context).size.width * 1.3,

            ///left
            left: -MediaQuery.of(context).size.width / 2,

            child: Container(
              ///Container width
              width: MediaQuery.of(context).size.width * 2,

              ///Container height
              height: MediaQuery.of(context).size.width * 2,

              decoration: BoxDecoration(
                ///Color box
                color: AppColors.primaryColor,

                ///Shape box
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Stack(
              ///Alignment
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
                                ///color
                                color: Colors.grey.withOpacity(0.5),

                                ///spreadRadius
                                spreadRadius: 5,

                                ///blurRadius
                                blurRadius: 7,

                                ///offset
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
                                const SizedBox(
                                  height: 90,
                                ),
                                StreamBuilder<Account>(
                                  stream: profileBloc.accountStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      ///account
                                      account = snapshot.data;

                                      return Text(
                                        ///Text
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
                                        ///Text
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
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    ///Padding
                                    padding: const EdgeInsets.all(10),

                                    child: Column(
                                      ///Using mainAxisAlignment in a Column will align its children vertically.
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ///Image
                                                    'assets/svg/dark.svg',

                                                    ///Image width
                                                    width: 20,

                                                    ///color
                                                    // ignore: deprecated_member_use
                                                    color: themeData
                                                        // ignore: deprecated_member_use
                                                        .textSelectionColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    ///Text
                                                    "Theme (Light / Dark)",

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

                                            ///Switch light theme, dark theme
                                            CupertinoSwitch(
                                              ///value
                                              value: isDark,

                                              ///activeColor
                                              activeColor:
                                                  AppColors.primaryColor,

                                              ///onChanged
                                              onChanged: (v) {
                                                if (v) {
                                                  theme.setTheme(0);
                                                } else {
                                                  theme.setTheme(1);
                                                }
                                                setState(
                                                  () {
                                                    isDark = v;
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),

                                        ///Account
                                        ItemFunction(
                                          ///color
                                          // ignore: deprecated_member_use
                                          color: themeData.textSelectionColor,

                                          ///urlSVG
                                          urlSVG: "assets/svg/user.svg",

                                          ///title
                                          title: "Manage Account",

                                          ///onTap
                                          onTap: () {
                                            showAccount();
                                          },
                                        ),

                                        ///My home stay
                                        ItemFunction(
                                          ///color
                                          // ignore: deprecated_member_use
                                          color: themeData.textSelectionColor,

                                          ///urlSVG
                                          urlSVG: "assets/svg/house.svg",

                                          ///title
                                          title: "Manage Home Stay",

                                          ///onTap
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MyHomeStayScreen();
                                            }));
                                          },
                                        ),

                                        ///Transaction history
                                        ItemFunction(
                                          ///color
                                          // ignore: deprecated_member_use
                                          color: themeData.textSelectionColor,

                                          ///urlSVG
                                          urlSVG: "assets/svg/history.svg",

                                          ///title
                                          title: "Manage Transaction",

                                          ///onTap
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return HistoryBookingScreen();
                                                },
                                              ),
                                            );
                                          },
                                        ),

                                        StreamBuilder<Account>(
                                          stream: profileBloc.accountStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return snapshot.data.permission ==
                                                      1
                                                  ? ItemFunction(
                                                      ///color
                                                      color: themeData
                                                          // ignore: deprecated_member_use
                                                          .textSelectionColor,

                                                      ///urlSVG
                                                      urlSVG:
                                                          "assets/svg/admin.svg",

                                                      ///title
                                                      title:
                                                          "Role Administrator",

                                                      ///onTap
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return AdminScreen();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : SizedBox();
                                            } else
                                              return SizedBox();
                                          },
                                        ),
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
                  },
                ),
                Text(
                  ///Text
                  "Profile".toUpperCase(),

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
          Positioned(
            ///Bottom
            bottom: MediaQuery.of(context).size.height - 100,

            ///Left
            left: 5,

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
                  height: 40,

                  ///Container width
                  width: 40,

                  decoration: BoxDecoration(
                    ///Color box
                    color: themeData.scaffoldBackgroundColor,

                    ///Border box
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Center(
                    ///Icon
                    child: Icon(
                      ///Icon
                      Icons.home,

                      ///Icon color
                      color: AppColors.primaryColor,

                      ///Icon size
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Show account
  void showAccount() {
    showModalBottomSheet(
      ///context
      context: context,

      ///backgroundColor
      backgroundColor: Colors.transparent,

      ///builder
      builder: (BuildContext _) {
        return Center(
          child: AccountScreen(
            themeData.scaffoldBackgroundColor,
            account,
            profileBloc,
          ),
        );
      },

      ///isScrollControlled
      isScrollControlled: true,
    );
  }
}
