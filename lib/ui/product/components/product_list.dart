import 'package:flutter/material.dart';
import 'package:getshop_demo/bindings/product_details_binding.dart';
import 'package:getshop_demo/ui/product/components/star_rating.dart';
import 'package:getshop_demo/ui/product/screens/product_details_screen.dart';
import 'package:getshop_demo/util/nav.dart';

import '../../../data/product/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (c, index) => ProductListItem(
        key: ObjectKey(products[index]),
        product: products[index],
      ),
      separatorBuilder: (c, index) => const Divider(
        height: 2,
        thickness: 1.5,
        indent: 8,
        endIndent: 8,
      ),
      itemCount: products.length,
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.25;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _onItemTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl,
                width: imageSize,
                height: imageSize,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: ItemDescription(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTap() {
    Nav.to(
      ProductDetailsScreen(product: product),
      binding: ProductDetailsBinding(productId: product.id),
    );
  }
}

class ItemDescription extends StatelessWidget {
  final Product product;

  const ItemDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        StarRating(rating: product.starRating),
        Text(
          '\$${product.price}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
