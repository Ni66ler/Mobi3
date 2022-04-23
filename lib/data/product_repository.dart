import 'package:lab_2/data/remote_data_source.dart';
import 'package:lab_2/entities/product.dart';

class ProductRepository {
  static final RemoteDataSource _dataSource = RemoteDataSource();
  static final List<Product> _borba = [];
  static final List<Product> _plavki = [];

  Future<List<Product>> getAllProducts() async =>
      [...(await getBorba()), ...(await getPlavki())];

  Future<List<Product>> getBorba() async {
    if (_borba.isEmpty) {
      _borba.addAll(await _dataSource.fetchProducts(url: ProductType.borba.url));
    }
    return _borba;
  }

  Future<List<Product>> getPlavki() async {
    if (_plavki.isEmpty) {
      _plavki.addAll(await _dataSource.fetchProducts(url: ProductType.plavki.url));
    }
    return _plavki;
  }
}

enum ProductType { borba, plavki }

extension ProductExtensions on ProductType {
  static const Map<ProductType, String> _urls = {
    ProductType.borba: 'https://by.wildberries.ru/catalog/sport/edinoborstva/borba',
    ProductType.plavki: 'https://by.wildberries.ru/catalog/sport/dlya-muzhchin/bele-i-plavki',
  };

  String get url => _urls[this]!;
}
