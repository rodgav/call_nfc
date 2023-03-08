abstract class LocalDataSource {
  Future<void> readCardNfc();
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<void> readCardNfc() {
    // TODO: implement readCardNfc
    throw UnimplementedError();
  }
}
