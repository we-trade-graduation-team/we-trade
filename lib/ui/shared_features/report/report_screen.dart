import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:group_button/group_button.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import '../../../bloc/report_bloc.dart';
import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../services/firestore/firestore_database.dart';
import 'local_widgets/pop_header.dart';

class ReportScreenBody extends StatelessWidget {
  ReportScreenBody({
    Key? key,
    required this.objectId,
  }) : super(key: key);
  final String objectId;

  final auth = FirebaseAuth.instance;
  Future<void> report(String objectId, String reason) {
    final user = auth.currentUser;
    final uid = user!.uid;
    return FirebaseFirestore.instance
        .collection('reports')
        .add(<String, dynamic>{
      'objectId': objectId,
      'reason': reason,
      'reporterId': uid,
      'type': 0
    });
    // .then((value) => print('User Added'));
  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    const alert = AlertDialog(
      title: Text('Đã báo cáo'),
      content:
          Text('Chúng tôi sẽ xem xét báo cáo và phản hồi bạn sớm nhất có thể.'),
    );

    // show the dialog
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lyDo = [
      'Hàng Giả',
      'Hàng không đúng với miêu tả',
      'Không giao hàng',
      'Sản phẩm kém chất lượng',
      'Khác'
    ];

    var reason = '';
    final textController = TextEditingController();

    final reportBloc = context.watch<ReportBloc>();

    final size = MediaQuery.of(context).size;

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FutureProvider<PostCard?>.value(
                  value: _firestoreDatabase.getPostCard(postId: objectId),
                  initialData: null,
                  catchError: (_, __) => null,
                  child: Consumer<PostCard?>(
                    builder: (_, postCard, __) {
                      if (postCard == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.height * 0.2,
                                    child: Image.network(
                                      postCard.item.image,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        postCard.title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                              postCard.item.district,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  const TextStyle(fontSize: 18),
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
                              reason += '${lyDo[index]}, ';
                              if (lyDo[index] == 'Khác') {
                                reportBloc.changeStateTextField();
                                reason += '${textController.text}, ';
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
                              fillColor: const Color(0xFFEFEFEF),
                              border: const OutlineInputBorder(),
                            ),
                            controller: textController,
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
                                onPressed: () {
                                  report(objectId, reason);
                                  showAlertDialog(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: reportBloc.confirmed
                                        ? MaterialStateProperty.all<Color>(
                                            const Color(0xFF6F35A5))
                                        : MaterialStateProperty.all<Color>(
                                            Colors.grey),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  child: Text(
                                    'Báo cáo',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('objectId', objectId));
    properties.add(DiagnosticsProperty<FirebaseAuth>('auth', auth));
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({
    Key? key,
    required this.objectId,
  }) : super(key: key);

  final String objectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
        child: const PopHeader(),
      ),
      body: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => ReportBloc())],
        child: ReportScreenBody(
          objectId: objectId,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('objectId', objectId));
  }
}
