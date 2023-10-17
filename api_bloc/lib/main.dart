import 'dart:math';

import 'package:api_bloc/logic/cubits/post_cubits/post_cubit.dart';
import 'package:api_bloc/models/PostModel.dart';
import 'package:api_bloc/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // PostRepository postRepository = PostRepository();
  // List<PostModel>? postmodels= await postRepository.fetchPost();
  // print(postmodels.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
