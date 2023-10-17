import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class EditProduct extends StatefulWidget {
  String categoryName;
  String bookName;
  String autherName;
  String mrp;
  String discPrice;
  String bookPage;
  String language;
  String id;
  String quantity;
  String image;

  @override
  State<EditProduct> createState() => _EditProductState();

  EditProduct(
    this.categoryName,
    this.bookName,
    this.autherName,
    this.mrp,
    this.discPrice,
    this.bookPage,
    this.language,
    this.id,
    this.quantity,
    this.image,
  );
}

class _EditProductState extends State<EditProduct> {
  final userCollection = FirebaseFirestore.instance.collection("category");
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String categoryValue = '';
  File? _image;
  List<String> language = ['English', 'Gujarati', 'Hindi'];
  String languageValue = '';
  String fileName = 'Select File';
  bool isvisible = false;
  TextEditingController bookNameController = new TextEditingController();
  TextEditingController autharNameController = new TextEditingController();
  TextEditingController mrpController = new TextEditingController();
  TextEditingController discPriceController = new TextEditingController();
  TextEditingController bookPageControlller = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryValue = widget.categoryName;
    languageValue = widget.language;
    bookNameController.text = widget.bookName;
    autharNameController.text = widget.autherName;
    mrpController.text = widget.mrp;
    discPriceController.text = widget.discPrice;
    bookPageControlller.text = widget.bookPage;
    quantityController.text = widget.quantity;
  }

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
          child: Column(
            children: [
              //    Text(categoryValue),
              // Text(languageValue),
              Text(
                "Edit Product",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: userCollection.snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          List<DropdownMenuItem> dropdown = [];
                          if (streamSnapshot.hasData) {
                            for (int i = 0;
                                i < streamSnapshot.data!.docs.length;
                                i++) {
                              DocumentSnapshot docSnap =
                                  streamSnapshot.data!.docs[i];
                              dropdown.add(DropdownMenuItem(
                                value: "${docSnap.id}",
                                child: Text(docSnap.id),
                              ));
                            }
                          }
                          return GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                msg: 'You Can not Change Category Name',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                backgroundColor: Colors.blueGrey,
                                fontSize: 16,
                              );
                            },
                            child: Container
                              (decoration: BoxDecoration(border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30)
                            ),
                              width: double.infinity,
                              child: IgnorePointer(
                                ignoring: true,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton(

                                    hint: Text(
                                        'Choose Category                                      '),
                                    items: dropdown,

                                    // Step 5.
                                    onChanged: null,
                                    value: categoryValue.isNotEmpty
                                        ? categoryValue
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      controller: bookNameController,
                      //  controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: 'Book Name',
                          hintText: 'Enter Book Name'),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Book Name';
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
                        await getImageFromGallery();
                      },
                      child: Expanded(
                        child: Container(
                          width: double.infinity,
                          //height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.03,
                                MediaQuery.of(context).size.height * 0.015,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.015),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  //color: Colors.black,
                                  child: Text(
                                    fileName,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isvisible = !isvisible;
                                      });
                                    },
                                    child: isvisible
                                        ? Icon(
                                            Icons.visibility,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                          ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    isvisible == true
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).size.height * 0.02,
                              0,
                              MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: fileName == 'Select File'
                                    ? Image.network(
                                        widget.image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        new File(_image!.path),
                                        fit: BoxFit.fill,
                                      )),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                    TextFormField(
                      controller: autharNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: 'Auther',
                          hintText: 'Enter Auther Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Auther Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      controller: mrpController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: 'MRP',
                          hintText: 'Enter MRP'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter MRP';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      controller: discPriceController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: 'Discounted Price',
                          hintText: 'Enter Discounted Price'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Discountedp Price';
                        }
                        else if(int.parse(mrpController.text)<int.parse(value)){
                          return 'Discounted Price is not more than MRP';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      controller: bookPageControlller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: 'Book Pages',
                          hintText: 'Enter Book Pages'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Book Pages';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      controller: quantityController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: 'Quantity',
                          hintText: 'Enter Quantity'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Quantity';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black)
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value:
                              languageValue.isEmpty ? language[0] : languageValue,
                          hint: Text(
                              'Select Language                                      '),

                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              languageValue = value!;
                            });
                          },
                          items: language
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
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
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  loading = true;
                                });
                                await editData();
                                setState(() {
                                  loading = false;
                                });
                              }

                            },
                            child: loading == true
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Update",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  editData() async {
    if (bookNameController.text != widget.bookName) {
      final storageref = await FirebaseStorage.instance;
      final islandRef = await storageref
          .ref('BookImage/' + widget.categoryName + '/' + widget.bookName);

      final appDocDir = (await getApplicationDocumentsDirectory());
      final filePath = "${appDocDir.path}/images.jpg";
      final file = File(await filePath);
      await islandRef.writeToFile(file);

      await storageref
          .ref('BookImage/' +
              widget.categoryName +
              '/' +
              bookNameController.text.toString())
          .putFile(file);
      await storageref
          .ref('BookImage/' + widget.categoryName + '/' + widget.bookName)
          .delete();

      var url = await storageref
          .ref('BookImage/' +
              widget.categoryName +
              '/' +
              bookNameController.text.toString())
          .getDownloadURL();

      await userCollection
          .doc(widget.categoryName)
          .collection(widget.categoryName)
          .doc(widget.id)
          .update({'Image URL': url.toString()});
    }

    final docref = userCollection
        .doc(categoryValue)
        .collection(categoryValue)
        .doc(widget.id);
    await docref.update({
      "Book Name": bookNameController.text.toString(),
      "Authar Name": autharNameController.text.toString(),
      "MRP": mrpController.text.toString(),
      "Discounted Price": discPriceController.text.toString(),
      "Book Pages": bookPageControlller.text.toString(),
      "Language": languageValue.isEmpty ? language[0] : languageValue,
      "Updated Date": DateTime.now(),
      "Quantity": quantityController.text.toString(),
    }).then((e) {
      Fluttertoast.showToast(
        msg: 'Book Added Successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        fontSize: 16,
      );
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: "Book Adding Unsuccessful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        fontSize: 16,
      );
    });

    fileName != 'Select File' ? await uploadImage(widget.id) : null;
  }

  uploadImage(String id) async {
    final saveImageCollection =
        userCollection.doc(categoryValue).collection(categoryValue);

    final storageref = FirebaseStorage.instance;
    UploadTask uploadTask = storageref
        .ref('BookImage/' +
            categoryValue +
            '/' +
            bookNameController.text.toString())
        .putFile(_image!.absolute);

    await Future.value(uploadTask).then((value) async {
      var url = await storageref
          .ref('BookImage/' +
              categoryValue +
              '/' +
              bookNameController.text.toString())
          .getDownloadURL();

      await saveImageCollection
          .doc(id)
          .update({'Image URL': url.toString()}).then((e) {
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
          msg: saveImageCollection.doc().id,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
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
}
