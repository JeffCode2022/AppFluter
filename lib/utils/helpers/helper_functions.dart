
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';


class THelperFunctions {
  static Color? getColor(String value) {
    switch (value) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
        return Colors.grey;
      default:
        return null;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  static void showAlertDialog(
      BuildContext context, String title, String message) {
    // Asumiendo que Get.defaultDialog() es una funcionalidad que deseas mantener
    // y que tu proyecto ya está configurado para usar GetX,
    // aquí está cómo podrías hacerlo. De otro modo, considera usar showDialog() para una solución más estándar en Flutter.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cierra el dialog
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    // Asegurar que maxLength sea al menos 3 para acomodar los puntos suspensivos
    if (maxLength < 3) throw ArgumentError('maxLength must be at least 3');
    return text.length > maxLength
        ? '${text.substring(0, maxLength - 3)}...'
        : text;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    var found = <T>{};
    return list.where((item) => found.add(item)).toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize,
      {double spacing = 0.0,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    final List<Widget> wrappedList = [];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final end = i + rowSize > widgets.length ? widgets.length : i + rowSize;
      final rowChildren = widgets.sublist(i, end);

      wrappedList.add(Row(
        mainAxisAlignment: mainAxisAlignment,
        children: rowChildren
            .map((widget) => Padding(
                  padding: EdgeInsets.only(right: spacing),
                  child: widget,
                ))
            .toList(),
      ));
    }
    return wrappedList;
  }
}
