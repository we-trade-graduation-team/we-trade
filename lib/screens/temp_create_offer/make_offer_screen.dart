import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/color.dart';
import '../../models/product_model.dart';
import '../../widgets/buttons.dart';
import '../../widgets/product_card.dart';

class MakeOfferScreen extends StatefulWidget {
  MakeOfferScreen({Key? key}) : super(key: key);

  bool isHaveMoney = false;

  @override
  _MakeOfferScreenState createState() => _MakeOfferScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isHaveMoney', isHaveMoney));
  }
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

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
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            demoProducts.length,
                            (index) {
                              return Stack(children: [
                                ProductCard(product: demoProducts[index]),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3),
                                        border:
                                            Border.all(color: kTextLightColor)),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: kPrimaryColor,
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                        value: widget.isHaveMoney,
                                        onChanged: (value) {
                                          setState(() {
                                            widget.isHaveMoney = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                            },
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tất cả sản phẩm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            demoProducts.length,
                            (index) {
                              return Stack(children: [
                                ProductCard(product: demoProducts[index]),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3),
                                        border:
                                            Border.all(color: kTextLightColor)),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: kPrimaryColor,
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                        value: widget.isHaveMoney,
                                        onChanged: (value) {
                                          setState(() {
                                            widget.isHaveMoney = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                            },
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: kPrimaryColor,
                              checkColor: Colors.white,
                              value: widget.isHaveMoney,
                              onChanged: (value) {
                                setState(() {
                                  widget.isHaveMoney = value!;
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
                              enabled: widget.isHaveMoney,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                hintText: 'VND',
                                hintStyle: TextStyle(height: 2),
                                labelText: 'Nhấp số tiền',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kTextLightColor,
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
                    child: ButtonWidget(
                        press: () {
                          //Navigator.of(context).pop();
                        },
                        isFilled: false,
                        text: 'Hủy',
                        width: MediaQuery.of(context).size.width / 4,
                        fontsize: 15,
                        height: 40),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ButtonWidget(
                        press: () {
                          // if (_formKey.currentState!.validate()) {
                          //   Navigator.of(context).pop(_textEditingController.text);
                          // }
                        },
                        text: 'Gửi offer',
                        width: MediaQuery.of(context).size.width / 4,
                        fontsize: 15,
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
