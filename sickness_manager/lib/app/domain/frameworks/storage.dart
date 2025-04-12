abstract interface class Storage {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> clear();
}