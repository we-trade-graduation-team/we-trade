import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:group_button/group_button.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import '../../../bloc/report_bloc.dart';
import '../../../configs/constants/color.dart';
import '../../../models/shared_models/product_model.dart';
import 'local_widgets/pop_header.dart';

class ReportScreenBody extends StatefulWidget {
  const ReportScreenBody({Key? key}) : super(key: key);
  static String routeName = '/reportScreen';
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreenBody> {
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

    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                        child: Image.network(
                          demoProducts[0].images[0],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                      // width: size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            demoProducts[0].title,
                            maxLines: 2,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text(
                          //   demoProducts[0].ownerLocation,
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: const TextStyle(fontSize: 18),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.edit_location),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  demoProducts[0].ownerLocation,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  TextField(
                    enabled: reportBloc.unlockTextField,
                    maxLines: null,
                    decoration: InputDecoration(
                      filled: !reportBloc.unlockTextField,
                      fillColor: kBackGroundColor,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  Row(children: [
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
                    child: Card(
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: reportBloc.confirmed
                                ? MaterialStateProperty.all<Color>(
                                    const Color(0xFF6F35A5))
                                : MaterialStateProperty.all<Color>(Colors.grey),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ))),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: Text(
                            'Báo cáo',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('lyDo', lyDo));
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);
  static String routeName = '/reportScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
        child: const PopHeader(),
      ),
      body: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => ReportBloc())],
        child: const ReportScreenBody(),
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
