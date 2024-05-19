import 'package:delivery_autonoma/firebase_options.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/create/client_address_create_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/list/client_address_list_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/maps/client_address_maps_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/orders/create/client_orders_create_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/products/list/client_products_list_page.dart';
import 'package:delivery_autonoma/src/screens/cliente/update/client_update_pages.dart';
import 'package:delivery_autonoma/src/screens/delivery/orders/list/delivery_orders_list.dart';
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
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
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

        /////-----------------RESTAURANTE-----------------////
        'restaurant/orders/list': (context) => const RestaurantOrderListPage(),
        'restaurant/categories/create': (context) =>
            const RestaurantCategoriesCreatePage(),
        'restaurant/products/create': (context) =>
            const RestaurantProductsCreatePage(),

        /////-----------------DELIVERY-----------------////
        'delivery/orders/list': (context) => const DeliveryOrderListPage(),
      },
    );
  }
}
