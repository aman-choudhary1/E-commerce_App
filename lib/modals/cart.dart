import 'package:new_flutter_app/core/store.dart';
import 'package:new_flutter_app/modals/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModal {
  CatalogModal _catalog;

  final List<int> _itemIds = [];

  CatalogModal get catalog => _catalog;

  set catalog(CatalogModal newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //get item in cart
  List<Item> get items => _itemIds
      .map(
        (id) => _catalog.getById(id),
      )
      .toList();
  //get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //Add item
  void add(Item item) {
    _itemIds.add(item.id);
  }
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;
  AddMutation(this.item);

  @override
  perform() {
    store.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;
  RemoveMutation(this.item);

  @override
  perform() {
    store.cart._itemIds.remove(item.id);
  }
}
