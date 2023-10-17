import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_app/screens/admin/showProductDetail.dart';
import 'package:google_fonts/google_fonts.dart';
class ShowProduct extends StatefulWidget {
  const ShowProduct({Key? key}) : super(key: key);

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  bool dataText=false;
  final searchController = TextEditingController();
  final userCollection = FirebaseFirestore.instance.collection("category");
  List categoryList=[];
  List searchlist=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar( backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/spl2.png",
                width: MediaQuery.of(context).size.width*0.1),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Text("CATEGORY",
              style: TextStyle(
                  fontSize: 20
              ),)

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val){
                  setState(() {
                    searchField(val);
                  });

                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Book',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(stream: userCollection.snapshots(),
                builder: (context, snapshot) {

                  if(snapshot.connectionState==ConnectionState.active){
                    if(snapshot.hasData){
                      categoryList.clear();
                      for(int i=0; i<snapshot.data!.docs.length;i++){
                        categoryList.add(snapshot.data!.docs[i]);
                      }
                      print(categoryList[0]['Image URL']);
                      print(categoryList[0].id);
                      print(categoryList.length);
                      return   Container(

                        height: MediaQuery.of(context).size.height*0.72,
                        child: GridView.builder(
                            padding: EdgeInsets.fromLTRB(MediaQuery
                                .of(context)
                                .size
                                .width * 0.05,
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02 ,
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.05,
                                0),
                            // physics: ScrollPhysics(),
                            physics: BouncingScrollPhysics(),
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: searchController.text.isEmpty? categoryList.length:searchlist.length,

                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: MediaQuery
                                    .of(context)
                                    .size
                                    .width /
                                    (MediaQuery
                                        .of(context)
                                        .size
                                        .height*0.9),
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 10.0
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot? docSnap = snapshot.data!.docs[index];

                              return InkWell(onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ShowProductDetail(searchController.text.isEmpty? categoryList[index].id:searchlist[index].id)));
                              },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                      border: Border.all(color: Colors.black)

                                  ),
                                  child: Column(
                                    children: [

                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: Container(width: double.infinity  ,
                                              height: MediaQuery.of(context).size.height*0.29,

                                              child: Image.network(searchController.text.isEmpty? categoryList[index]['Image URL']:
                                              searchlist[index]['Image URL'],
                                                fit: BoxFit.fill,))
                                      ),

                                      SizedBox(height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.01,),
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.08,

                                        child: Center(

                                            child: Text(searchController.text.isEmpty?categoryList[index].id:searchlist[index].id,

                                              style: GoogleFonts.lato(fontSize: 17,
                                                  fontWeight: FontWeight.w900),)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ) ;
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text("An Error Occured"));
                    }
                    else {
                      return Center(
                        child: Text("No Books!!"),
                      );}
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                }
            )
          ],
        ),
      ),
    );
  }

  void searchField( String value) {
    searchlist.clear();
    searchlist.addAll(categoryList.where((element) =>
        element.id.toLowerCase().contains(value.toLowerCase())));
    print("fir"+searchlist.length.toString());
    // searchlist.addAll(categoryList.where((element) =>
    //     element.id.toLowerCase().contains(value.toLowerCase())));
    print("sec"+searchlist.length.toString());
    if (value.isNotEmpty && searchlist.isEmpty) {
      dataText = true;

      setState(() {});

      setState(() {});
    } else {
      dataText = false;

      setState(() {});
    }

    print(searchlist);
  }
}
