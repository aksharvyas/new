class UserModel{

  final String categoryName;



  UserModel(this.categoryName);

  Map<String, dynamic> toMap(){
  return {

    'CATEGORYNAME':categoryName,



  };
  }
}