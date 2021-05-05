/// Note file x_text_form_field.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';

///XTextFormField StatefulWidget
class XTextFormField extends StatefulWidget {
  ///key
  final Key key;

  ///enable
  final bool enable;

  ///maxLine
  final int maxLine;

  ///readOnly
  final bool readOnly;

  ///focusNode
  final FocusNode focusNode;

  ///autoFocus
  final bool autoFocus;

  ///controller
  final TextEditingController controller;

  ///obscureText
  final bool obscureText;

  ///textInputAction
  final TextInputAction textInputAction;

  ///onFieldSubmitted
  final Function onFieldSubmitted;

  ///border
  final bool border;

  ///contentCenter
  final bool contentCenter;

  ///textColor
  final Color textColor;

  ///hintText
  final String hintText;

  ///suffixText
  final String suffixText;

  ///prefixIcon
  final Widget prefixIcon;

  ///suffixIcon
  final Widget suffixIcon;

  ///verticalPadding
  final double verticalPadding;

  ///onTap
  final Function onTap;

  ///onFocus
  final Function onFocus;

  ///onChanged
  final Function onChanged;

  ///onSubmitted
  final Function onSubmitted;

  ///onClickPrefix
  final Function onClickPrefix;

  ///onClickSuffix
  final Function onClickSuffix;

  ///funcValidation
  final Function funcValidation;

  ///textInputType
  final TextInputType textInputType;



  XTextFormField({
    this.key,
    this.maxLine = 1,
    this.enable = true,
    this.border = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.obscureText = false,
    this.contentCenter = false,
    this.textColor = Colors.black87,
    this.hintText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.verticalPadding = 20,
    this.onTap,
    this.onFocus,
    this.onChanged,

    this.onSubmitted,
    this.onClickPrefix,
    this.onClickSuffix,
    this.funcValidation,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.controller,
  });

  @override
  _XTextFormFieldFocusNodeState createState() =>
      _XTextFormFieldFocusNodeState();
}

/// _XTextFormFieldFocusNodeState  State<>
class _XTextFormFieldFocusNodeState extends State<XTextFormField> {
  ///errorText
  String errorText;

