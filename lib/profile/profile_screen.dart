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


///class ProfileScreen extends StatefulWidget
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

///class _ProfileScreenState extends State<ProfileScreen>
class _ProfileScreenState extends State<ProfileScreen> {
  ThemeData themeData; ///
  bool isDark = true; ///
  ProfileBloc profileBloc; ///
  Account account; ///

  @override
  void initState() {
    profileBloc = new ProfileBloc()..init(); ///
    super.initState(); ///
  }

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme(); ///
    super.didChangeDependencies(); ///
  }

  @override
  void dispose() {
    profileBloc.dispose(); ///
    super.dispose(); ///
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context); ///
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity, ///
              height: MediaQuery.of(context).size.height, ///
            ),

            Positioned(
              top: -MediaQuery.of(context).size.width * 1.3, ///
              left: -MediaQuery.of(context).size.width / 2, ///
              child: Container(
                width: MediaQuery.of(context).size.width * 2, ///
                height: MediaQuery.of(context).size.width * 2, ///
                decoration: BoxDecoration(
                    color: AppColors.buttonColor, ///
                    shape: BoxShape.circle, ///
                ),
              ),
            ),

            Center(
              child: Stack(
                alignment: Alignment.topCenter, ///
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85, ///
                    height: MediaQuery.of(context).size.height * 0.7, ///
                    child: Column(
                      children: [
                        Container(
                          height: 100, ///Container height
                          width: double.infinity, ///Container width
                        ),

                        Expanded(
                          child: Container(
                            width: double.infinity, ///Container width
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5), ///Color box shadow
                                  spreadRadius: 5, ///
                                  blurRadius: 7, ///
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: themeData.scaffoldBackgroundColor, ///
                              borderRadius: BorderRadius.circular(10), ///
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(10), ///padding
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                  ),

                                  StreamBuilder<Account>(
                                      stream: profileBloc.accountStream, ///
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          account = snapshot.data; ///
                                          return Text(
                                            snapshot.data.name.toUpperCase(), ///
                                            style: TextStyle(
                                                fontSize: 16, ///Text size
                                                fontWeight: FontWeight.w900, ///Text weight
                                                letterSpacing: 1.5, ///Text spacing
                                            ),
                                          );
                                        } else
                                          return Text("...".toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 16, ///Text size
                                                  fontWeight: FontWeight.w900, ///Text weight
                                                  letterSpacing: 1.5, ///Text spacing
                                              ),
                                          );
                                      }),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween, ///
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
                                                          fontSize: 16, ///Text size
                                                          letterSpacing: 1, ///Text spacing
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              CupertinoSwitch(
                                                  value: isDark, ///
                                                  activeColor: AppColors.buttonColor, ///
                                                  onChanged: (v) {
                                                    if (v) {
                                                      theme.setTheme(1);
                                                    } else {
                                                      theme.setTheme(0);
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

                                            },
                                          ),

                                          ItemFunction(
                                            // ignore: deprecated_member_use
                                            color: themeData.textSelectionColor,
                                            urlSVG: "assets/svg/house.svg",
                                            title: "My HomeStay",
                                            onTap: () {

                                            },
                                          ),

                                          ItemFunction(
                                            // ignore: deprecated_member_use
                                            color: themeData.textSelectionColor,
                                            urlSVG: "assets/svg/history.svg",
                                            title: "Transaction history",
                                            onTap: () {

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
                                                    onTap: () {

                                                    },
                                                  )
                                                      : SizedBox();
                                                } else
                                                  return SizedBox();
                                              }
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

                  ///StreamBuilder
                  StreamBuilder<Account>(
                      stream: profileBloc.accountStream, ///
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ItemAvatar(
                            themeData.scaffoldBackgroundColor, ///
                            snapshot.data.avatar, ///
                            profileBloc, ///
                          );
                        } else
                          return SizedBox();
                      }
                  ),

                  Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 20, ///Text size
                        fontWeight: FontWeight.w900, ///Text weight
                        letterSpacing: 2, ///Text spacing
                    ),
                  ),
                ],
              ),
            ),

            StreamBuilder<UIState>(
                stream: profileBloc.accountStateStream, ///
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == UIState.LOADING)
                    return LoadingBar();
                  else
                    return Center();
                }, ///
            ),
          ],
        ));
  }

}