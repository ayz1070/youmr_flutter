enum DeviceType { ANDROID, IOS }

extension DeviceTypeExtension on DeviceType {
  String get name {
    switch (this) {
      case DeviceType.ANDROID:
        return 'ANDROID';
      case DeviceType.IOS:
        return 'IOS';
    }
  }
}