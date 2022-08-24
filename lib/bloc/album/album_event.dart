part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbums extends AlbumEvent {
  final List<Album> albums;
  const LoadAlbums({this.albums = const <Album>[]});
  @override
  List<Object> get props => [albums];
}

class ReLoadAlbums extends AlbumEvent {
  final List<Album> albums;
  const ReLoadAlbums({this.albums = const <Album>[]});
  @override
  List<Object> get props => [albums];
}
