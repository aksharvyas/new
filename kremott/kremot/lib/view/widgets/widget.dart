import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/utils/Constants.dart';
import '../../res/AppColors.dart';
import '../../res/AppDimensions.dart';

void showToastFun(BuildContext? context, String? message) {
  // showToast(message,
  //     context: context,
  //     animation: StyledToastAnimation.slideFromBottom,
  //     reverseAnimation: StyledToastAnimation.slideToBottom,
  //     startOffset: const Offset(0.0, 3.0),
  //     reverseEndOffset: const Offset(0.0, 3.0),
  //     position: StyledToastPosition.bottom,
  //     duration: const Duration(seconds: 3),
  //     //Animation duration   animDuration * 2 <= duration
  //     animDuration: const Duration(seconds: 1),
  //     curve: Curves.elasticOut,
  //     reverseCurve: Curves.fastOutSlowIn);
}

Widget textFormField(
    BuildContext context,
    {
      String? hintText,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    int? maxLines,
    node,
    TextStyle? hintStyle,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    double? verticalPadding,
    bool? obscureText,
    List<TextInputFormatter>? inputFormatters,
    bool? readOnly,
    Key? key,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    int? maxLength,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted1}) {
  return Stack(
    children: [
  //   Container(
  //   height: boxHeight ?? 51,
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //             color: const Color(0x80eceded), width: 1),
  //         boxShadow: const [
  //           BoxShadow(
  //               offset: Offset(0.0, 3),
  //               blurRadius: 2,
  //               spreadRadius: 0)
  //         ],
  //         color: const Color(0xb81b1918)
  //     ),
  // ),
      TextFormField(
        key: key,
        onTap: onTap,
        validator: validator,
        obscureText: obscureText ?? false,
        controller: controller,
        onChanged: onChanged,
        enabled: true,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        textAlign: TextAlign.left,
        keyboardType: keyboardType,
        style: hintStyle,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted1,
        inputFormatters: inputFormatters ??
            [
              LengthLimitingTextInputFormatter(100),
            ],
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 10)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
            fillColor: context.resources.color.colorTextFieldBg,
          isDense: true,
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle,
          errorStyle: TextStyle(fontSize: getAdaptiveTextSize(context, textFieldErrorTextFontSize)),
          // fillColor: const Color(0xb81b1918),
          // contentPadding:
          //     const EdgeInsets.only(top: 15, bottom: 15,left: 10),
          contentPadding: EdgeInsets.only(top: verticalPadding ?? 0, bottom: verticalPadding ?? 0, left: 10)
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

    ]);
}

GestureDetector getPrimaryButtonShowLoader(
    context, title, onPress, showLoader, height, width, bool isValidated) {
  if (showLoader) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // alignment: Alignment.center,
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                //image: AssetImage('assets/images/agree.png'),
                image: AssetImage(selectedButtonImage),
                fit: BoxFit.fill
              ),
            ),
          ),
          setUpButtonChild(showLoader, context, title, height, width, isValidated),
        ],
      ),
      onTap: () {},
    );
  } else {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // alignment: Alignment.center,
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                //image: AssetImage('assets/images/agree.png'),
                image: AssetImage(isValidated ? selectedButtonImage : unSelectedButtonImage),
                fit: BoxFit.fill
              ),
            ),
          ),
          setUpButtonChild(showLoader, context, title, height, width, isValidated),
        ],
      ),
    );
  }
}

setUpButtonChild(
  bool showLoader,
  BuildContext context,
  String title,
    height, width,
    bool isValidated
) {
  if (!showLoader) {
    return Text(title,
        style: TextStyle(
            color: isValidated ? textColor : highLightColor,
            fontWeight: FontWeight.w400,
            //fontFamily: "Inter",
            fontStyle: FontStyle.normal,
            fontSize: getAdaptiveTextSize(context, 12.0)),
        textAlign: TextAlign.center);
  } else {
    return const SizedBox(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 2,
      ),
    );
  }
}

