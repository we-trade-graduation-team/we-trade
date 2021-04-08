import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:group_button/group_button.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../../bloc/report_bloc.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}):super(key: key);
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> lyDo = ['Hàng Giả', 'Hàng không đúng với miêu tả',
    'Không giao hàng', 'Sản phẩm kém chất lượng','Khác'];

  @override
  Widget build(BuildContext context) {
    final ReportBloc reportBloc = Provider.of<ReportBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              children: <Widget>[
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Text(
                      'tên người bán',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Icon(Icons.edit_location),
                        const Text(
                          'Nơi bán',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        )
                      ],
                    )
                  ],
                )
              ]
          ),
          const SizedBox(height: 10),
          const Text(
            'Lý do:',
            style: TextStyle(
                fontSize: 22
            ),
          ),
          GroupButton(
            isRadio: false,
            spacing: 10,
            onSelected: (index, isSelected) {
              if(lyDo[index]=='Khác'){
                reportBloc.ChangeStateTextField();
              }
            },
            buttons: lyDo,
            selectedColor: const Color(0xFF6F35A5),
          ),
          TextField(
            // ignore: avoid_bool_literals_in_conditional_expressions
            enabled: reportBloc.unlockTextField? true: false,
            obscureText: true,
            decoration: InputDecoration(
              // ignore: avoid_bool_literals_in_conditional_expressions
              filled: reportBloc.unlockTextField? false: true,
              fillColor: Colors.grey,
              border: const OutlineInputBorder(),
            ),
          ),
          Row(
              children: <Widget>[
                IconButton(
                    icon: reportBloc.confirmed? const Icon(Icons.check_box):const Icon(Icons.crop_square),
                    onPressed: reportBloc.ChangeStateConfirmed
                ),
                const Text(
                  'Tôi chắc chắn muốn báo cáo sản phẩm này',
                  style: TextStyle(
                      fontSize: 14
                  ),
                )
              ]
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: (){},
                style: ButtonStyle(
                    backgroundColor: reportBloc.confirmed?
                              MaterialStateProperty.all<Color>(const Color(0xFF6F35A5)):
                              MaterialStateProperty.all<Color>(Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                        )
                    )
                ),


                child:  const Padding(
                  padding: EdgeInsets.fromLTRB(10,2,10,2),
                  child: Text(
                    'Báo cáo',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                    ),
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('lyDo', lyDo));
  }
}
