import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

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

  static const routeName = '/hidepost';

  @override
  _HidePostScreenState createState() => _HidePostScreenState();
}

class _HidePostScreenState extends State<HidePostScreen> {
  List<Reason> reasons = [];

  Reason selectedReason =
      Reason(title: 'title', value: HidePostReasonValue.stopTrading);

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
          onChanged: (currentReason) {
            setState(() {
              // print(currentReason!.title);
              setSelectedReason(currentReason as Reason);
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Reason>('reasons', reasons));
    properties
        .add(DiagnosticsProperty<Reason>('selectedReason', selectedReason));
  }
}
