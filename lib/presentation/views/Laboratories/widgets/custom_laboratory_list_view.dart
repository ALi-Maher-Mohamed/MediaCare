import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/search/widgets/custom_search_bar.dart';
import '../data/model/labs_model/data.dart';
import 'custom_laboratory_list_view_item.dart';

class CustomLaboratoryListView extends StatefulWidget {
  final List<LaboratoryModel> laboratories;
  final ScrollController scrollController;

  const CustomLaboratoryListView({
    super.key,
    required this.laboratories,
    required this.scrollController,
  });

  @override
  State<CustomLaboratoryListView> createState() =>
      _CustomLaboratoryListViewState();
}

class _CustomLaboratoryListViewState extends State<CustomLaboratoryListView> {
  String? selectedCity = 'الكل';
  String? selectedArea = 'الكل';
  String? selectedInsurance = 'الكل';

  List<String> getCities() {
    final cities = widget.laboratories.map((e) => e.city).toSet().toList();
    cities.sort();
    return ['الكل', ...cities];
  }

  List<String> getAreas() {
    final areas = widget.laboratories.map((e) => e.area).toSet().toList();
    areas.sort();
    return ['الكل', ...areas];
  }

  List<String> getInsuranceOptions() => ['الكل', 'نعم', 'لا'];

  void applyFilters() {
    final cubit = context.read<LaboratoryCubit>();

    cubit.filterLaboratories(
      city: selectedCity == 'الكل' ? null : selectedCity,
      area: selectedArea == 'الكل' ? null : selectedArea,
      supportsInsurance:
          selectedInsurance == 'الكل' ? null : selectedInsurance == 'نعم',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cities = getCities();
    if (!cities.contains(selectedCity)) selectedCity = 'الكل';

    final areas = getAreas();
    if (!areas.contains(selectedArea)) selectedArea = 'الكل';

    final insuranceOptions = getInsuranceOptions();
    if (!insuranceOptions.contains(selectedInsurance))
      selectedInsurance = 'الكل';

    return Column(
      children: [
        CustomSearchBar(
          hintText: 'ابحث عن مختبر',
          onSearch: (query) {
            context.read<LaboratoryCubit>().searchLaboratories(query);
          },
        ),

        /// --- الفلاتر ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedCity,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city, textDirection: TextDirection.rtl),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value!;
                          applyFilters();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedArea,
                      items: areas.map((area) {
                        return DropdownMenuItem(
                          value: area,
                          child: Text(area, textDirection: TextDirection.rtl),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedArea = value!;
                          applyFilters();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedInsurance,
                items: insuranceOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text('تأمين: $option',
                        textDirection: TextDirection.rtl),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedInsurance = value!;
                    applyFilters();
                  });
                },
              ),
            ],
          ),
        ),

        /// --- قائمة المختبرات ---
        Expanded(
          child: widget.laboratories.isEmpty
              ? const Center(child: Text('لا توجد نتائج مطابقة'))
              : ListView.builder(
                  controller: widget.scrollController,
                  itemCount: widget.laboratories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.laboratories.length) {
                      return context.read<LaboratoryCubit>().hasMore
                          ? const CustomProgressIndicator()
                          : const SizedBox.shrink();
                    }
                    return LaboratoryListViewItem(
                      laboratory: widget.laboratories[index],
                      index: index,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
