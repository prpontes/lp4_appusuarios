class Permissoes {
  Map<String, bool>? _modUsuarios;
  Map<String, bool>? _modClientes;
  Map<String, bool>? _modProdutos;
  Map<String, bool>? _modFornecedores;
  Map<String, bool>? _modVendas;

  Map<String, bool> get modUsuarios => _modUsuarios!;

  set modUsuarios(Map<String, bool> value) {
    _modUsuarios = value;
  }

  Map<String, bool> get modClientes => _modClientes!;

  Map<String, bool> get modVendas => _modVendas!;

  set modVendas(Map<String, bool> value) {
    _modVendas = value;
  }

  Map<String, bool> get modFornecedores => _modFornecedores!;

  set modFornecedores(Map<String, bool> value) {
    _modFornecedores = value;
  }

  Map<String, bool> get modProdutos => _modProdutos!;

  set modProdutos(Map<String, bool> value) {
    _modProdutos = value;
  }

  set modClientes(Map<String, bool> value) {
    _modClientes = value;
  }
}
