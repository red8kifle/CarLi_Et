import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';

final studentProfileProvider = StateProvider<Map<String, dynamic>>((ref) => {});

// Separate provider for image file
final studentImageFileProvider = StateProvider<File?>((ref) => null);

// Separate provider for resume file
final studentResumeFileProvider = StateProvider<File?>((ref) => null);