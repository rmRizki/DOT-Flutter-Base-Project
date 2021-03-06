import 'package:base_flutter/src/core/bloc/photo_bloc.dart';
import 'package:base_flutter/src/core/data/models/album.dart';
import 'package:base_flutter/src/ui/screens/home/widgets/item_album.dart';
import 'package:base_flutter/src/ui/shared/base_common_textinput.dart';
import 'package:base_flutter/src/ui/shared/my_app_toolbar.dart';
import 'package:base_flutter/src/ui/shared/base_gridview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPhoto extends StatelessWidget {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final PhotoBloc _bloc = Provider.of<PhotoBloc>(context, listen: false);
    _bloc.getAlbumList();
    return Scaffold(
      appBar: MyAppToolbar(title: 'Album'),
      body: BaseGridView<Album>(
        childAspectRatio: 1,
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        header: _searchBar(),
        padding: EdgeInsets.all(15.0),
        stream: _bloc.albumStream,
        onRefresh: () async => _bloc.getAlbumList(),
        loadMore: () async => _bloc.getAlbumList(init: false),
        itemBuilder: (context, state, data) {
          return ItemAlbum(data);
        },
      )
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: BaseCommonTextInput(
        textFieldController: _searchController,
        label: 'Search...',
      ),
    );
  }
}