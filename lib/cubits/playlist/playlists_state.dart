part of 'playlists_cubit.dart';

@immutable
abstract class PlaylistsState {}

class PlaylistsInitial extends PlaylistsState {}

class PlaylistsLoading extends PlaylistsState {}

class PlaylistsLoaded extends PlaylistsState {
  final List<Video>? videos;
  PlaylistsLoaded({this.videos});
}

class PlaylistsError extends PlaylistsState {
  final String? errorMessage;
  PlaylistsError({this.errorMessage});
}
