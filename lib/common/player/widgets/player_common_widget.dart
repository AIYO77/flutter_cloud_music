import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:music_player/music_player.dart';

class PlayingIndicator extends StatefulWidget {
  const PlayingIndicator(
      {Key? key, required this.playing, required this.pausing, this.buffering})
      : super(key: key);

  ///show when player is playing
  final Widget playing;

  ///show when player is pausing
  final Widget pausing;

  ///show when player is buffering
  final Widget? buffering;

  @override
  _PlayingIndicatorState createState() => _PlayingIndicatorState();
}

class _PlayingIndicatorState extends State<PlayingIndicator> {
  ///delay 200ms to change current state
  static const _durationDelay = Duration(milliseconds: 200);

  // static const _indexBuffering = 2;
  static const _indexPlaying = 1;
  static const _indexPausing = 0;

  int _index = _indexPausing;

  final _changeStateOperations = <CancelableOperation>[];

  late MusicPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = context.player..addListener(_onMusicStateChanged);
    _index = _playerState;
  }

  ///get current player state index
  int get _playerState =>
      // _player.playbackState.isBuffering
      //     ? _indexBuffering
      //     :
      _player.playbackState.isPlaying ? _indexPlaying : _indexPausing;

  void _onMusicStateChanged() {
    final target = _playerState;
    if (target == _index) return;

    final action =
        CancelableOperation.fromFuture(Future.delayed(_durationDelay));
    _changeStateOperations.add(action);
    action.value.whenComplete(() {
      if (target == _playerState) _changeState(target);
      _changeStateOperations.remove(action);
    });
  }

  void _changeState(int state) {
    if (!mounted) {
      return;
    }
    setState(() {
      _index = state;
    });
  }

  @override
  void dispose() {
    _player.removeListener(_onMusicStateChanged);
    for (final o in _changeStateOperations) {
      o.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      alignment: Alignment.center,
      children: <Widget>[widget.pausing, widget.playing],
    );
  }
}
