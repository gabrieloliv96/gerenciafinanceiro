class ContaController {
  String? _nome;
  setNome(String value) => _nome = value;

  String? _tipo;
  setTipo(String value) => _tipo = value;

  String? _valor;
  setValor(String value) => _valor = value;

  getValor() {
    return _valor;
  }
  // ContaController(String? nome, int? tipo, double? valor);

  String toString() {
    return "Nome: " + _nome! + "\nTipo: " + _tipo! + "\nValor: " + _valor!;
  }
}
