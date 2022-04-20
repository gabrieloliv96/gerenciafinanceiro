import 'conta_model.dart';

enum TipoConta {
  Pagamento,
  Recebido,
  Dinheiro,
  Pix,
  Outros,
}

class Calculos {
  static resultado(List<ContaModel> registros) {
    double total = 0;
    // print('tipo conta ${TipoConta.Debito.index}');
    for (ContaModel registro in registros) {
      if (registro.tipo == 'Pagamento') {
        total += double.parse(registro.valor);
      } else if (registro.tipo == TipoConta.Recebido.toString()) {
        total += double.parse(registro.valor);
      }
    }
    return total;
  }
}
