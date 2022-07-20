import 'package:new_flutter_app/modals/cart.dart';
import 'package:new_flutter_app/modals/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  CatalogModal catalog;
  CartModal cart;

  MyStore() {
    catalog = CatalogModal();
    cart = CartModal();
    cart.catalog = catalog;
  }
}
