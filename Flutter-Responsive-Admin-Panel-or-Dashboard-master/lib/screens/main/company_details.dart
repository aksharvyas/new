import 'dart:io';

import 'package:admin/constants.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controllers/MenuAppController.dart';
import '../../controllers/routes.dart';
import 'components/add_company.dart';
import 'components/side_menu.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  ValueNotifier<List<CompanyListClass>> companyNotifier = ValueNotifier(listOfCompany);
  final GlobalKey<ScaffoldState> sca = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      key: sca,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed:     (){
                      sca.currentState!.openDrawer();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SvgPicture.asset("assets/icons/Search.svg"),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),

                  Column(
                    children: [

                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Company",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    ElevatedButton.icon(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 0.5,
                                          vertical: defaultPadding /
                                              (Responsive.isMobile(context) ? 2 : 1),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, MyRoutes.addCompany);
                                      },
                                      icon: Icon(Icons.add),
                                      label: Text("Add New"),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ValueListenableBuilder(
                                  valueListenable: companyNotifier,
                                  builder: (BuildContext context, List<CompanyListClass> value,
                                      child) {
                                    return ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: value.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        double containerSize =
                                            MediaQuery.of(context).size.height * 0.14;
                                        double imageSize = containerSize * 0.6;

                                        return Container(
                                          margin: EdgeInsets.only(left: 10, right: 10),
                                          height: containerSize,
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: imageSize,
                                                      height: imageSize,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(horizontal: 10),
                                                      padding: EdgeInsets.all(5),
                                                      child: ClipOval(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 2),
                                                          child: value[index].image != null
                                                              ? Image.network(
                                                                  value[index].image!,
                                                                  width: imageSize,
                                                                  height: imageSize,
                                                                  fit: BoxFit.fill,
                                                                )
                                                              : Image.file(
                                                                  new File(
                                                                    value[index]
                                                                        .image
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        value[index].name!,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => AddCompany(
                                                            companyName: value[index].name,
                                                            companyImage: value[index].image,
                                                            index: index,
                                                          ),
                                                        ),
                                                      );
                                                      companyNotifier.notifyListeners();
                                                    },
                                                    icon: Icon(Icons.edit, size: 20),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      deleteCompany(index);
                                                    },
                                                    icon: Icon(Icons.delete, size: 20),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return Divider();
                                      },
                                    );

                                    /* ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: value.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        //CompanyListClass companyList = listOfCompany[index];
                                        double containerSize =
                                            MediaQuery.of(context).size.height * 0.14;
                                        double imageSize = containerSize * 0.6;
                                        return Container(
                                          margin: EdgeInsets.only(left: 10, right: 10),
                                          height: containerSize,
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: imageSize,
                                                    height: imageSize,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    margin: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    child: ClipOval(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 2),
                                                        child: Image.network(
                                                          value[index].image!,
                                                          width: imageSize,
                                                          height: imageSize,
                                                          fit: BoxFit.cover,
                                                        ),

                                                        */ /*Image.file(
                                                          new File(
                                                            value[index].image.toString(),
                                                          ),
                                                        ),*/ /* // Image(
                                                        //   width: imageSize,
                                                        //   height: imageSize,
                                                        //   fit: BoxFit.fill,
                                                        //   image: Image.file(
                                                        //     File(value[index].image!)
                                                        //       ),
                                                        // ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    value[index].name!,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => AddCompany(
                                                            companyName: value[index].name,
                                                            companyImage: value[index].image,
                                                            index: index,
                                                          ),
                                                        ),
                                                      );
                                                      companyNotifier.notifyListeners();
                                                    },
                                                    icon: Icon(Icons.edit, size: 20),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      deleteCompany(index);
                                                    },
                                                    icon: Icon(Icons.delete, size: 20),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return Divider();
                                      },
                                    );*/
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

            ],
          ),
        ),
      ),
    );
  }

  void deleteCompany(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this company?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  listOfCompany.removeAt(index);
                });
                companyNotifier.notifyListeners();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
