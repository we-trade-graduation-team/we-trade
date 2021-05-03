import 'package:flutter/material.dart';
import '../../configs/constants/color.dart';

enum HidePostReasonValue {
  // ignore: constant_identifier_names
  StopTrading,
  // ignore: constant_identifier_names
  TradedViaWeTrade,
  // ignore: constant_identifier_names
  TradeViaOtherChannel,
}

class Reason {
  String title;
  HidePostReasonValue value;
  // ignore: sort_constructors_first
  Reason({
    required this.title,
    required this.value,
  });
  static List<Reason> getReasons() {
    return <Reason>[
      Reason(
          title: 'Tôi không muốn bán nữa.',
          value: HidePostReasonValue.StopTrading),
      Reason(
          title: 'Đã bán qua WeTrade.',
          value: HidePostReasonValue.TradedViaWeTrade),
      Reason(
          title: 'Đã bán qua kênh khác.',
          value: HidePostReasonValue.TradeViaOtherChannel),
    ];
  }
}

// ignore: use_key_in_widget_constructors
class HidePostScreen extends StatefulWidget {
  static const routeName = '/hidepost';

  @override
  _HidePostScreenState createState() => _HidePostScreenState();
}

class _HidePostScreenState extends State<HidePostScreen> {
  // ignore: diagnostic_describe_all_properties
  List<Reason> reasons = [];
  // ignore: diagnostic_describe_all_properties
  Reason selectedReason =
      Reason(title: 'title', value: HidePostReasonValue.StopTrading);

  @override
  void initState() {
    super.initState();
    reasons = Reason.getReasons();
  }

  void setSelectedReason(Reason reason) {
    setState(() {
      selectedReason = reason;
    });
  }

  List<Widget> buildRadioReasonList() {
    final widgets = <Widget>[];
    for (final reason in reasons) {
      widgets.add(
        RadioListTile(
          title: Text(reason.title),
          value: reason,
          groupValue: selectedReason,
          // ignore: avoid_types_on_closure_parameters
          onChanged: (Reason? currentReason) {
            setState(() {
              // print(currentReason!.title);
              setSelectedReason(currentReason!);
            });
          },
          selected: selectedReason == reason,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ẩn tin'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 29),
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Vui lòng chọn lí do ẩn tin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...buildRadioReasonList(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text('Ẩn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
