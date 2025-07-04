import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/rendering.dart';
import '../../../app_configs/constants/platform_requirements.dart';

/// 🧪 [IDebugTools] — abstraction for debug and platform support tools.
/// ✅ Allows to configure debug options and validate platform support.

abstract interface class IDebugTools {
  ///------------------------------
  //
  Future<void> validatePlatformSupport();
  //
  void configure();
  //
}

////

////

/// 🧪 [DefaultDebugTools] — production implementation.

final class DefaultDebugTools implements IDebugTools {
  ///----------------------------------------------
  const DefaultDebugTools();

  ///📱 Check minimum platform support (e.g., Android SDK, IOS version)
  @override
  Future<void> validatePlatformSupport() async {
    //
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < PlatformConstants.minSdkVersion) {
        throw UnsupportedError(
          'Android SDK ${androidInfo.version.sdkInt} is not supported. '
          'Minimum is ${PlatformConstants.minSdkVersion}',
        );
      }
    }

    if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      final versionStr = iosInfo.systemVersion;
      final minIosVersion = PlatformConstants.minIOSMajorVersion;

      // Parse major version numbers (e.g., "14.2" → 14)
      int? major = int.tryParse(versionStr.split('.').first);
      int? requiredMajor = int.tryParse(minIosVersion.split('.').first);

      if (major != null && requiredMajor != null && major < requiredMajor) {
        throw UnsupportedError(
          'iOS version $versionStr is not supported. '
          'Minimum is $minIosVersion',
        );
      }
    }
    // Add check for Web/other platforms if needed.
  }

  /// Configures Flutter-specific debug tools.
  @override
  void configure() {
    // Controls visual debugging options (e.g., repaint highlighting).
    debugRepaintRainbowEnabled = false;
  }

  //
}
