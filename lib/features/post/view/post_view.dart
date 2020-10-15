import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mvvmmobx/features/post/viewModel/post_view_model.dart';

class PostView extends StatelessWidget {
  final _viewModel = PostViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.getAllPosts2();
        },
      ),
      body: Center(
        child: Observer(builder: (_) {
          switch (_viewModel.pageState) {
            case PageState.LOADING:
              return CircularProgressIndicator();
            case PageState.SUCCESS:
              return buildListViewPosts();
            case PageState.ERROR:
              return Center(child: Text("Error"),);
            default:
              return FlutterLogo();
          }
        }),
      ),
    );
  }

  ListView buildListViewPosts() {
    return ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.black,),
          itemCount: _viewModel.posts.length,
          itemBuilder: (context, index) => buildListTileCard(index),
        );
  }

  ListTile buildListTileCard(int index) {
    return ListTile(
            title: Text(_viewModel.posts[index].title),
            subtitle: Text(_viewModel.posts[index].body),
            trailing: Text(_viewModel.posts[index].userId.toString()),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Burak"),
      leading: Observer(builder: (_) {
        return Visibility(
          visible: _viewModel.isServiceRequestLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
