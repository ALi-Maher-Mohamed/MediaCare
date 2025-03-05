import 'package:flutter/material.dart';

class CustomShimmerListView extends StatelessWidget {
  const CustomShimmerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Skelton(
                  height: 80,
                  width: 80,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skelton(width: 120, height: 20),
                    SizedBox(height: 9),
                    Skelton(width: 80, height: 20),
                    SizedBox(height: 8),
                    Skelton(width: 200, height: 20),
                  ],
                )),
                Skelton(height: 30, width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.height,
    this.width,
  });
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