  ///errorBorder
  bool errorBorder = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      ///onFocusChange
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          if (widget.onFocus != null) widget.onFocus();
        }
      },

      child: TextFormField(
        ///key
        key: widget.key,

        ///enabled
        enabled: widget.enable,


        ///maxLines
        maxLines: widget.maxLine,

        ///readOnly
        readOnly: widget.readOnly,

        ///focusNode
        focusNode: widget.focusNode,

        ///auto focus
        autofocus: widget.autoFocus,

        ///textAlign
        textAlign: (widget.contentCenter) ? TextAlign.center : TextAlign.left,

        ///controller
        controller: widget.controller,

        ///obscureText
        obscureText: widget.obscureText,

        ///textInputAction
        textInputAction: widget.textInputAction,

        ///onFieldSubmitted
        onFieldSubmitted: widget.onFieldSubmitted,

        ///obscuringCharacter
        obscuringCharacter: "*",

        ///onTap
        onTap: () {
          widget.onTap?.call();
        },

        style: TextStyle(
          ///color
          color: widget.textColor,

          ///font size
          fontSize: 16,

          ///font weight
          fontWeight: FontWeight.w600,

          ///decoration
          decoration: TextDecoration.none,
        ),

        ///keyboardType
        keyboardType: widget.textInputType,

        ///validator
        validator: (value) {
          if (widget.funcValidation != null) {
            if (widget.funcValidation(value) != null) {
              setState(() {
                ///errorText
                errorText = widget.funcValidation(value);

                ///errorBorder
                errorBorder = false;
              });
            } else {
              setState(() {
                ///errorText
                errorText = null;

                ///errorBorder
                errorBorder = true;
              });
            }
            return widget.funcValidation(value);
          }
          setState(() {
            ///errorText
            errorText = null;

            ///errorBorder
            errorBorder = false;
          });
          return null;
        },

        ///onChanged
        onChanged: widget.onChanged,

        decoration: InputDecoration(
          ///Hint text
          hintText: widget.hintText,

          ///contentPadding
          contentPadding: (widget.contentCenter)
              ? const EdgeInsets.symmetric(
                  ///vertical
                  vertical: 0,

                  ///horizontal
                  horizontal: 0,
                )
              : EdgeInsets.symmetric(
                  ///vertical
                  vertical: widget.verticalPadding,

                  ///horizontal
                  horizontal: 15,
                ),

          ///Hint text style
          hintStyle: TextStyle(
            ///Hint text size
            fontSize: 16,

            ///Hint text color
            color: Colors.grey,

            ///Hint text weight
            fontWeight: FontWeight.w600,
          ),

          ///prefixIcon
          prefixIcon: widget.prefixIcon,

          ///suffixIcon
          suffixIcon: widget.suffixIcon,

          ///Border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              ///Width border
              width: 1,

              ///Color border
              color: AppColors.grey,
            ),
          ),

          ///enabledBorder
          enabledBorder: (errorBorder)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 1,

                    ///Border side color
                    color: Colors.transparent,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 1,

                    ///Border side color
                    color: Colors.grey,
                  ),
                ),

          ///disabledBorder
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              ///Border side width
              width: 1,

              ///Border side color
              color: Colors.grey,
            ),
          ),

          ///focusedErrorBorder
          focusedErrorBorder: (widget.border)
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 1,

                    ///Border side color
                    color: Colors.red,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 1,

                    ///Border side color
                    color: Colors.transparent,
                  ),
                ),

          ///errorBorder
          errorBorder: (widget.border)
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 2,

                    ///Border side color
                    color: Colors.red,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 1,

                    ///Border side color
                    color: Colors.transparent,
                  ),
                ),

          ///focusedBorder
          focusedBorder: (widget.border)
              ? OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 2,

                    ///Border side color
                    color: AppColors.primaryColor,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    ///Border side width
                    width: 2,

                    ///Border side color
                    color: Colors.transparent,
                  ),
                ),

          ///Counter style
          counterStyle: TextStyle(
            ///Text size
            fontSize: 12,
          ),

          ///Suffix text
          suffixText: widget.suffixText,

          ///Prefix text style
          prefixStyle: TextStyle(
            color: Colors.black,
          ),

          ///Error text style
          errorStyle: TextStyle(
            ///Text size
            fontSize: 12,

            ///Text color
            color: Colors.transparent,
          ),

          ///counterText
          counterText: errorText,

          ///filled
          filled: true,

          ///fillColor
          fillColor: AppColors.grey,
        ),
      ),
    );
  }
}

/// XDropBoxTextFormField<T> StatefulWidget
class XDropBoxTextFormField<T> extends StatefulWidget {
  ///funcValidation
  final Function funcValidation;

  ///hintText
  final String hintText;

  ///maxLine
  final int maxLine;

  ///items
  final List<T> items;

  ///dropDownItems
  final List<DropdownMenuItem<T>> dropDownItems;

  ///initValue
  final T initValue;

  ///callback
  final Function callback;

  ///prefixIcon
  final Widget prefixIcon;

  ///key
  final Key key;

  ///idDayStart
  final String idDayStart;

  ///align
  final String align;

  ///region
  final String region;

  ///currency
  final String currency;

  ///accountGroup
  final String accountGroup;

  ///isPrefixIcon
  final bool isPrefixIcon;

  XDropBoxTextFormField({
    this.funcValidation,
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
    this.isPrefixIcon = true,
  }) : super(key: key);

  @override
  _XDropBoxTextFormFieldState<T> createState() => _XDropBoxTextFormFieldState();
}

