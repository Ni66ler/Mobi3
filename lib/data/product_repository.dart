import 'package:lab_1/data/remote_data_source.dart';
import 'package:lab_1/entities/product.dart';

class ProductRepository {
  static final RemoteDataSource _dataSource = RemoteDataSource();
  static final List<Product> _sneakers = [];
  static final List<Product> _robes = [];

  Future<List<Product>> getAllProducts() async =>
      [...(await getSneakers()), ...(await getRobes())];

  Future<List<Product>> getSneakers() async {
    if (_sneakers.isEmpty) {
      _sneakers.addAll(await _dataSource.fetchProducts(url: ProductType.sneakers.url));
    }
    return _sneakers;
  }

  Future<List<Product>> getRobes() async {
    if (_robes.isEmpty) {
      _robes.addAll(await _dataSource.fetchProducts(url: ProductType.robes.url));
    }
    return _robes;
  }
}

enum ProductType { sneakers, robes }

extension ProductExtensions on ProductType {
  static const Map<ProductType, String> _urls = {
    ProductType.sneakers: 'https://by.wildberries.ru/catalog/obuv/muzhskaya/kedy-i-krossovki',
    ProductType.robes: 'https://by.wildberries.ru/catalog/muzhchinam/halaty',
  };

  String get url => _urls[this]!;
}
