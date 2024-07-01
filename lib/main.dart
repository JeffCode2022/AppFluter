import 'package:delivery_autonoma/firebase_options.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/create/client_address_create_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/list/client_address_list_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/maps/client_address_maps_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/orders/create/client_orders_create_page.dart';
<<<<<<< HEAD
import 'package:delivery_autonoma/src/screens/cliente/orders/list/client_orders_list_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/orders/maps/client_orders_maps_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/paymets/create/client_paymets_create_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/paymets/installments/client_payments_installments_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/paymets/status/client_payments_status_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/products/list/client_products_list_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/update/client_update_pages.dart';
import 'package:delivery_autonoma/src/screens/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_autonoma/src/screens/delivery/orders/maps/delivery_orders_maps_page.dart';
=======
import 'package:delivery_autonoma/src/screens/cliente/products/list/client_products_list_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/update/client_update_pages.dart';
import 'package:delivery_autonoma/src/screens/delivery/orders/list/delivery_orders_list.dart';
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
import 'package:delivery_autonoma/src/screens/login/login_screen.dart';
import 'package:delivery_autonoma/src/screens/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:delivery_autonoma/src/screens/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_autonoma/src/screens/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:delivery_autonoma/src/screens/roles/roles_screens.dart';
import 'package:delivery_autonoma/src/screens/signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
<<<<<<< HEAD
  Widget build(BuildContext context,) {
=======
  Widget build(BuildContext context) {
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
<<<<<<< HEAD
        fontFamily: 'SFPRO',
=======
        fontFamily: 'SFProDisplay',
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
<<<<<<< HEAD
           

=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      home: const LoginPage(),
      routes: {
        'login': (context) => const LoginPage(),
        'roles': (context) => const RolesPage(),
        'signup': (context) => const SignUpScreen(),
        ////-----------------CLIENTE-----------------////
        'cliente/products/list': (context) => const ClienteProductsListPage(),
        'client/update': (context) => const ClientUpdatePage(),
        'client/orders/create': (context) => const ClientOrdersCreatePage(),
        'client/address/list': (context) => const ClientAddressListPage(),
        'client/address/maps': (context) => const ClientAddressMapsPage(),
        'client/address/create': (context) => const ClientAddressCreatePage(),
<<<<<<< HEAD
        'client/orders/maps': (context) => const ClientOrdersMapsPage(),
        'client/orders/list': (context) => const ClientOrdersListPage(),
        'client/payments/create': (context) => const ClientPaymetsCreatePage(),
        'client/payments/installments': (context) => const ClientPaymentsInstallmentsPage(),
        'client/payments/status': (context) => const ClientPaymentsStatusPage(),
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

        /////-----------------RESTAURANTE-----------------////
        'restaurant/orders/list': (context) => const RestaurantOrderListPage(),
        'restaurant/categories/create': (context) =>
            const RestaurantCategoriesCreatePage(),
        'restaurant/products/create': (context) =>
            const RestaurantProductsCreatePage(),

        /////-----------------DELIVERY-----------------////
<<<<<<< HEAD
        'delivery/orders/list': (context) => const DeliveryOrdersListPage(),
        'delivery/orders/detail': (context) => const DeliveryOrdersListPage(),
        'delivery/orders/maps': (context) => const DeliveryOrdersMapsPage(),
=======
        'delivery/orders/list': (context) => const DeliveryOrderListPage(),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      },
    );
  }
}