/// _MDropBoxTextFormFieldState<T> State<>
class _XDropBoxTextFormFieldState<T> extends State<XDropBoxTextFormField> {
  ///errorText
  String errorText;

  ///value
  T value;

  ///name
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
  void didUpdateWidget(covariant XDropBoxTextFormField oldWidget) {
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
            ///enable
            enable: false,

            ///Hint text
            hintText: (value != null) ? name : widget.hintText,

            ///suffixIcon
            suffixIcon: Icon(
              ///Icon
              Icons.keyboard_arrow_down,

              ///Icon color
              color: widget.isPrefixIcon ? Colors.grey : Colors.transparent,
            ),

            ///prefixIcon
            prefixIcon: widget.prefixIcon,
          )
        : DropdownButtonFormField<T>(
            ///value
            value: value,

            ///isExpanded
            isExpanded: true,

            ///focusColor
            focusColor: AppColors.grey,

            icon: Icon(
              ///Icon
              Icons.keyboard_arrow_down,

              ///Icon color
              color: widget.isPrefixIcon
                  ? AppColors.primaryColor
                  : Colors.transparent,
            ),

            ///items
            items: widget.dropDownItems ??
                widget.items.map((e) {
                  return DropdownMenuItem<T>(
                    value: e,
                    child: Text(e.name, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),

            ///onChanged
            onChanged: (newValue) {
              value = newValue;
              widget.callback(value);
            },

            decoration: InputDecoration(
              ///prefixIcon
              prefixIcon: widget.prefixIcon,

              ///contentPadding
              contentPadding: EdgeInsets.symmetric(
                ///vertical
                vertical: 5,

                ///horizontal
                horizontal: (widget.prefixIcon != null) ? 5 : 15,
              ),

              ///Hint text
              hintText: widget.hintText,

              ///Hint text style
              hintStyle: TextStyle(
                ///Text size
                fontSize: 13,

                ///Text color
                color: Colors.grey,
              ),

              ///border
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                borderSide: BorderSide(
                  ///Border side width
                  width: 2,

                  ///Border side color
                  color: AppColors.grey,
                ),
              ),

              ///enabledBorder
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  ///Border side width
                  width: 2,

                  ///Border side color
                  color: AppColors.grey,
                ),
              ),

              ///focusedErrorBorder
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  ///Border side width
                  width: 2,

                  ///Border side color
                  color: AppColors.primaryColor,
                ),
              ),

              ///focusedBorder
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  ///Border side width
                  width: 2,

                  ///Border side color
                  color: AppColors.primaryColor,
                ),
              ),

              ///counterStyle
              counterStyle: TextStyle(
                ///Text size
                fontSize: 13,

                ///Text color
                color: Colors.black,

                ///Text weight
                fontWeight: FontWeight.w500,
              ),

              ///counterText
              counterText: errorText,
            ),
          );
  }
}

///XDropDown2 StatefulWidget
class XDropDown2 extends StatefulWidget {
  ///list
  final List<ItemModel> list;

  ///callBack
  final Function callBack;

  ///init
  final ItemModel init;

  ///hintText
  final String hintText;

  XDropDown2({
    this.list,
    this.callBack,
    this.init,
    this.hintText = "Choose",
  });

  @override
  _XDropDown2State createState() => _XDropDown2State();
}

/// _XDropDown2State State<>
class _XDropDown2State extends State<XDropDown2> {
  ///itemModel
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
            ///underline
            underline: SizedBox(),

            ///isExpanded
            isExpanded: true,

            ///value
            value: itemModel,

            ///hint text
            hint: Text(widget.hintText),

            ///onChanged
            onChanged: (ItemModel value) {
              setState(() {
                itemModel = value;
              });
              widget.callBack(itemModel);
            },

            ///items
            items: widget.list.map((ItemModel user) {
              return DropdownMenuItem<ItemModel>(
                ///value
                value: user,
                child: Text(
                  ///Text
                  user.name,
                  style: TextStyle(
                    ///Text color
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
