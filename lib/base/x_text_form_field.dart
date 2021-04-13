/// Note file x_text_form_field.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';

///XTextFormField StatefulWidget
class XTextFormField extends StatefulWidget {
  final Function funcValidation;
  final String hintText;
  final Color textColor;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Function onClickPrefix;
  final Widget suffixIcon;
  final Function onClickSuffix;
  final bool obscureText;
  final TextInputType textInputType;
  final int maxLine;
  final bool enable;
  final bool readOnly;
  final bool contentCenter;
  final bool border;
  final Function onChanged;
  final Function onSubmitted;
  final double verticalPadding;
  final bool autoFocus;
  final FocusNode focusNode;
  final Function onTap;
  final Function onFocus;
  final String suffixText;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  final Key key;

  XTextFormField(
      {this.onTap,
      this.textInputAction,
      this.controller,
      this.funcValidation,
      this.hintText,
      this.textColor = Colors.black87,
      this.prefixIcon,
      this.onClickPrefix,
      this.suffixIcon,
      this.onClickSuffix,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.enable = true,
      this.readOnly = false,
      this.contentCenter = false,
      this.border = true,
      this.onChanged,
      this.onSubmitted,
      this.verticalPadding = 20,
      this.autoFocus = false,
      this.focusNode,
      this.onFocus,
      this.suffixText,
      this.key,
      this.onFieldSubmitted});

  @override
  _XTextFormFieldFocusNodeState createState() =>
      _XTextFormFieldFocusNodeState();
}

/// _XTextFormFieldFocusNodeState  State<>
class _XTextFormFieldFocusNodeState extends State<XTextFormField> {
  String errorText;
  bool errorBorder = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          if (widget.onFocus != null) widget.onFocus();
        }
      },
      child: TextFormField(
        textInputAction: widget.textInputAction,
        key: widget.key,
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus,
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: (widget.contentCenter) ? TextAlign.center : TextAlign.left,
        readOnly: widget.readOnly,
        enabled: widget.enable,
        maxLines: widget.maxLine,
        controller: widget.controller,
        obscureText: widget.obscureText,
        obscuringCharacter: "*",
        onTap: () {
          widget.onTap();
        },
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: widget.textColor,
        ),
        keyboardType: widget.textInputType,
        validator: (value) {
          if (widget.funcValidation != null) {
            if (widget.funcValidation(value) != null) {
              setState(() {
                errorText = widget.funcValidation(value);
                errorBorder = false;
              });
            } else {
              setState(() {
                errorText = null;
                errorBorder = true;
              });
            }
            return widget.funcValidation(value);
          }
          setState(() {
            errorText = null;
            errorBorder = false;
          });
          return null;
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: (widget.contentCenter)
              ? const EdgeInsets.symmetric(vertical: 0, horizontal: 0)
              : EdgeInsets.symmetric(
                  vertical: widget.verticalPadding, horizontal: 15),
          hintStyle: TextStyle(
              fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 1,
            ),
          ),
          enabledBorder: (errorBorder)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.grey,
                    width: 1,
                  ),
                ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 1,
            ),
          ),
          focusedErrorBorder: (widget.border)
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
          errorBorder: (widget.border)
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
          focusedBorder: (widget.border)
              ? OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.buttonColor,
                    width: 2,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
          counterStyle: TextStyle(
            fontSize: 12,
          ),
          suffixText: widget.suffixText,
          prefixStyle: TextStyle(color: Colors.black),
          errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.transparent,
          ),
          counterText: errorText,
          filled: true,
          fillColor: AppColors.grey,
        ),
      ),
    );
  }
}

/// MDropBoxTextFormField<T> StatefulWidget
class MDropBoxTextFormField<T> extends StatefulWidget {
  final Function funcValidation;
  final String hintText;
  final int maxLine;
  final List<T> items;
  final List<DropdownMenuItem<T>> dropDownItems;
  final T initValue;
  final Function callback;
  final Widget prefixIcon;
  final Key key;
  final String idDayStart;
  final String align;
  final String region;
  final String currency;
  final String accountGroup;
  final bool isPrefixIcon;

  MDropBoxTextFormField(
      {this.funcValidation,
      @required this.hintText,
      this.maxLine = 1,
      this.items,
      this.dropDownItems,
      this.initValue,
      this.callback,
      this.idDayStart,
      this.prefixIcon,
      this.key,
      this.currency,
      this.region,
      this.accountGroup,
      this.align,
      this.isPrefixIcon = true})
      : super(key: key);

  @override
  _MDropBoxTextFormFieldState<T> createState() => _MDropBoxTextFormFieldState();
}

/// _MDropBoxTextFormFieldState<T> State<>
class _MDropBoxTextFormFieldState<T> extends State<MDropBoxTextFormField> {
  String errorText;
  T value;
  String name = '';

