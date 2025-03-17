extension CurrencyFormatter on double {
  String toBRL() {
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
