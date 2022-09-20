import 'package:in_app_update/in_app_update.dart';

import 'remote_config_service.dart';

class InAppUpdateHelper {
  InAppUpdateHelper._privateConstructor();

  static final InAppUpdateHelper instance =
      InAppUpdateHelper._privateConstructor();

  AppUpdateInfo? _updateInfo;

  bool _flexibleUpdateAvailable = false;

  Future<void> checkForUpdate() async {
    final info = await InAppUpdate.checkForUpdate();
    _updateInfo = info;
    if (_updateInfo == null) return;
    if (_updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
      final remoteConfig = await RemoteConfigService.getInstance();
      _flexibleUpdateAvailable = !remoteConfig.getForceUpdate;
      if (_flexibleUpdateAvailable) {
        await InAppUpdate.startFlexibleUpdate();
      } else {
        InAppUpdate.performImmediateUpdate();
      }
    }
  }
}
