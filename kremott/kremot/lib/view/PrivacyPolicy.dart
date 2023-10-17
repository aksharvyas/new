import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppContextExtension.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.resources.color.colorBlack,
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            child: Container(
                              //alignment: Alignment.center,
                              height: 72.0,
                              width: 330.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/spalsh.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            top: 10,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: context
                                              .resources.color.colorWhite,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 29.7),
                                      text: "K"),
                                  TextSpan(
                                      style: TextStyle(
                                          color: context
                                              .resources.color.colorWhite,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 19),
                                      text: "REMOT")
                                ]))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(context.resources.strings.labelTermsCondition,
                          style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.justify),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  width: 335,
                  height: 400,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: Color(0xffeceded)),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32'
                      'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32'
                      'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(context.resources.strings.labelAgree,
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                    textAlign: TextAlign.justify),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 44.0,
                      width: 80.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/agree.png'),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 10,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(context.resources.strings.labelAgreeText,
                              style: const TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.center)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
