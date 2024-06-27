import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ClientPaymentsStatusController extends GetxController {

Function? refreshPage;
BuildContext? context;



Future init(BuildContext context, Function refreshPage) async {
    this.context = context;
    this.refreshPage = refreshPage;
     
  }
}