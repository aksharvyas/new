import 'package:api_bloc/logic/cubits/post_cubits/post_state.dart';
import 'package:api_bloc/models/PostModel.dart';
import 'package:api_bloc/repository/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit <PostState>{
  PostCubit() : super( PostLoadingState()){
    fetchPosts();
  }
  PostRepository postRepository = PostRepository();
  void fetchPosts()async{
  try{

  List<PostModel>? posts= await postRepository.fetchPost();
  emit(PostLoadedState(posts!));
  }
  catch(e){
emit(PostErrorState(e.toString()));
  }
  }

}