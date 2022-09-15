
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkStoragePermission() async{
  if (await Permission.storage.request().isGranted) {
    return true;
  }

  Map<Permission, PermissionStatus> statuses = await [
  Permission.storage,
  ].request();
//  print(statuses[Permission.location]);
  return false;
}