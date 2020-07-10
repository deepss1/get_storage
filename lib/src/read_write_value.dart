import 'package:get_storage/src/storage_impl.dart';

typedef StorageFactory = GetStorage Function();

class ReadWriteValue<T> {
  final String key;
  final T defaultValue;
  final StorageFactory getBox;
  final EncodeObject objectEncoder;

  ReadWriteValue(
    this.key,
    this.defaultValue,
    this.getBox, [
    this.objectEncoder,
  ]);

  T get val => getBox().read(key) ?? defaultValue;
  set val(T newValue) => getBox().write(key, newValue, objectEncoder);
}

extension Data<T> on T {
  ReadWriteValue<T> val(
    String valueKey, {
    String storageKey = defaultContainer,
    T defVal,
  }) {
    return ReadWriteValue(
      valueKey,
      defVal ?? this,
      () => GetStorage(storageKey),
    );
  }
}
