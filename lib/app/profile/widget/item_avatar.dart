///Note file item_avatar.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/app/profile/bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';

///ItemAvatar StatelessWidget
class ItemAvatar extends StatelessWidget {
  ///color
  final Color color;

  ///avatar
  final String avatar;

  ///profileBloc
  final ProfileBloc profileBloc;

  ItemAvatar(
    this.color,
    this.avatar,
    this.profileBloc,
  );

  ///picker = ImagePicker()
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      ///onTap
      onTap: () {
        profileBloc.fileIamgeStream.add(null);
        showGetImage(context);
      },

      child: Container(
        ///Container height
        height: 150,

        ///Container width
        width: 150,

        ///Container margin
        margin: const EdgeInsets.only(top: 40),

        decoration: BoxDecoration(
          ///Color box
          color: AppColors.primaryColor,

          ///Shape box
          shape: BoxShape.circle,

          ///Border box
          border: Border.all(color: color, width: 6),
        ),

        child: Padding(
          ///Padding
          padding: const EdgeInsets.all(5),

          child: Container(
            decoration: BoxDecoration(
              ///Shape box
              shape: BoxShape.circle,

              ///Image
              image: DecorationImage(
                ///Image
                image: NetworkImage(avatar),

                ///Image fit
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showGetImage(BuildContext context) {
    showModalBottomSheet(
      ///context
      context: context,

      ///isScrollControlled
      isScrollControlled: true,

      ///Background color
      backgroundColor: Colors.transparent,

      ///builder
      builder: (context) {
        return StreamBuilder<File>(
          stream: profileBloc.fileIamgeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                ///Container height
                height: 300,

                ///Container width
                width: double.infinity,

                decoration: BoxDecoration(
                  ///Color box
                  color: color,

                  ///Border box
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),

                child: Padding(
                  ///Padding
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: Column(
                    ///Using mainAxisAlignment in a Column will align its children vertically.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Container(
                        ///Container width
                        width: 200,

                        ///Container height
                        height: 200,

                        decoration: BoxDecoration(
                          ///Border box
                          borderRadius: BorderRadius.circular(7),
                        ),

                        child: Image.file(
                          ///Image
                          snapshot.data,

                          ///Image width
                          width: 200,

                          ///Image height
                          height: 200,

                          ///Image fit
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      ///Save button
                      XButton(
                        "Save",
                        () {
                          profileBloc.updateImageAvatar(snapshot.data);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else
              return Container(
                ///Container height
                height: 100,

                ///Container width
                width: double.infinity,

                decoration: BoxDecoration(
                  ///Color box
                  color: color,

                  ///Border box
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),

                child: Padding(
                  ///Padding
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: Row(
                    children: [
                      ///Camera button
                      Expanded(
                        child: XButton(
                          "Camera",
                          () {
                            profileBloc.getImageByCamera(picker);
                          },
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      ///Library button
                      Expanded(
                        child: XButton(
                          "Library",
                          () {
                            profileBloc.getImageByGallery(picker);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
          },
        );
      },
    );
  }
}
