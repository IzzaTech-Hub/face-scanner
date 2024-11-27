import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dp;

import 'package:face_scanner/app/utills/rc_variables.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();

  factory RemoteConfigService() {
    // Purchases.setEmail(email)
    return _instance;
  }

  RemoteConfigService._internal();

  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    print("Iniitalizing Remote config...");
    GetRemoteConfig().then((value) {
      SetRemoteConfig();

      remoteConfig.onConfigUpdated.listen((event) async {
        print("Remote Updated");
        //  await remoteConfig.activate();
        SetRemoteConfig();

        // Use the new config values here.
      });
    });
  }

  Future GetRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ));

      await remoteConfig.setDefaults(const {
        "GemeniAPIKey": "AIzaSyD4cCpD7lP-Q9raPF59L8npR8H5NF3pLIo",
        "PrivacyPolicyLink":
            "https://docs.google.com/document/d/1p3TlpUixPKvev9rMR-bo3tv-8yOvf6n3/edit?usp=drive_link&ouid=116035705295374336742&rtpof=true&sd=true",
      });

      await remoteConfig.fetchAndActivate();
    } on Exception catch (e) {
      // TODO
      print("Remote Config error: $e");
    }
  }

  Future SetRemoteConfig() async {
    RCVariables.GeminiAPIKey = remoteConfig.getString('GeminiAPIKey');
    // RCVariables.PrivacyPolicyLink.value =
    //     remoteConfig.getString('PrivacyPolicyLink');
    dp.log("Fetched Key: ${RCVariables.GeminiAPIKey}");
  }
}
