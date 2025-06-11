import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'pharmacy_list_view_item.dart';
import '../../search/widgets/custom_search_bar.dart';
import '../data/model/pharmacy_model.dart';

class CustomPharmacyListView extends StatefulWidget {
  final List<PharmacyModel> pharmacies;
  final ScrollController scrollController;

  const CustomPharmacyListView({
    super.key,
    required this.pharmacies,
    required this.scrollController,
  });

  @override
  State<CustomPharmacyListView> createState() => _CustomPharmacyListViewState();
}

class _CustomPharmacyListViewState extends State<CustomPharmacyListView> {
  String? selectedCity = 'الكل';
  String? selectedArea = 'الكل';
  String? selectedInsurance = 'الكل';

  List<String> getCities() {
    final cities = widget.pharmacies.map((e) => e.city).toSet().toList();
    cities.sort();
    return ['الكل', ...cities];
  }

  List<String> getAreas() {
    final areas = widget.pharmacies.map((e) => e.area).toSet().toList();
    areas.sort();
    return ['الكل', ...areas];
  }

  List<String> getInsuranceOptions() => ['الكل', 'نعم', 'لا'];

  void applyFilters() {
    final cubit = context.read<PharmacyCubit>();

    cubit.filterPharmacies(
      city: selectedCity == 'الكل' ? null : selectedCity,
      area: selectedArea == 'الكل' ? null : selectedArea,
      supportsInsurance:
          selectedInsurance == 'الكل' ? null : selectedInsurance == 'نعم',
    );
  }

  @override
  Widget build(BuildContext context) {
    // تأكد من صحة القيمة المختارة لكل Dropdown قبل البناء لتجنب الخطأ
    final cities = getCities();
    if (selectedCity != null && !cities.contains(selectedCity)) {
      selectedCity = 'الكل';
    }

    final areas = getAreas();
    if (selectedArea != null && !areas.contains(selectedArea)) {
      selectedArea = 'الكل';
    }

    final insuranceOptions = getInsuranceOptions();
    if (selectedInsurance != null &&
        !insuranceOptions.contains(selectedInsurance)) {
      selectedInsurance = 'الكل';
    }

    return Column(
      children: [
        CustomSearchBar(
          hintText: 'ابحث عن صيدلية',
          onSearch: (query) {
            context.read<PharmacyCubit>().searchPharmacies(query);
          },
        ),

        // الفلاتر
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

        // عرض قائمة الصيدليات أو رسالة لا توجد نتائج
        Expanded(
          child: widget.pharmacies.isEmpty
              ? const Center(child: Text('لا توجد نتائج مطابقة'))
              : ListView.builder(
                  controller: widget.scrollController,
                  itemCount: widget.pharmacies.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.pharmacies.length) {
                      return context.read<PharmacyCubit>().hasMore
                          ? const CustomProgressIndicator()
                          : const SizedBox.shrink();
                    }
                    return PharmacyListViewItem(
                        pharmacy: widget.pharmacies[index], index: index);
                  },
                ),
        ),
      ],
    );
  }
}
