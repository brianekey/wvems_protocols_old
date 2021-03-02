import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvems_protocols/_internal/utils/utils.dart';
import 'package:wvems_protocols/controllers/controllers.dart';

class StyledProtocolsYear extends StatelessWidget {
  //XXX(brianekey): I think this is right?? But gives a warning about immutable
  StyledProtocolsYear({this.size=56.0, int optionalYear}) {
    _yearText = wvemsText(optionalYear ?? ThemeService.to.themeYear.value);
    _yearColor = wvemsColor(optionalYear ?? ThemeService.to.themeYear.value);
  }
  double size;
  String _yearText;
  Color _yearColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _yearColor,
            border: Border.all(width: 2.0, color: Colors.grey)),
        child: Text(
          '$_yearText',
          textAlign: TextAlign.center,
          style: GoogleFonts.barlow(
            color: Colors.black,
            fontSize: 6+size/2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
