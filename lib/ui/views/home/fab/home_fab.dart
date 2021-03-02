import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:wvems_protocols/controllers/commands/set_page_command.dart';
import 'package:wvems_protocols/controllers/controllers.dart';
import 'package:wvems_protocols/_internal/utils/wvems_colors.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PdfStateController controller = Get.find();

    final _activeButton = Obx(() => FloatingActionButton(
          elevation: 4.0,
          child: const Icon(Icons.arrow_upward_rounded, size: 36.0),
          backgroundColor: wvemsColor(ThemeService.to.themeYear.value),
          foregroundColor: const Color(0xFF0F0F0F),
          onPressed: () async => await SetPageCommand().execute(),
        ));
    const Widget _inactiveButton = FloatingActionButton(
      elevation: 4.0,
      child: Icon(Icons.error_outline_rounded, size: 36.0),
      backgroundColor: Color(0xFFF0F0F0),
      foregroundColor: Color(0xFF0F0F0F),
      onPressed: null,
    );

    return FutureBuilder<PDFViewController>(
      future: controller.asyncController.future,
      builder:
          (BuildContext context, AsyncSnapshot<PDFViewController> snapshot) {
        if (snapshot.hasData) {
          return Obx(
            () => (controller.rxPdfController.value != null)
                ? _activeButton
                : _inactiveButton,
          );
        }
        return _inactiveButton;
      },
    );
  }
}
