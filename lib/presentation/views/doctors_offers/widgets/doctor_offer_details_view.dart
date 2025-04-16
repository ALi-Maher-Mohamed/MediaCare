import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Doctor%20Details/doctor_details_view.dart';
import 'package:media_care/presentation/views/doctors_offers/data/model/offer_group_model.dart';

class DoctorOfferDetailsView extends StatelessWidget {
  final DoctorOffer doctorOffer;

  const DoctorOfferDetailsView({super.key, required this.doctorOffer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: doctorOffer.images.isNotEmpty
                    ? doctorOffer.images[0].image
                    : '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50, color: Colors.white),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctorOffer.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailsView(
                                  doctorID: doctorOffer.doctorId),
                            ),
                          );
                        },
                        child: Text(
                          'الذهاب للطبيب',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(
                            context,
                            'معلومات عن العرض',
                            doctorOffer.infoAboutOffer,
                            icon: Icons.info_outline,
                          ),
                          Divider(color: Theme.of(context).colorScheme.surface),
                          _buildDetailRow(
                            context,
                            'للتواصل',
                            doctorOffer.details,
                            icon: Icons.phone_outlined,
                          ),
                          Divider(color: Theme.of(context).colorScheme.surface),
                          _buildDetailRow(
                            context,
                            'السعر قبل الخصم',
                            doctorOffer.priceBeforeDiscount,
                            icon: Icons.price_change_outlined,
                          ),
                          Divider(color: Theme.of(context).colorScheme.surface),
                          _buildDetailRow(
                            context,
                            'الخصم',
                            doctorOffer.discount,
                            icon: Icons.discount_outlined,
                          ),
                          Divider(color: Theme.of(context).colorScheme.surface),
                          _buildDetailRow(
                            context,
                            'من',
                            doctorOffer.fromDay,
                            icon: Icons.calendar_today_outlined,
                          ),
                          Divider(color: Theme.of(context).colorScheme.surface),
                          _buildDetailRow(
                            context,
                            'إلى',
                            doctorOffer.toDay,
                            icon: Icons.calendar_today_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (doctorOffer.images.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    Text(
                      'صور العرض',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doctorOffer.images.length,
                        itemBuilder: (context, index) {
                          final image = doctorOffer.images[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: image.image,
                                width: 150.w,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    IconData? icon,
  }) {
    return _ExpandableDetailRow(
      label: label,
      value: value,
      icon: icon,
    );
  }
}

class _ExpandableDetailRow extends StatefulWidget {
  final String label;
  final String value;
  final IconData? icon;

  const _ExpandableDetailRow({
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  _ExpandableDetailRowState createState() => _ExpandableDetailRowState();
}

class _ExpandableDetailRowState extends State<_ExpandableDetailRow> {
  bool _isExpanded = false;
  static const int _maxCharacters = 50;

  @override
  Widget build(BuildContext context) {
    final isLongText = widget.value.length > _maxCharacters;
    final displayText = _isExpanded || !isLongText
        ? widget.value
        : '${widget.value.substring(0, _maxCharacters)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: 20.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  if (isLongText)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Padding(
            padding: EdgeInsets.only(right: widget.icon != null ? 28.w : 0),
            child: Text(
              displayText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
