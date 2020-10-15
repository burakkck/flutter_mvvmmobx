import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:mvvmmobx/features/post/model/post.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  List<Post> posts = []; 

  @observable
  PageState pageState = PageState.NORMAL;

  final url = "https://jsonplaceholder.typicode.com/posts";

  @observable
  bool isServiceRequestLoading = false;

  @action
  Future<void> getAllPosts() async {
    changeRequest();
    final response = await Dio().get(url);

    if(response.statusCode == HttpStatus.ok){
      final responseData = response.data as List;
      posts = responseData.map((e) => Post.fromJson(e)).toList();
    }

    changeRequest();
  }

  @action
  Future<void> getAllPosts2() async {
    pageState = PageState.LOADING;
    final response = await Dio().get(url);

    if(response.statusCode == HttpStatus.ok){
      final responseData = response.data as List;
      posts = responseData.map((e) => Post.fromJson(e)).toList();

      pageState = PageState.SUCCESS;
    }else {
      pageState = PageState.ERROR;
    }

    
  }

  @action
  void changeRequest() {
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}

enum PageState {
  LOADING, ERROR, SUCCESS, NORMAL
}