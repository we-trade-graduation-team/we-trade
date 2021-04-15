import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        // width: size.width * 0.6,
        margin: EdgeInsets.only(
          right: size.width * 0.02,
        ),
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: print,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: 'Search product',
            hintStyle: TextStyle(
              fontSize: 14,
              color: kPrimaryColor.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: kPrimaryColor.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}
