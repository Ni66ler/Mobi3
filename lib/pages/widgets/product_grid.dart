import 'package:flutter/material.dart';
import 'package:lab_2/entities/product.dart';

class ProductGrid extends StatelessWidget {
  static const double _cardRatio = 3 / 4;
  final Future<List<Product>> products;
  final String search;

  const ProductGrid({Key? key, required this.products, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = _filterList(list: snapshot.data as List<Product>, search: search);
            return GridView.builder(
              itemBuilder: (context, index) => _productCard(list[index], context),
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: _cardRatio,
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Загружаем товары...'),
                ],
              ),
            );
          }
        });
  }

  Widget _productCard(Product product, BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width / 3) / _cardRatio,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Text(product.brand),
          Text(product.name),
          Text(product.price),
        ],
      ),
    );
  }

  List<Product> _filterList({required String search, required List<Product> list}) =>
      list.where((product) {
        if (product.name.toLowerCase().contains(search.toLowerCase())) return true;
        if (product.brand.toLowerCase().contains(search.toLowerCase())) return true;
        return false;
      }).toList();
}
