import 'dart:convert';

import 'package:filmophile/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmophile/shared/Constant.dart';
import 'package:filmophile/ui/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

part 'auth_services.dart';
part 'activity_services.dart';
part 'api_services.dart';
part 'media_services.dart';
part 'user_services.dart';
