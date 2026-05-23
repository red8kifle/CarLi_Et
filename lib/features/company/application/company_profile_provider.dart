
import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';

final companyProfileProvider = StateProvider<Map<String, dynamic>>((ref) => {});

// Separate provider for logo file
final companyLogoFileProvider = StateProvider<File?>((ref) => null);
