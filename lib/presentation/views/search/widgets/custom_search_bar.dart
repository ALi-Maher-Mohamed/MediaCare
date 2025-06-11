import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<PharmacyCubit>().searchPharmacies(query);
    });
  }

  void _clearSearch() {
    _controller.clear();
    context.read<PharmacyCubit>().searchPharmacies('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {}); // عشان نظهر زر × وقت الكتابة
                _onSearchChanged(value);
              },
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                hintText: 'ابحث باسم الصيدلية أو المدينة أو المنطقة',
                border: InputBorder.none,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _clearSearch,
            ),
        ],
      ),
    );
  }
}
