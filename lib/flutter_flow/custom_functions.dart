import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String dutation(DateTime durationD) {
  DateTime dt1 = durationD;
  DateTime dt2 = DateTime.now();

  Duration diff = dt1.difference(dt2);

  print(diff.inDays);
  return diff.inDays.toString();
}
