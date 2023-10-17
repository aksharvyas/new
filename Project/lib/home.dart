import 'package:flutter/material.dart';
import 'package:project/sqflite_dir/databaseHandler.dart';
import 'package:project/sqflite_dir/user_model.dart';
import 'package:project/sqflite_dir/user_repo.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final categoryController = TextEditingController();
  List<Map<String, dynamic>>? userList;
  Database? _database;
  List<Map<String, dynamic>>?categoryList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFromUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            children: [
              Container(
                // color: Colors.blue,
                height: MediaQuery.of(context).size.height * 0.7,
                child: userList == null || userList!.isEmpty
                    ? Center(
                        child: Text("Loading.."),
                      )
                    : ListView.builder(
                        itemCount: userList!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child:
                                      Text(userList![index]['CATEGORYNAME'])),
                              InkWell(
                                onTap: () {
                          Navigator.pop(context);
                          categoryController.text=userList![index]['CATEGORYNAME'];
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                          return AlertDialog(
                          actions: [
                          Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                          children: [
                          Text(
                          "EDIT CATEGORY",
                          style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                          height: 20,
                          ),
                          TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Category Name',
                          hintText: 'Category Name',
                          ),
                          minLines: 1,
                          maxLines: 10,
                          ),
                          SizedBox(
                          height: 10,
                          ),
                          ElevatedButton(
                          onPressed: () {
                            update(userList![index]['id']);
                          getFromUser();
                          Navigator.pop(context);
                          },
                          child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          )),
                          ),
                          ],
                          ),
                          )
                          ],
                          );});
    },
                                child: Icon(Icons.edit, color: Colors.blue),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              InkWell(
                                onTap: () {

delete(userList![index]['id']);
getFromUser();
                               setState(() {

                               });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ]),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  categoryController.clear();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    "ADD CATEGORY",
                                    style:
                                    TextStyle(fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller:
                                    categoryController,
                                    decoration: InputDecoration(
                                      border:
                                      OutlineInputBorder(),
                                      labelText:
                                      'Enter Category Name',
                                      hintText: 'Category Name',
                                    ),
                                    minLines: 1,
                                    maxLines: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      insertDB();
                                      getFromUser();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 18),
                                    ),
                                    style: ElevatedButton
                                        .styleFrom(
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              30),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      });
                                          },


                child: SizedBox(
                  width: double.infinity,
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      "ADD CATEGORY",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Database?> openDB() async {
    _database = await DatabaseHandler().openDB();
    return _database;
  }

  Future<void> insertDB() async {
    _database = await openDB();

    UserRepo userRepo = new UserRepo();

    userRepo.createTable(_database);

    UserModel userModel = new UserModel(categoryController.text.toString());

    await _database?.insert('CATEGORYTABLE', userModel.toMap());
    await _database?.close();
  }

  Future<void> getFromUser() async {
    _database = await openDB();
    UserRepo usersRepo = new UserRepo();

    userList = await usersRepo.getUsers(_database);

    await _database?.close();
    try {
      for(int i=0; i<userList!.length; i++){
        categoryList!.add(userList![i]);
      }
      categoryList!.sort((a, b) => a['id'].compareTo(b['id']));
    }
    catch(e){
      print(e.toString());
    }
    setState(() {});
  }
  Future<void> update(int id)async{
    _database = await DatabaseHandler().openDB();
    UserModel userModel = new UserModel(categoryController.text.toString());
    await _database?.update("CATEGORYTABLE", userModel.toMap(),
        where: 'id=?',
        whereArgs: [id]);
    _database?.close();

  }
  Future<void> delete(int id)async{
  _database = await DatabaseHandler().openDB();
  await _database?.delete("CATEGORYTABLE",    where: 'id=?',
      whereArgs: [id]);
  _database?.close();
}
}
