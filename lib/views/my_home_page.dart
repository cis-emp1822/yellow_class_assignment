import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_class_parikshit/cubits/playlist/playlists_cubit.dart';
import 'package:yellow_class_parikshit/views/list_video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<PlaylistsCubit>().fetchPlaylists(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Center(child: BlocBuilder<PlaylistsCubit, PlaylistsState>(
        builder: (context, state) {
          if (state is PlaylistsLoading) {
            return const CircularProgressIndicator();
          }
          if (state is PlaylistsError) {
            return Text(state.errorMessage!);
          }
          if (state is PlaylistsLoaded) {
            if (state.videos!.isEmpty) {
              return const Text("No videos available");
            }
            return ListVideoPlayer(
              videos: state.videos!,
            );
          }
          if (state is PlaylistsInitial) {
            return Container();
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
