import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../bloc/report_bloc.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> lyDo = [
    'Hàng Giả',
    'Hàng không đúng với miêu tả',
    'Không giao hàng',
    'Sản phẩm kém chất lượng',
    'Khác'
  ];

  @override
  Widget build(BuildContext context) {
    final reportBloc = Provider.of<ReportBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('We Trade'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      const Icon(
                        Icons.broken_image,
                        size: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Tên Sản Phẩm',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'tên người bán',
                            style: TextStyle(fontSize: 18),
                          ),
                          Row(
                            children: const <Widget>[
                              Icon(Icons.edit_location),
                              Text(
                                'Nơi bán',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          )
                        ],
                      )
                    ]),
                    const SizedBox(height: 10),
                    const Text(
                      'Lý do:',
                      style: TextStyle(fontSize: 22),
                    ),
                    GroupButton(
                      isRadio: false,
                      spacing: 10,
                      onSelected: (index, isSelected) {
                        if (lyDo[index] == 'Khác') {
                          reportBloc.changeStateTextField();
                        }
                      },
                      buttons: lyDo,
                      selectedColor: const Color(0xFF6F35A5),
                    ),
                    TextField(
                      enabled: reportBloc.unlockTextField,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: !reportBloc.unlockTextField,
                        fillColor: Colors.grey,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    Row(children: <Widget>[
                      IconButton(
                          icon: reportBloc.confirmed
                              ? const Icon(Icons.check_box)
                              : const Icon(Icons.crop_square),
                          onPressed: reportBloc.changeStateConfirmed),
                      const Text(
                        'Tôi chắc chắn muốn báo cáo sản phẩm này',
                        style: TextStyle(fontSize: 14),
                      )
                    ]),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: reportBloc.confirmed
                              ? MaterialStateProperty.all<Color>(
                                  const Color(0xFF6F35A5))
                              : MaterialStateProperty.all<Color>(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.02,
                              size.height * 0.01,
                              size.width * 0.02,
                              size.height * 0.01),
                          child: const Text(
                            'Báo cáo',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      // bottomNavigationBar: const BuildBottomNavigationBar(
      //   selectedIndex: 0,
      // ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('lyDo', lyDo));
  }
}
