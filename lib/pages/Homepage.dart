import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_flutter_app/core/store.dart';
import 'package:new_flutter_app/modals/cart.dart';
import 'dart:convert';
import 'package:new_flutter_app/modals/catalog.dart';
import 'package:new_flutter_app/pages/home_detail_page.dart';
import 'package:new_flutter_app/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/home_widgets/add_to_cart.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 0));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModal.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (ctx, _) => FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
          backgroundColor: context.theme.buttonColor,
          child: Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ).badge(
          color: Vx.red600,
          size: 20,
          count: _cart.items.length,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModal.items != null && CatalogModal.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl4.bold.color(context.theme.accentColor).make(),
        "Trending products".text.xl.make()
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: CatalogModal.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModal.items[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeDetailPage(catalog: catalog),
                  ),
                ),
                child: CatalogItem(catalog: catalog),
              );
            })
        : ListView.builder(
            shrinkWrap: true,
            itemCount: CatalogModal.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModal.items[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeDetailPage(catalog: catalog),
                  ),
                ),
                child: CatalogItem(catalog: catalog),
              );
            });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: !context.isMobile
          ? Column(
              children: [
                Hero(
                  tag: Key(catalog.id.toString()),
                  child: CatalogImage(image: catalog.image),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      catalog.name.text.bold.lg
                          .color(context.accentColor)
                          .make(),
                      catalog.desc.text.textStyle(context.captionStyle).make(),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "\$${catalog.price}".text.bold.xl.make(),
                          AddToCart(catalog: catalog),
                        ],
                      )
                    ],
                  ).p(context.isMobile ? 0 : 16),
                )
              ],
            )
          : Row(
              children: [
                Hero(
                  tag: Key(catalog.id.toString()),
                  child: CatalogImage(image: catalog.image),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    catalog.name.text.bold.lg.color(context.accentColor).make(),
                    catalog.desc.text.textStyle(context.captionStyle).make(),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "\$${catalog.price}".text.bold.xl.make(),
                        AddToCart(catalog: catalog),
                      ],
                    )
                  ],
                ))
              ],
            ),
    ).color(context.cardColor).square(150).rounded.make().py16();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;

  const CatalogImage({Key key, @required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? Image.network(image)
            .box
            .rounded
            .p8
            .color(context.canvasColor)
            .make()
            .p16()
            .w40(context)
        : Image.network(image)
            .box
            .rounded
            .p8
            .color(context.canvasColor)
            .make()
            .p16()
            .w24(context);
  }
}
