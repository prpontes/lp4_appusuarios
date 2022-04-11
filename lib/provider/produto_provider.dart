import 'package:lp4_appusuarios/provider/base_banco_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ProdutoProvider extends BaseBancoProvider {
  @override
  onCreate(Database db) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS produto (id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT, preco REAL, imagem TEXT)",
    );
  }

  @override
  onInit(Database db) {
    this.db = db;
  }
}
