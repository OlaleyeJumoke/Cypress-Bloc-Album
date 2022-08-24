part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}
class LoadPhoto extends PhotoEvent {
  final List<Photo> photos;
  const LoadPhoto({this.photos = const <Photo>[]});
  @override
  List<Object> get props => [photos];
}
class LoadPhotoAlbums extends PhotoEvent {
  final List<Album> albums;
  const LoadPhotoAlbums({this.albums = const <Album>[]});
  @override
  List<Object> get props => [albums];
}

class TakePhotoId extends PhotoEvent {
  final int? photoId;
  const TakePhotoId({this.photoId });

}

