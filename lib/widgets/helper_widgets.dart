import 'package:flutter/material.dart';

class HelperWidgets {

  /// Define common properties for widgets here
  ///
  ///
  ///

  /// This method returns a common box decoration
  BoxDecoration GetGreyBottomBorder() {
    return BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
