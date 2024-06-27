import 'package:delivery_autonoma/common/widgets/text/product_price_title.dart';
import 'package:delivery_autonoma/common/widgets/text/t_brand_title_text_with_verification.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/screens/cliente/products/details/client_products_detail_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class ClientProductsDetailPage extends StatefulWidget {
  Product product;
  ClientProductsDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ClientProductsDetailPage> createState() =>
      _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  final ClientProductsDetailController _contr =
      ClientProductsDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          children: [
            _imageSlideshow(),
            _textName(),
            _textDesciption(),
            const SizedBox(height: 10),
            _addOrRemoveProduct(),
            const SizedBox(height: 10),
            _standarDelivery(),
            _comentario(),
            const Spacer(),
            _shoppingBag(),
          ],
        ));
  }

  ///-------------------WIDGET------------------------------------

  ///-------------------IMAGE------------------------------------

  Widget _imageSlideshow() {
    return ImageSlideshow(
      width: double.infinity,
      height: 280,
      indicatorColor: MyColors.primary,
      onPageChanged: (value) {
        debugPrint('Page changed: $value');
      },
      autoPlayInterval: 30000,
      isLoop: true,
      children: [
        FadeInImage(
          image: _contr.product?.image1 != null
              ? NetworkImage(_contr.product!.image1!)
              : const AssetImage(TImages.jugos) as ImageProvider<Object>,
          fit: BoxFit.contain,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage(TImages.jugos),
        ),
        FadeInImage(
          image: _contr.product?.image2 != null
              ? NetworkImage(_contr.product!.image2!)
              : const AssetImage(TImages.jugos) as ImageProvider<Object>,
          fit: BoxFit.contain,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage(TImages.jugos),
        ),
        FadeInImage(
          image: _contr.product?.image3 != null
              ? NetworkImage(_contr.product!.image3!)
              : const AssetImage(TImages.jugos) as ImageProvider<Object>,
          fit: BoxFit.contain,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage(TImages.jugos),
        ),
      ],
    );
  }

  /// -------------------NAME------------------------------------
  Widget _textName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Text(
        _contr.product?.name ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///-------------------DESCRIPTION------------------------------------

  Widget _textDesciption() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _contr.product?.description ?? '',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const TBrandTitleWithVerifiedIcon(title: 'Autonoma')
        ],
      ),
    );
  }

  //---------ADD OR REMOVE PRODUCT-------------------
  Widget _addOrRemoveProduct() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          IconButton(
            onPressed: _contr.addProduct,
            icon: const Icon(
              Icons.add_circle_outline,
              color: MyColors.grey,
              size: 30,
            ),
          ),
          Text(
            '${_contr.counter}',
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: _contr.removeProduct,
            icon: const Icon(
              Icons.remove_circle_outline,
              color: MyColors.grey,
              size: 30,
            ),
          ),
          const Spacer(),
          TProductoPriceText(price: '${_contr.productPrice}')
        ],
      ),
    );
  }

  ///-------------------STANDAR DELIVERY------------------------------------
  Widget _standarDelivery() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Image(
              image: AssetImage(TImages.imgDelivery), width: 30, height: 30),
          const SizedBox(width: 10),
          Text('Standar Delivery', style: TextStyle(color: Colors.green[400])),
          const Spacer(),
          const Text('Free'),
        ],
      ),
    );
  }

  ///--------------BUTTOM SHOPPING BAG-------------------
  Widget _shoppingBag() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 60),
      child: ElevatedButton(
          onPressed: _contr.addToBag,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add to Bag',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 40),
                  child: Image.asset(
                    TImages.shoppingBag,
                    width: 50,
                    height: 50,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _comentario() {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: TextFormField(
        controller: _contr.commentController,
        maxLength: 255,
        maxLines: 4,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
        
          labelText: 'Agrega o comenta el producto de tu preferencia',
          labelStyle: TextStyle(color: MyColors.primary.withOpacity(0.7)),
          prefixIcon: const Icon(Iconsax.archive, color: MyColors.dark),

           focusedBorder:  const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
