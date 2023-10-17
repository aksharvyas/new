import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget.dart';

class DialogTextField extends StatefulWidget {

  double xPosition;
  double yPosition;
  double textFieldWidth;
  double textFieldHeight;
  String? initialValue;
  String? hintText;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  int? maxLines;
  TextStyle? hintStyle;
      TextInputAction? textInputAction;
  TextInputType? keyboardType;
      dynamic bottomPadding;
  dynamic topPadding;
      bool? obscureText;
  List<TextInputFormatter>? inputFormatters;
      bool? readOnly;
      ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
      int? maxLength;
  VoidCallback? onEditingComplete;
      ValueChanged<String>? onFieldSubmitted;
      String? alignment;

  DialogTextField(this.xPosition, this.yPosition, this.textFieldWidth, this.textFieldHeight, {Key? key,this.initialValue, this.hintText,
  this.controller,
  this.validator,
    this.maxLines,
    this.hintStyle,
    this.textInputAction,
    this.keyboardType,
    this.bottomPadding,
    this.topPadding,
    this.obscureText,
    this.inputFormatters,
    this.readOnly,
    this.onChanged,
  this.onTap,
  this.maxLength,
  this.onEditingComplete,
  this.onFieldSubmitted,
  this.alignment}) : super(key: key);

  @override
  State<DialogTextField> createState() => _DialogTextFieldState();
}

class _DialogTextFieldState extends State<DialogTextField> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return widget.alignment == "center" ?
    Positioned(
      top: getY(screenHeight, widget.yPosition),
      child: Material(
        child: SizedBox(
            width: getWidth(screenWidth, widget.textFieldWidth),
            height: getHeight(screenHeight, widget.textFieldHeight),
            child: Stack(
                children: [
                  // Separate container with identical height of text field which is placed behind the actual textfield
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0x80eceded), width: 1),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 3),
                              blurRadius: 2,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xb81b1918)),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextFormField(
                      key: widget.key,
                      onTap: widget.onTap,
                      validator: widget.validator,
                      initialValue: widget.initialValue,
                      obscureText: widget.obscureText ?? false,
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      enabled: true,
                      readOnly: widget.readOnly ?? false,
                      maxLines: widget.maxLines ?? 1,
                      textAlign: TextAlign.left,
                      keyboardType: widget.keyboardType,
                      style: widget.hintStyle,
                      textInputAction: widget.textInputAction,
                      onEditingComplete: widget.onEditingComplete,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      inputFormatters: widget.inputFormatters ??
                          [
                            LengthLimitingTextInputFormatter(100),
                          ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        isDense: true,
                        filled: true,
                        hintText: widget.hintText,
                        hintStyle: widget.hintStyle,
                        // fillColor: const Color(0xb81b1918),
                        contentPadding:
                        const EdgeInsets.only(top: 10, left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color: Color(0x80eceded), width: 1),
                        // ),
                        // disabledBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),
                        // focusedErrorBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),
                        // errorBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),

                        //filled: true,
                      ),
                    ),
                  )
                ])
        ),
      ),)
    :
    Positioned(
      left: getX(screenWidth, widget.xPosition),
      top: getY(screenHeight, widget.yPosition),
      child: Material(
        child: SizedBox(
            width: getWidth(screenWidth, widget.textFieldWidth),
            height: getHeight(screenHeight, widget.textFieldHeight),
            child: Stack(
                children: [
                  // Separate container with identical height of text field which is placed behind the actual textfield
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0x80eceded), width: 1),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 3),
                              blurRadius: 2,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xb81b1918)),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextFormField(
                      key: widget.key,
                      onTap: widget.onTap,
                      validator: widget.validator,
                      initialValue: widget.initialValue,
                      obscureText: widget.obscureText ?? false,
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      enabled: true,
                      readOnly: widget.readOnly ?? false,
                      maxLines: widget.maxLines ?? 1,
                      textAlign: TextAlign.left,
                      keyboardType: widget.keyboardType,
                      style: widget.hintStyle,
                      textInputAction: widget.textInputAction,
                      onEditingComplete: widget.onEditingComplete,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      inputFormatters: widget.inputFormatters ??
                          [
                            LengthLimitingTextInputFormatter(100),
                          ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        isDense: true,
                        filled: true,
                        hintText: widget.hintText,
                        hintStyle: widget.hintStyle,
                        // fillColor: const Color(0xb81b1918),
                        contentPadding:
                        const EdgeInsets.only(top: 10, left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color: Color(0x80eceded), width: 1),
                        // ),
                        // disabledBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),
                        // focusedErrorBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),
                        // errorBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                        // ),

                        //filled: true,
                      ),
                    ),
                  )
                ])
        ),
      ),);
  }
}
