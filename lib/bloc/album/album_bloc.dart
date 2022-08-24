import 'package:bloc/bloc.dart';
import 'package:cypress_assessment/model/album_model.dart';
import 'package:equatable/equatable.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumService _albumService;
  AlbumBloc(this._albumService) : super(AlbumLoading()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<ReLoadAlbums>(_onReLoadAlbums);
  
  }

  void _onLoadAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    final data = await _albumService.albumApiService();
    emit(AlbumLoaded(albums: data));
  }

  void _onReLoadAlbums(ReLoadAlbums event, Emitter<AlbumState> emit) async {
   
    var data = await _albumService.albumApiService();
    
    emit(AlbumLoaded(albums: data += data));
  }
}
