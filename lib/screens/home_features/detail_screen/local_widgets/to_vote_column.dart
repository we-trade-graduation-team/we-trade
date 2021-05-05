import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';

class ToVoteColumn extends StatefulWidget {
  const ToVoteColumn({
    Key? key,
    required this.vote,
    this.isUserUpVoted = false,
    this.isUserDownVoted = false,
  }) : super(key: key);

  final int vote;
  final bool isUserUpVoted, isUserDownVoted;

  @override
  _ToVoteColumnState createState() => _ToVoteColumnState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('vote', vote));
    properties.add(DiagnosticsProperty<bool>('isUserUpVoted', isUserUpVoted));
    properties
        .add(DiagnosticsProperty<bool>('isUserDownVoted', isUserDownVoted));
  }
}

class _ToVoteColumnState extends State<ToVoteColumn> {
  late int voteNumber;
  late List<bool> _upVoteSelections, _downVoteSelections;

  @override
  void initState() {
    super.initState();
    voteNumber = widget.vote;
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
                voteNumber++;
              }
              voteNumber =
                  _upVoteSelections[index] ? ++voteNumber : --voteNumber;
            });
          },
          selectedColor: kPrimaryColor,
          color: const Color(0xFFBFC1C7),
          fillColor: Colors.white,
          highlightColor: const Color(0xFFFFD9E0),
          splashColor: kPrimaryColor,
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
                '$voteNumber',
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
                voteNumber--;
              }
              voteNumber =
                  _downVoteSelections[index] ? --voteNumber : ++voteNumber;
            });
          },
          selectedColor: kPrimaryColor,
          color: const Color(0xFFBFC1C7),
          fillColor: Colors.white,
          highlightColor: const Color(0xFFFFD9E0),
          splashColor: kPrimaryColor,
          renderBorder: false,
          children: const [
            Icon(EvaIcons.arrowDownOutline),
          ],
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('vote', widget.vote));
    properties
        .add(DiagnosticsProperty<bool>('isUserUpVoted', widget.isUserUpVoted));
    properties.add(
        DiagnosticsProperty<bool?>('isUserDownVoted', widget.isUserDownVoted));
    properties.add(IntProperty('voteNumber', voteNumber));
    properties.add(
        IterableProperty<bool>('_downVoteSelections', _downVoteSelections));
    properties
        .add(IterableProperty<bool>('_upVoteSelections', _upVoteSelections));
  }
}
