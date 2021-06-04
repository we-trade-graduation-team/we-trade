import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum HidePostReasonValue {
  stopTrading,
  tradedViaWeTrade,
  tradeViaOtherChannel,
}

class Reason {
  Reason({
    required this.title,
    required this.value,
  });

  String title;
  HidePostReasonValue value;

  static List<Reason> getReasons() {
    return <Reason>[
      Reason(
          title: 'Tôi không muốn bán nữa.',
          value: HidePostReasonValue.stopTrading),
      Reason(
          title: 'Đã bán qua WeTrade.',
          value: HidePostReasonValue.tradedViaWeTrade),
      Reason(
          title: 'Đã bán qua kênh khác.',
          value: HidePostReasonValue.tradeViaOtherChannel),
    ];
  }
}

class HidePostScreen extends StatefulWidget {
  const HidePostScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HidePostScreenState createState() => _HidePostScreenState();
}

class _HidePostScreenState extends State<HidePostScreen> {
  // List<Reason> reasons = [];

  Reason _selectedReason = Reason(
    title: 'title',
    value: HidePostReasonValue.stopTrading,
  );

  @override
  void initState() {
    super.initState();
  }

  void setSelectedReason(Reason reason) {
    setState(() {
      _selectedReason = reason;
    });
  }

  List<Widget> buildRadioReasonList() {
    final reasons = Reason.getReasons();
    return reasons.map((reason) {
      return RadioListTile(
        title: Text(reason.title),
        value: reason,
        groupValue: _selectedReason,
        onChanged: (currentReason) {
          setState(() {
            // print(currentReason!.title);
            setSelectedReason(currentReason as Reason);
          });
        },
        selected: _selectedReason == reason,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ẩn tin'),
      ),
      body: Column(
        children: [
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
                // ? Should be delete?
                // style: ElevatedButton.styleFrom(
                //   primary: Theme.of(context).primaryColor,
                // ),
                child: const Text('Ẩn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
