import 'dart:async';
import 'package:better_video_player/better_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_class_parikshit/models/video.dart';

class ListVideoPlayer extends StatefulWidget {
  const ListVideoPlayer({Key? key, this.videos}) : super(key: key);
  final List<Video>? videos;
  @override
  _ListVideoPlayerState createState() => _ListVideoPlayerState();
}

class _ListVideoPlayerState extends State<ListVideoPlayer> {
  int _playingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ItemWidget(
                index: index,
                playingIndex: _playingIndex,
                onPlayButtonPressed: () {
                  setState(() {
                    _playingIndex = index;
                  });
                },
              );
            },
            childCount: widget.videos!.length,
          ),
        ),
      ],
    );
  }
}

class ItemWidget extends StatefulWidget {
  final int playingIndex;

  final int index;

  final VoidCallback onPlayButtonPressed;

  final Video? video;

  const ItemWidget(
      {Key? key,
      this.video,
      required this.playingIndex,
      required this.index,
      required this.onPlayButtonPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ItemWidgetState();
  }
}

class ItemWidgetState extends State<ItemWidget>
    with AutomaticKeepAliveClientMixin {
  BetterVideoPlayerController playerController = BetterVideoPlayerController();

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.playingIndex == oldWidget.index &&
        widget.playingIndex != widget.index) {
      final oldPlayerController = playerController;
      Future.delayed(const Duration(milliseconds: 500), () {
        oldPlayerController.dispose();
      });
      playerController = BetterVideoPlayerController();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.playingIndex != widget.index)
              Image.network(widget.video!.coverPicture!, fit: BoxFit.contain),
            // play button
            if (widget.playingIndex != widget.index)
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    constraints:
                        const BoxConstraints.tightFor(width: 60, height: 60),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black26,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  onPressed: widget.onPlayButtonPressed,
                ),
              ),
            // video player
            if (widget.playingIndex == widget.index)
              BetterVideoPlayer(
                controller: playerController,
                dataSource: BetterVideoPlayerDataSource(
                  BetterVideoPlayerDataSourceType.network,
                  widget.video!.videoUrl!,
                ),
                configuration: BetterVideoPlayerConfiguration(
                  placeholder: Image.network(widget.video!.coverPicture!,
                      fit: BoxFit.contain),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.playingIndex == widget.index;
}
