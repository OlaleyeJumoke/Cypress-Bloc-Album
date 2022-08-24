import 'package:bloc/bloc.dart';
import 'package:cypress_assessment/bloc/album/album_bloc.dart';
import 'package:cypress_assessment/model/album_model.dart';
import 'package:cypress_assessment/model/photo_model.dart';
import 'package:equatable/equatable.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoService _photoService;
  final AlbumBloc _albumBloc;

  PhotoBloc(this._photoService, {required AlbumBloc albumBloc})
      : _albumBloc = albumBloc,
        super(PhotoLoading()) {
    //on<LoadPhoto>(_onLoadPhotos);
    // on<TakePhotoId>(_onTakePhotoId);

    on<LoadPhotoAlbums>(_onLoadAlbums);
  }

  // List<Album> albumList = [];

//   void _onLoadPhotos(LoadPhoto event, Emitter<PhotoState> emit) async {
//   final state = _albumBloc;
//     if (state is AlbumLoaded) {
//       emit(PhotoLoading());
//       state.state.props.map((e) => null);
//       //print(state.))

// final data = await _photoService.photoApiService()
//       state.emit(AlbumLoaded(albums: data));

//       ;
//       //emit(PhotoLoaded(photos: data));
//     }
//   }

  // void _onTakePhotoId(TakePhotoId event, Emitter<PhotoState> emit) async {
  //   //final state = _albumBloc;
  //   if (state is AlbumLoaded) {
  //     emit(PhotoLoading());
  //     try {
  //       final data = await _photoService.photoApiService(event.photoId!);
  //       emit(PhotoLoaded(photos: data));
  //     } catch (e) {
  //       print(e);
  //     }
  //     //
  //   }
  // }

  void _onLoadAlbums(LoadPhotoAlbums event, Emitter<PhotoState> emit) async {
    print("got here");
    final state = _albumBloc;
    var data = event.albums;
    List<Photo> photos = [];
    // var photoData;
    emit(PhotoLoading());

    for (var e in data) {
      final photoData = await _photoService.photoApiService(e.userId!);

      if (photoData.isNotEmpty) {
        var albumData =
            data.firstWhere((element) => element.userId == e.userId);
        albumData.photos = photoData.take(5).toList();
        photos = photoData.take(5).toList();
      }
    }
   
    emit(PhotoLoaded(photos: photos));

    state.emit(AlbumLoaded(albums: data));
  }
}
