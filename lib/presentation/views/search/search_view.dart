import 'package:flutter/material.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            leading: null,
            centerTitle: true,
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              'أبحث عن دكتورك  ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchViewBody(),
          )),
    );
  }
}
