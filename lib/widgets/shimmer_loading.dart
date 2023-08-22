import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'placeholders.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
          ],
        ),
      ));
  }
}

class LoadingDetailPage extends StatefulWidget {
  const LoadingDetailPage({super.key});

  @override
  State<LoadingDetailPage> createState() => _LoadingDetailPageState();
}

class _LoadingDetailPageState extends State<LoadingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            DetailPlaceholder(),
            SizedBox(height: 20),
            DetailPlaceholder(),
            SizedBox(height: 20),
            DetailPlaceholder(),
            SizedBox(height: 20),
            DetailPlaceholder(),
          ],
        ),
      ));
  }
}

class LoadingEditPage extends StatefulWidget {
  const LoadingEditPage({super.key});

  @override
  State<LoadingEditPage> createState() => _LoadingEditPageState();
}

class _LoadingEditPageState extends State<LoadingEditPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            EditPlaceholder(),
            SizedBox(height: 20),
            EditPlaceholder(),
            SizedBox(height: 20),
            EditPlaceholder(),
            SizedBox(height: 20),
            EditPlaceholder(),
            SizedBox(height: 20),
            EditPlaceholder(),
          ],
        ),
      ));
  }
}
