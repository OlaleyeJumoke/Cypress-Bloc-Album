part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
  
  @override
  List<Object> get props => [];
}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;
  const PhotoLoaded({this.photos = const <Photo>[]});

  @override
  List<Object> get props => [photos];
}
