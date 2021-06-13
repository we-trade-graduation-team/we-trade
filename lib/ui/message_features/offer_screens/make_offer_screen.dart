import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/ui/shared_models/product_model.dart';
import '../../../widgets/custom_material_button.dart';
// import '../../../widgets/item_post_card.dart';

class MakeOfferScreen extends StatefulWidget {
  const MakeOfferScreen({Key? key}) : super(key: key);

  @override
  _MakeOfferScreenState createState() => _MakeOfferScreenState();
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  late bool _isHaveMoney = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAKE OFFER'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Các sản phẩm phù hợp',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            demoProducts.length,
                            (index) {
                              return Row(
                                children: [
                                  Stack(
                                    children: [
                                      // TODO: <Trang> Replace Product with PostCard
                                      // ItemPostCard(postCard: demoProducts[index]),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                color:
                                                    AppColors.kTextLightColor),
                                          ),
                                          child: Theme(
                                            data: ThemeData(
                                              unselectedWidgetColor:
                                                  Colors.white,
                                            ),
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: _isHaveMoney,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isHaveMoney = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tất cả sản phẩm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            demoProducts.length,
                            (index) {
                              return Row(
                                children: [
                                  Stack(
                                    children: [
                                      // TODO: <Trang> Replace Product with PostCard
                                      // ItemPostCard(
                                      //     postCard: demoProducts[index]),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: AppColors
                                                      .kTextLightColor)),
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Theme(
                                              data: ThemeData(
                                                  unselectedWidgetColor:
                                                      Colors.white),
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: _isHaveMoney,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isHaveMoney = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              // ? Should be delete?
                              // activeColor: Theme.of(context).primaryColor,
                              checkColor: Colors.white,
                              value: _isHaveMoney,
                              onChanged: (value) {
                                setState(() {
                                  _isHaveMoney = value!;
                                });
                              },
                            ),
                            const Text(
                              'Thêm tiền',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          //color: Colors.red,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _textEditingController,
                              validator: (value) {
                                if (value == null) {
                                  return 'Invalid Field';
                                }
                                return int.tryParse(value) != null
                                    ? null
                                    : 'Invalid Field';
                              },
                              maxLength: 10,
                              enabled: _isHaveMoney,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                hintText: 'VND',
                                hintStyle: TextStyle(height: 2),
                                labelText: 'Nhập số tiền',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kTextLightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomMaterialButton(
                        press: () {
                          //Navigator.of(context).pop();
                        },
                        isFilled: false,
                        text: 'Hủy',
                        width: MediaQuery.of(context).size.width / 4,
                        fontSize: 15,
                        height: 40),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomMaterialButton(
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pop(_textEditingController.text);
                          }
                        },
                        text: 'Gửi offer',
                        width: MediaQuery.of(context).size.width / 4,
                        fontSize: 15,
                        height: 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
