import 'package:cypress_assessment/bloc/album/album_bloc.dart';
import 'package:cypress_assessment/bloc/photo/photo_bloc.dart';
import 'package:cypress_assessment/model/album_model.dart';
import 'package:cypress_assessment/model/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
          BlocProvider.of<AlbumBloc>(context).add(ReLoadAlbums());
        }
      }
    });
  }

  //var album;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (context) =>
          AlbumBloc(RepositoryProvider.of<AlbumService>(context))
            ..add(LoadAlbums()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Cypress Photo Album")),
        body: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            return ListView.builder(
                itemCount: state.albums.length,
                controller: _controller,
                itemBuilder: ((context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.albums[index].title!),
                      SizedBox(
                        height: 8,
                      ),
                      ImageRow(albums: state.albums, index: index),
                      const Divider(),
                    ],
                  );
                }));
          } else {
            return Text("Something went wrong");
          }
        }),
      ),
    );
  }
}

class ImageRow extends StatefulWidget {
  final List<Album> albums;
  final int index;
  ImageRow({Key? key, required this.albums, required this.index})
      : super(key: key);

  @override
  State<ImageRow> createState() => _ImageRowState();
}

class _ImageRowState extends State<ImageRow> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
        create: (BuildContext context) => PhotoBloc(
            RepositoryProvider.of<PhotoService>(context),
            albumBloc: AlbumBloc(RepositoryProvider.of<AlbumService>(context)))
          ..add(LoadPhotoAlbums(albums: widget.albums)),
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: ((context, state) {
            if (state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoLoaded) {
              return Container(
                height: 150,
                child: ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.albums[widget.index].photos.length,
                    itemBuilder: (context, index1) {
                      return Image.network(
                          widget.albums[widget.index].photos[index1].url!);
                    }),
              );
            }
            return Container();
          }),
        ));
  }
}
