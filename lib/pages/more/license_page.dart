import 'package:Deal_Connect/api/setting.dart';
import 'package:Deal_Connect/model/app_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LicensePageIndex extends StatefulWidget {
  const LicensePageIndex({super.key});

  @override
  State<LicensePageIndex> createState() => _LicensePageIndexState();
}

class _LicensePageIndexState extends State<LicensePageIndex> {
  AppConfig? appConfig;
  String? version;

  @override
  void initState() {
    _initAppConfig();
    super.initState();
  }

  void _initAppConfig() {
    getAppConfig().then((response) {
      if (response.status == 'success') {
        AppConfig resultData = AppConfig.fromJSON(response.data);

        setState(() {
          appConfig = resultData;
        });
      }
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      print('appName: $appName');
      print('packageName: $packageName');
      print('version: $version');
      print('buildNumber: $buildNumber');

      setState(() {
        this.version = version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: LicensePage(
          applicationName: 'Deal&Connect',
          applicationVersion: version,
        ),
      ),
    );
  }
}
