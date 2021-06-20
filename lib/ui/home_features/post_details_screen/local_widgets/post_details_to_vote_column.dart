import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostDetailsToVoteColumn extends StatefulWidget {
  const PostDetailsToVoteColumn({
    Key? key,
    required this.vote,
    this.isUserUpVoted = false,
    this.isUserDownVoted = false,
  }) : super(key: key);

  final int vote;
  final bool isUserUpVoted, isUserDownVoted;

  @override
  _PostDetailsToVoteColumnState createState() => _PostDetailsToVoteColumnState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('vote', vote));
    properties.add(DiagnosticsProperty<bool>('isUserUpVoted', isUserUpVoted));
    properties
        .add(DiagnosticsProperty<bool>('isUserDownVoted', isUserDownVoted));
  }
}

class _PostDetailsToVoteColumnState extends State<PostDetailsToVoteColumn> {
  late int _voteNumber;
  late List<bool> _upVoteSelections, _downVoteSelections;

  @override
  void initState() {
    super.initState();
    _voteNumber = widget.vote;
    _upVoteSelections = [widget.isUserUpVoted];
    _downVoteSelections = [widget.isUserUpVoted];
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ToggleButtons(
          isSelected: _upVoteSelections,
          // onPressed: (index) => setVoteValue(
          //     index: index, selection: _upVoteSelections, isUpVote: true),
          onPressed: (index) {
            setState(() {
              _upVoteSelections[index] = !_upVoteSelections[index];
              if (_upVoteSelections[index] && _downVoteSelections[index]) {
                _downVoteSelections[index] = false;
                _voteNumber++;
              }
              _voteNumber =
                  _upVoteSelections[index] ? ++_voteNumber : --_voteNumber;
            });
          },
          selectedColor: Theme.of(context).primaryColor,
          color: const Color(0xFFBFC1C7),
          fillColor: Colors.white,
          highlightColor: const Color(0xFFFFD9E0),
          splashColor: Theme.of(context).primaryColor,
          renderBorder: false,
          children: const [
            Icon(EvaIcons.arrowUpOutline),
          ],
        ),
        Column(
          children: [
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                '$_voteNumber',
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const FittedBox(
              fit: BoxFit.fitHeight,
              child: Text('Votes'),
            ),
          ],
        ),
        ToggleButtons(
          isSelected: _downVoteSelections,
          // onPressed: (index) => setVoteValue(
          //     index: index, selection: _downVoteSelections, isUpVote: false),
          onPressed: (index) {
            setState(() {
              _downVoteSelections[index] = !_downVoteSelections[index];
              if (_upVoteSelections[index] && _downVoteSelections[index]) {
                _upVoteSelections[index] = false;
                _voteNumber--;
              }
              _voteNumber =
                  _downVoteSelections[index] ? --_voteNumber : ++_voteNumber;
            });
          },
          selectedColor: Theme.of(context).primaryColor,
          color: const Color(0xFFBFC1C7),
          fillColor: Colors.white,
          highlightColor: const Color(0xFFFFD9E0),
          splashColor: Theme.of(context).primaryColor,
          renderBorder: false,
          children: const [
            Icon(EvaIcons.arrowDownOutline),
          ],
        ),
      ],
    );
  }
}
