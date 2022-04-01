import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'package:lab_1/entities/product.dart';

abstract class RemoteDataSource {
  factory RemoteDataSource() => _RemoteDataSource();

  Future<List<Product>> fetchProducts({required String url});
}

class _RemoteDataSource implements RemoteDataSource {
  static const String _prClass = 'product-card__main';
  static const String _prNameClass = 'goods-name';
  static const String _prBrandClass = 'brand-name';
  static const String _prPriceClass = 'lower-price';
  static const String _prtImageUrlClass = 'j-thumbnail';
  static const String _prImageUrlAttribute = 'src';

  @override
  Future<List<Product>> fetchProducts({required String url}) async =>
      _convertToProducts((await _getData(url)).getElementsByClassName(_prClass).sublist(0, 20));

  List<Product> _convertToProducts(List<Element> elements) {
    return elements
        .map((element) => Product(
              name: element.getElementsByClassName(_prNameClass).first.text,
              brand: element.getElementsByClassName(_prBrandClass).first.text,
              imageUrl: 'https:' +
                  element
                      .getElementsByClassName(_prtImageUrlClass)
                      .first
                      .attributes[_prImageUrlAttribute]!,
              price: element.getElementsByClassName(_prPriceClass).first.text,
            ))
        .toList();
  }

  Future<Document> _getData(String url) async {
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return parser.parse(response.body);
  }
}