Widget getHomeHorizontalItem(BuildContext context, bool selected, String name, double screenHeight, double screenWidth, double height, double width) {
  return Row(
    children: [
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(selected ? selectedButtonImage : unSelectedButtonImage,
              height: height, width: width, fit: BoxFit.fill),
          Positioned.fill(
            child: Align(
              //alignment: Alignment.topCenter,
                child: Text(name,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: getAdaptiveTextSize(context, homePageButtonTextSize)),
                    textAlign: TextAlign.center)),
          ),
        ],
      ),
      SizedBox(
        width: getWidth(screenWidth, 16),
      ),
    ],
  );
}


Widget getHomeHorizontalItem1(BuildContext context, bool selected, String name, double screenHeight, double screenWidth, double height, double width) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(selected ? selectedButtonImage : unSelectedButtonImage,
              height: height, width: width, fit: BoxFit.fill),
          Positioned.fill(
            child: Align(
              //alignment: Alignment.topCenter,
                child: Text(name,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        fontSize: getAdaptiveTextSize(context, 10.3)),
                    textAlign: TextAlign.center)),
          ),
        ],
      ),
      SizedBox(
        height: getHeight(screenHeight, 15),
      ),
    ],
  );
}

Widget kRemotButton(double screenWidth, double screenHeight){
  return Image.asset(
      kRemotUnSelectedImage,
      height: getHeight(
          screenHeight, kRemotButtonHeight),
      width: getWidth(
          screenWidth, kRemotButtonWidth),
      fit: BoxFit.fill);
}

navigationPushPage({BuildContext? context, Widget? pageName}) {
  Navigator.push(context!, MaterialPageRoute(builder: (context) => pageName!));
}

navigationPushReplacementPage({BuildContext? context, Widget? pageName}) {
  Navigator.of(context!).pushReplacement(MaterialPageRoute(
    builder: (context) => pageName!,
  ));
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimRight();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

showAlertDialog(BuildContext context, content, onOkButtonClick) {
  Widget okButton = ElevatedButton(
    onPressed: onOkButtonClick,
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(context.resources.color.colorBlack)),
    child:  const Text("OK", style: TextStyle(color: Color(0xff777575))),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(content,style: const TextStyle(color: Color(0xff777575)),),
    backgroundColor: Colors.white,
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        alignment: Alignment.center,
        child: alert,
      );
    },
  );
}


String? validatePassword(String? value) {
  RegExp passValid =
  RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
  if (value!.isEmpty) {
    return 'Password is required';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!passValid.hasMatch(value)) {
    return 'Password contains one Uppercase and one lowercase and one number';
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return 'Phone Number is required';
  } else if (value.length < 10) {
    return 'Phone Number is required at least 10 digits';
  } else {
    return null;
  }
}

getAdaptiveTextSize(BuildContext context, dynamic value) {
  // 720 is medium screen height
  return (value / 720) * MediaQuery.of(context).size.height;
}

double getWidth(double swidth, double cwidth) {
  //return ((swidth * cwidth) / 411.42857142857144);
  return ((swidth * cwidth) / 384);
}

double getHeight(double sheight, double cheight) {
  //return (sheight * cheight) / 843.4285714285714;
  return (sheight * cheight) / 808.1777777777778;
}

double getX(double swidth, double componetXPos) {
  //return ((swidth * componetXPos) / 411.42857142857144);
  return ((swidth * componetXPos) / 384);
}

double getY(double sheight, double componentYPos) {
  //return (sheight * componentYPos) / 843.4285714285714;
  return (sheight * componentYPos) / 808.1777777777778;
}

double getNextFenControlPosition(
    int listLength, double controlHeight, double controlSpace) {
  return ((controlHeight * ((listLength % 4) + 1)) +
      ((listLength % 4) * controlSpace));
}

double getNextFanControlPosition(
    int listLength, double controlHeight, double controlSpace) {
  return ((controlHeight * ((listLength / 4).ceil())) +
      (((listLength / 4).ceil() + 1) * controlSpace));
}


