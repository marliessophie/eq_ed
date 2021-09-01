import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Web",
    svgSrc: "assets/icons/Documents.svg",
    color: kPrimaryColor,
    percentage: 63,
  ),
  CloudStorageInfo(
    title: "iOS",
    svgSrc: "assets/icons/google_drive.svg",
    color: Color(0xFFFFA113),
    percentage: 25,
  ),
  CloudStorageInfo(
    title: "Android",
    svgSrc: "assets/icons/one_drive.svg",
    color: Color(0xFFA4CDFF),
    percentage: 13,
  ),
];
