import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:we_trade/bloc/report_bloc.dart';

class ReportScreen extends StatefulWidget {
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
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              children: <Widget>[
                Icon(
                  Icons.broken_image,
                  size: 100.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tên Sản Phẩm',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'tên người bán',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.edit_location),
                        Text(
                          'Nơi bán',
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                        )
                      ],
                    )
                  ],
                )
              ]
          ),
          SizedBox(height: 10.0),
          Text(
            'Lý do:',
            style: TextStyle(
                fontSize: 22.0
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
          ),
          TextField(
            enabled: reportBloc.unlockTextField? true: false,
            obscureText: true,
            decoration: InputDecoration(
              filled: reportBloc.unlockTextField? false: true,
              fillColor: Colors.grey,
              border: OutlineInputBorder(),
            ),
          ),
          Row(
              children: <Widget>[
                IconButton(
                    icon: reportBloc.confirmed? Icon(Icons.check_box):Icon(Icons.crop_square),
                    onPressed: (){
                      reportBloc.ChangeStateConfirmed();
                    }
                ),
                Text(
                  'Tôi chắc chắn muốn báo cáo sản phẩm này',
                  style: TextStyle(
                      fontSize: 14.0
                  ),
                )
              ]
          ),
          Center(
            child: RaisedButton(
                onPressed: (){},
                color: reportBloc.confirmed? Colors.lightBlue: Colors.grey,
                child: Text('Báo cáo')
            ),
          )
        ],
      ),
    );
  }
}
