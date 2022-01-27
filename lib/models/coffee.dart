class Coffee {
  final double weight;
  const Coffee({this.weight = 15});

  double getTotalServing() {
    return weight * 15;
  }

  double getSinglePour() {
    return weight * 3;
  }

  List<double> getFullPours() {
    return [
      0,
      getSinglePour() * 2 * .35,
      getSinglePour() * 2,
      getSinglePour() * 3,
      getSinglePour() * 4,
      getSinglePour() * 5
    ];
  }
}
