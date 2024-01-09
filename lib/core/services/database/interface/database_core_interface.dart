
abstract class DatabaseCoreInterface<T> {
  //required [raw , select(id) , seletWhere , insert , update(id) , updateWhere , delete(id?) , join , joinLeft , joinRight]
  Future<void> initDB(); 
  Future<void> recreateDatabase(); 
  T table(String table); 
  Future<List<Map<String, Object?>>> select({int? id});
  Future<List<Map<String, Object?>>> selectWhere(String where , List<Object?> whereArgs);
  Future<int> insert(Map<String, Object?> row); 
  Future<int> update(Map<String, Object?> row, int id); 
  Future<int> updateWhere(Map<String, Object?> row, String where , List<Object?> whereArgs); 
  Future<int> delete({int? id}); 
  Future<int> deleteWhere(String where , List<Object?> whereArgs); 

}
