import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 10,
            color: const Color(0xff525252).withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Search here',
                border: InputBorder.none,
                helperMaxLines: 1,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 14,
                color: kTextLightColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: const Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
