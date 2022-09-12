// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:demo_bloc/demo_shopper/blocs/cart_bloc.dart';
import 'package:demo_bloc/demo_shopper/blocs/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  final _catalogBloc = CatalogBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<CartBloc,CartState>(
            builder: (_, state) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _MyListItem(_catalogBloc.getListItems()[index]),
                  childCount: _catalogBloc.getListItems().length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _catalogBloc.close();
    super.dispose();
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart = context.read<CartBloc>().checkContain(item);
    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              context.read<CartBloc>().add(item);
            },
      child: isInCart
          ? const Icon(Icons.check )
          : const Text('Thêm'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Danh mục', style: TextStyle(color: Colors.white)),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final Item item;

  const _MyListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name,
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
