import 'dart:developer';

import 'package:api_bloc/api/api.dart';
import 'package:api_bloc/models/PostModel.dart';
import 'package:dio/dio.dart';

class PostRepository{
      API api = API();

  Future<List<PostModel>?> fetchPost()async{
    try{
    Response response = await api.dios.get("/posts");
List postMaps=response.data;
return  postMaps.map((e) => PostModel.fromJson(e)).toList();
    // log(response.data);
    }
        catch(e){
      return null;
        }
  }
}