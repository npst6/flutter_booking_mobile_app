///Note file text_field_choose.dart

import 'x_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/no_fount.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';

///TextFieldChoose StatefulWidget
class TextFieldChoose extends StatefulWidget {
  ///hintText
  final String hintText;

  ///intiText
  final String intiText;

  ///iconData
  final IconData iconData;

  ///callBack
  final Function callBack;

  ///items
  final List<ItemModel> items;

  TextFieldChoose({
    this.items,
    this.iconData,
    this.hintText,
    this.intiText,
    this.callBack,
  });
  @override
  _TextFieldChooseState createState() => _TextFieldChooseState();
}

/// _TextFieldChooseState State<>
class _TextFieldChooseState extends State<TextFieldChoose> {
  /// _index
  int _index = -1;

  ///themeData
  ThemeData themeData;

  ///controller
  TextEditingController controller;

  @override
  void initState() {
    controller = new TextEditingController(text: widget.intiText);
    if (widget.intiText != null) {
      widget.items.forEach((element) {
        if (element.name == widget.intiText)
          _index = widget.items.indexOf(element);
      });
    }
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
    return Stack(
      children: [
        XTextFormField(
          ///controller
          controller: controller,

          ///hintText
          hintText: widget.hintText,

          ///funcValidation
          funcValidation: ValidateData.validEmpty,

          ///prefixIcon
          prefixIcon: Icon(
            widget.iconData,

            ///Icon color
            color: AppColors.primaryColor,
          ),

          ///suffixIcon
          suffixIcon: Icon(
            ///Icon
            Icons.arrow_drop_down,

            ///Icon color
            color: AppColors.primaryColor,
          ),
        ),
        GestureDetector(
          ///onTap
          onTap: () {
            showModalItem();
          },
          child: Container(
            height: 55,
            color: Colors.transparent,
            width: double.infinity,
          ),
        )
      ],
    );
  }

  void showModalItem() {
    showModalBottomSheet(
      ///context
      context: context,

      ///isScrollControlled
      isScrollControlled: true,

      ///backgroundColor
      backgroundColor: Colors.transparent,

      builder: (context) => Center(
        child: Container(
          ///Container width
          width: 250,

          ///Container height
          height: 12.0 * widget.items.length,

          decoration: BoxDecoration(
            ///Color box
            color: themeData.scaffoldBackgroundColor,

            ///Border box
            borderRadius: BorderRadius.circular(10),
          ),

          ///constraints
          constraints: BoxConstraints(
            ///minHeight
            minHeight: 200,

            ///maxHeight
            maxHeight: 500,
          ),

          child: Padding(
            ///Padding
            padding: const EdgeInsets.all(20),

            child: widget.items.length > 0
                ? ListView.builder(
                    ///itemCount
                    itemCount: widget.items.length,

                    ///itemBuilder
                    itemBuilder: (context, i) {
                      return Padding(
                        ///Padding
                        padding: const EdgeInsets.symmetric(vertical: 7),

                        child: GestureDetector(
                          ///onTap
                          onTap: () {
                            _index = i;
                            controller.text = widget.items[i].name;
                            widget.callBack(widget.items[i].name);
                            Navigator.pop(context);
                          },

                          child: Text(
                            ///Text
                            widget.items[i].name,
                            style: TextStyle(
                              ///Text color
                              color: _index == i
                                  ? AppColors.primaryColor
                                  // ignore: deprecated_member_use
                                  : themeData.textSelectionTheme.selectionColor,

                              ///Text weight
                              fontWeight: _index == i
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : NoFoundWidget("No data"),
          ),
        ),
      ),
    );
  }
}