  @override
  void initState() {
    super.initState();
    if (widget.idDayStart != null) {
      value = widget.items.firstWhere(
          (element) => element.id == widget.idDayStart,
          orElse: () => value = null);
    }

    if (widget.align != null) {
      value = widget.items.firstWhere((element) => element.id == widget.align,
          orElse: () => value = null);
      if (value != null) {
        widget.callback(value);
      }
    }

    if (widget.region != null) {
      value = widget.items.firstWhere(
          (element) => element.name == widget.region,
          orElse: () => value = null);
      if (value != null) {
        widget.callback(value);
      }
    }

    if (widget.currency != null) {
      value = widget.items.firstWhere(
          (element) => element.name == widget.currency,
          orElse: () => value = null);
      if (value != null) {
        widget.callback(value);
      }
    }

    if (widget.initValue != null) value = widget.initValue;
    print(widget.accountGroup);
    if (widget.accountGroup != null) {
      value = widget.items.firstWhere(
          (element) => element.id == widget.accountGroup,
          orElse: () => value = null);
      if (value != null) widget.callback(value);
    }
  }

  @override
  void didUpdateWidget(covariant MDropBoxTextFormField oldWidget) {
    if (widget.idDayStart != null) {
      value = widget.items.firstWhere(
          (element) => element.id == widget.idDayStart,
          orElse: () => value = null);
    }

    if (widget.align != null) {
      value = widget.items.firstWhere((element) => element.id == widget.align,
          orElse: () => value = null);
      if (value != null) {
        widget.callback(value);
      }
    }

    if (widget.region != null) {
      value = widget.items.firstWhere(
          (element) => element.name == widget.region,
          orElse: () => value = null);
      if (value != null) {
        widget.callback(value);
      }
    }

    if (widget.currency != null) {
      value = widget.items.firstWhere(
          (element) => element.name == widget.currency,
          orElse: () => value = null);
      if (value != null) {
        widget.callback(value);
      }
    }

    if (widget.initValue != null) value = widget.initValue;
    print(widget.accountGroup);
    if (widget.accountGroup != null) {
      value = widget.items.firstWhere(
          (element) => element.id == widget.accountGroup,
          orElse: () => value = null);
      if (value != null) widget.callback(value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ((widget.items == null || widget.items.isEmpty) &&
            (widget.dropDownItems == null || widget.dropDownItems.isEmpty))
        ? XTextFormField(
            enable: false,
            hintText: (value != null) ? name : widget.hintText,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: widget.isPrefixIcon ? Colors.grey : Colors.transparent,
            ),
            prefixIcon: widget.prefixIcon,
          )
        : DropdownButtonFormField<T>(
            focusColor: AppColors.grey,
            value: value,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: widget.isPrefixIcon
                  ? AppColors.buttonColor
                  : Colors.transparent,
            ),
            items: widget.dropDownItems ??
                widget.items.map((e) {
                  return DropdownMenuItem<T>(
                    value: e,
                    child: Text(e.name, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
            onChanged: (newValue) {
              value = newValue;
              widget.callback(value);
            },
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: (widget.prefixIcon != null) ? 5 : 15),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                borderSide: BorderSide(
                  color: AppColors.grey,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: AppColors.grey,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: AppColors.buttonColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: AppColors.buttonColor,
                  width: 2,
                ),
              ),
              counterStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              counterText: errorText,
            ),
          );
  }
}

///MDropDown2 StatefulWidget
class MDropDown2 extends StatefulWidget {
  final List<ItemModel> list;
  final Function callBack;
  final ItemModel init;
  final String hintText;
  MDropDown2({this.list, this.callBack, this.init, this.hintText = "Choose"});
  @override
  _MDropDown2State createState() => _MDropDown2State();
}

/// _MDropDown2State State<>
class _MDropDown2State extends State<MDropDown2> {
  ItemModel itemModel;
  @override
  void initState() {
    widget.list.forEach((element) {
      if (widget.init != null &&
          (element.id == widget.init.id || element.name == widget.init.name)) {
        itemModel = element;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 60,

      ///Container weight
      width: double.infinity,

      decoration: BoxDecoration(
        ///Color box
        color: AppColors.grey,

        ///Border box
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        ///Padding
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: Center(
          child: DropdownButton<ItemModel>(
            underline: SizedBox(),
            isExpanded: true,
            value: itemModel,
            hint: Text(widget.hintText),
            onChanged: (ItemModel value) {
              setState(() {
                itemModel = value;
              });
              widget.callBack(itemModel);
            },
            items: widget.list.map((ItemModel user) {
              return DropdownMenuItem<ItemModel>(
                value: user,
                child: Text(
                  user.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
