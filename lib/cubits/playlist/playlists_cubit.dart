import 'package:yellow_class_parikshit/models/video.dart';
import 'package:yellow_class_parikshit/repositories/apis_here.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
part 'playlists_state.dart';

class PlaylistsCubit extends Cubit<PlaylistsState> {
  PlaylistsCubit() : super(PlaylistsInitial());
  fetchPlaylists(BuildContext context,
      {Map<String, List<String>>? filters}) async {
    emit(PlaylistsLoading());
    Stream<List<Video>> videos =
        await ApisHere().getPlaylist(context, filters: filters);
    videos.listen((event) {
      emit(PlaylistsLoaded(videos: event));
    }, onError: (error) {
      emit(PlaylistsError(errorMessage: error.toString()));
    });
  }
}
