import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const SystemUiOverlayStyle lightStatusBarTransparent = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light, // For Android (dark icons)
  statusBarBrightness: Brightness.dark, // For iOS (dark icons)
);

const SystemUiOverlayStyle darkStatusBarTransparent = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
  statusBarBrightness: Brightness.light, // For iOS (dark icons)
);
