import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final userCollection = FirebaseFirestore.instance.collection("category");
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  File? _image;
  File? _image2;
  List<String> language = ['English', 'Gujarati', 'Hindi'];
  String languageValue = '';
  String filenameEroor="";
  String filename2Error='';
  String fileName = 'Select File';
  String fileName2 = 'Select Category Image';
  TextEditingController categoryController = new TextEditingController();
  TextEditingController bookNameController = new TextEditingController();
  TextEditingController autharNameController = new TextEditingController();
  TextEditingController mrpController = new TextEditingController();
  TextEditingController discPriceController = new TextEditingController();
  TextEditingController bookPageControlller = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.1,
            MediaQuery.of(context).size.height * 0.1,
            MediaQuery.of(context).size.width * 0.1,
            0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              //    Text(categoryValue),
              // Text(languageValue),
              Text(
                "ADD CATEGORY",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.07),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TextFormField(
                      controller: categoryController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Category Name',
                          hintText: 'Enter Category Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Category Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await getImageFromGalleryCategory();
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.03,
                              MediaQuery.of(context).size.height * 0.015,
                              0,
                              0),
                          child: Text(
                            fileName2,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ),
                        decoration: BoxDecoration(
border: Border.all(color: filename2Error.isEmpty? Colors.black:Colors.red),
                          borderRadius: BorderRadius.circular(30),),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    filename2Error.isNotEmpty?Text("   "+filename2Error, style: TextStyle(
                      color: Colors.red, fontSize: 12
                    ),):Container(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    // TextFormField(
                    //   controller: bookNameController,
                    //
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //
                    //       ),
                    //       labelText: 'Book Name',
                    //       hintText: 'Enter Book Name'),
                    //
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter Book Name';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     await getImageFromGallery();
                    //   },
                    //   child: Container(
                    //
                    //     width: double.infinity,
                    //     height: MediaQuery.of(context).size.height * 0.06,
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(
                    //           MediaQuery.of(context).size.width * 0.03,
                    //           MediaQuery.of(context).size.height * 0.015,
                    //           0,
                    //           0),
                    //       child: Text(
                    //         fileName,
                    //         style: TextStyle(
                    //             fontSize:
                    //                 MediaQuery.of(context).size.width * 0.04),
                    //       ),
                    //     ),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30),
                    //         border: Border.all(color: filenameEroor.isNotEmpty?Colors.red:Colors.black)),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 3,
                    // ),
                    // filenameEroor==''?Column(): Text("    "+filenameEroor,style: TextStyle(
                    //   color: Colors.red,
                    //   fontSize: 12
                    // ),),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // TextFormField(
                    //   controller: autharNameController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       labelText: 'Auther',
                    //       hintText: 'Enter Auther Name'),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter Auther Name';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   controller: mrpController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //
                    //       labelText: 'MRP',
                    //       hintText: 'Enter MRP'),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter MRP';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   controller: discPriceController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       labelText: 'Discounted Price',
                    //       hintText: 'Enter Discounted Price'),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter Discountedp Price';
                    //     }
                    //     else if(int.parse(mrpController.text)<int.parse(value)){
                    //       return 'Discounted Price is not more than MRP';
                    //     }
                    //     else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   controller: bookPageControlller,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       labelText: 'Book Pages',
                    //       hintText: 'Enter Book Pages'),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter Book Pages';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   controller: quantityController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       labelText: 'Quantity',
                    //       hintText: 'Enter Quantity'),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter Book Pages';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.04,
                    // ),
                    // Container(decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(30),
                    //   border: Border.all(color: Colors.black)
                    // ),
                    //   width: double.infinity,
                    //   child: Padding(
                    //     padding:  EdgeInsets.symmetric(horizontal: 10),
                    //     child: DropdownButton<String>(
                    //
                    //
                    //
                    //       value:
                    //           languageValue.isEmpty ? language[0] : languageValue,
                    //       hint: Text(
                    //           'Select Language                                     '),
                    //       // underline: Container(
                    //       //   height: 2,
                    //       //   color: Colors.deepPurpleAccent,
                    //       // ),
                    //       onChanged: (String? value) {
                    //         // This is called when the user selects an item.
                    //         setState(() {
                    //           languageValue = value!;
                    //         });
                    //       },
                    //       items: language
                    //           .map<DropdownMenuItem<String>>((String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value),
                    //         );
                    //       }).toList(),
                    //     ),
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    new SizedBox(
                        width: MediaQuery.of(context).size.width * 0.83,
                        height: MediaQuery.of(context).size.height * 0.07,
                        //   height: 67,
                        child: ElevatedButton(
                            onPressed: () async {
                              // if(fileName=="Select File"){
                              //   filenameEroor="Select a image for book";
                              //       setState(() {
                              //
                              //       });
                              // }
                              if(fileName2=="Select Category Image"){
                                filename2Error="Select a image for Catgory";
                                setState(() {

                                });
                              }
                              if(_formKey.currentState!.validate()&& fileName2!="Select Category Image"){
                                setState(() {
                                  loading = true;
                                });
                                await addData();
                                Navigator.pop(context);

                              }


                            },
                            child: loading == true
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Submit",
                              style:
                              TextStyle(fontSize: 16, color: Color(0xFFFFF9FF)),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xFF53B175),
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(19.0),
                                    ))))),
                  ],
                ),
              ),

          ),
        );


  }

  addData() async {
    // final addBook = await userCollection
    //     .doc(categoryController.text.toString())
    //     .collection(categoryController.text.toString())
    //     .doc();



    //   await addBook.set({
    //   "Book Name": bookNameController.text.toString(),
    //   "Authar Name": autharNameController.text.toString(),
    //   "MRP": mrpController.text.toString(),
    //   "Discounted Price": discPriceController.text.toString(),
    //   "Book Pages": bookPageControlller.text.toString(),
    //   "Language": languageValue.isEmpty ? language[0] : languageValue,
    //   "Added Date": DateTime.now().timeZoneOffset,
    //   "Quantity": quantityController.text.toString()
    // }).then((e) {
    //   Fluttertoast.showToast(
    //     msg: 'Book Added Successfully',
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     textColor: Colors.white,
    //     backgroundColor: Colors.blueGrey,
    //     fontSize: 16,
    //   );
    // }).onError((error, stackTrace) {
    //   Fluttertoast.showToast(
    //     msg: error.toString(),
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     textColor: Colors.white,
    //     backgroundColor: Colors.blueGrey,
    //     fontSize: 16,
    //   );
    // });
    await userCollection
        .doc(categoryController.text.toString())
        .set({"Category Created at": DateTime.now().toString()});
   // await uploadImage(addBook.id);
    await uploadImageCategory();
  }

  uploadImage(String id) async {
    final saveImageCollection =await  userCollection
        .doc(categoryController.text.toString())
        .collection(categoryController.text.toString())
        .doc(id);
    final storageref = await FirebaseStorage.instance;
    UploadTask uploadTask = storageref
        .ref('BookImage/' +
            categoryController.text.toString() +
            '/' +
            bookNameController.text.toString())
        .putFile(_image!.absolute);

    await Future.value(uploadTask).then((value) async {
      var url = await storageref
          .ref('BookImage/' +
              categoryController.text.toString() +
              '/' +
              bookNameController.text.toString())
          .getDownloadURL();
print(url);
      await saveImageCollection.update({'Image URL': url.toString()}).then((e) {
        Fluttertoast.showToast(
          msg: 'Image Uploaded',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: "Image Upload Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
      });
      setState(() {
        loading = false;
      });
    });
  }

  Future getImageFromGallery() async {
    final pickimage = ImagePicker();

    final pickedFile = await pickimage.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxHeight: double.infinity,
        maxWidth: double.infinity);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {
          fileName = basename(_image!.path);
        });
      } else {
        print("Image is not Picked");
      }
    });
  }

  uploadImageCategory() async {
    final saveImageCollection =
        userCollection.doc(categoryController.text.toString());
    final storageref = FirebaseStorage.instance;
    UploadTask uploadTask = storageref
        .ref('CategoryImage/' + categoryController.text.toString())
        .putFile(_image2!.absolute);

    await Future.value(uploadTask).then((value) async {
      var url = await storageref
          .ref('CategoryImage/' + categoryController.text.toString())
          .getDownloadURL();

      await saveImageCollection.update({'Image URL': url.toString()}).then((e) {
        Fluttertoast.showToast(
          msg: 'Category Image Uploaded',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: "Category Image Upload Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
      });
      setState(() {
        loading = false;
      });
    });
  }

  Future getImageFromGalleryCategory() async {
    final pickimage = ImagePicker();

    final pickedFile = await pickimage.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxHeight: double.infinity,
        maxWidth: double.infinity);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
        setState(() {
          fileName2 = basename(_image2!.path);
        });
      } else {
        print("Image is not Picked");
      }
    });
  }
}
