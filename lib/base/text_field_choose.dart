///Note file text_field_choose.dart

import 'x_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/no_fount.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';

///class TextFieldChoose extends StatefulWidget
class TextFieldChoose extends StatefulWidget {
  final IconData iconData; ///
  final String hintText; ///
  final String intiText; ///
  final List<ItemModel> items; ///
  final Function callBack; ///
  ///
  TextFieldChoose(
      {this.iconData, this.hintText, this.intiText, this.items, this.callBack});
  @override
  _TextFieldChooseState createState() => _TextFieldChooseState();
}

///class _TextFieldChooseState extends State<TextFieldChoose>
class _TextFieldChooseState extends State<TextFieldChoose> {
  TextEditingController controller; ///
  int _index = -1; ///
  ThemeData themeData; ///
  @override
  void initState() {
    controller = new TextEditingController(text: widget.intiText ?? ""); ///
    if (widget.intiText != null) {
      widget.items.forEach((element) {
        if (element.name == widget.intiText)
          _index = widget.items.indexOf(element);
      });
    }
    super.initState();
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
    return GestureDetector(
      onTap: () {
        showModalItem(); ///
      },
      child: MTextFormField(
        enable: false, ///
        hintText: widget.hintText, ///
        controller: controller, ///
        funcValidation: ValidateData.validEmpty, ///
        prefixIcon: Icon(
          widget.iconData, ///
          color: AppColors.buttonColor, ///
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down, ///Icon
          color: AppColors.buttonColor, ///Icon color
        ),
      ),
    );
  }

  ///Note
  void showModalItem() {
    showModalBottomSheet(
      isScrollControlled: true, ///
      backgroundColor: Colors.transparent, ///
      context: context, ///
      ///
      builder: (context) => Center(
        child: Container(
          width: 250, ///Container width
          height: 12.0 * widget.items.length, ///Container height
          decoration: BoxDecoration(
            color: themeData.scaffoldBackgroundColor, ///
            borderRadius: BorderRadius.circular(10), ///
          ),
          constraints: BoxConstraints(minHeight: 200, maxHeight: 500), ///
          child: Padding(
            padding: const EdgeInsets.all(20), ///
            child: widget.items.length > 0
                ? ListView.builder(
              itemCount: widget.items.length, ///
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7), ///
                  child: GestureDetector(
                    onTap: () {
                      _index = i; ///
                      controller.text = widget.items[i].name; ///
                      widget.callBack(widget.items[i].name); ///
                      Navigator.pop(context); ///
                    },
                    child: Text(
                      widget.items[i].name, ///
                      style: TextStyle(
                          color: _index == i
                              ? AppColors.buttonColor
                          // ignore: deprecated_member_use
                              : themeData.textSelectionColor, ///
                          fontWeight: _index == i
                              ? FontWeight.w800
                              : FontWeight.w500, ///
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
