///Note file item_avatar.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/app/profile/bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';


///class ItemAvatar extends StatelessWidget
class ItemAvatar extends StatelessWidget {
  final Color color; ///
  final String avatar; ///
  final ProfileBloc profileBloc; ///
  ItemAvatar(this.color, this.avatar, this.profileBloc);
  final picker = ImagePicker(); ///
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        profileBloc.fileIamgeStream.add(null); ///
        showGetImage(context); ///
      },
      child: Container(
        margin: const EdgeInsets.only(top: 40), ///
        height: 150, ///Container height
        width: 150, ///Container width
        decoration: BoxDecoration(
          color: AppColors.buttonColor, ///Color box
          shape: BoxShape.circle, ///
          border: Border.all(color: color, width: 6), ///Border box
        ),
        child: Padding(
          padding: const EdgeInsets.all(5), ///
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, ///
                image: DecorationImage(
                    image: NetworkImage(avatar), ///
                    fit: BoxFit.cover, ///
                ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  void showGetImage(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true, ///
        context: context, ///
        backgroundColor: Colors.transparent, ///
        builder: (context) {
          return StreamBuilder<File>(
              stream: profileBloc.fileIamgeStream, ///
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 300, ///Container height
                    width: double.infinity, ///Container width
                    decoration: BoxDecoration(
                      color: color, ///
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), ///
                          topRight: Radius.circular(10), ///
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20, ///
                        vertical: 10, ///
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, ///Using mainAxisAlignment in a Column will align its children vertically.
                        children: [
                          Container(
                            width: 200,   ///Container width
                            height: 200,  ///Container height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7), ///Border box
                            ),

                            child: Image.file(
                              snapshot.data,      ///
                              width: 200,         ///Image width
                              height: 200,        ///Image height
                              fit: BoxFit.cover,  ///Image fit
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          ///Save button
                          XButton("Save", () {

                          })
                        ],
                      ),
                    ),
                  );
                } else

                  return Container(
                    height: 100, ///Container height
                    width: double.infinity, ///Container width
                    decoration: BoxDecoration(
                      color: color, ///Color box
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, ///
                          vertical: 10, ///
                      ),

                      child: Row(
                        children: [
                          Expanded(
                              child: XButton("Camera", () {
                                profileBloc.getImageByCamera(picker); ///
                              })
                          ),

                          SizedBox(
                            width: 10,
                          ),

                          Expanded(
                              child: XButton("Library", () {
                                profileBloc.getImageByGallery(picker); ///
                              })),
                        ],
                      ),
                    ),
                  );
              });
        });
  }
}
