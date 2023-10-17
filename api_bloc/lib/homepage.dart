import 'package:api_bloc/logic/cubits/post_cubits/post_cubit.dart';
import 'package:api_bloc/logic/cubits/post_cubits/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PostCubit,PostState>(
builder: (context, state) {

  if(state is PostLoadingState){
    return Center(
        child: CircularProgressIndicator(),
    );
  }
  if(state is PostLoadedState){
    return ListView.builder(
      physics: BouncingScrollPhysics(),
        itemCount: state.posts.length,
        itemBuilder: (context, index) {

                return ListTile(
                  title:  Text(state.posts[index].title.toString()),
subtitle: Text(state.posts[index].body.toString()),
                );
    },

    );
  }
  return Center(
    child: Text("An Error Occured"),
  );
},
        ),
      ),
    );
  }
}
