import 'package:flutter/material.dart';
import 'package:we_trade/configs/constants/color.dart';

enum HidePostReasonValue {
  StopTrading,
  TradedViaWeTrade,
  TradeViaOtherChannel,
}

class Reason {
  String title;
  HidePostReasonValue value;
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

class HidePostScreen extends StatefulWidget {
  static const routeName = '/hidepost';

  @override
  _HidePostScreenState createState() => _HidePostScreenState();
}

class _HidePostScreenState extends State<HidePostScreen> {
  List<Reason> reasons = [];
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
    List<Widget> widgets = [];
    for (Reason reason in reasons) {
      widgets.add(
        RadioListTile(
          title: Text(reason.title),
          value: reason,
          groupValue: selectedReason,
          onChanged: (Reason? currentReason) {
            setState(() {
              print(currentReason!.title);
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
