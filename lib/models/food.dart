class Food {
  int quantity;
  String id;
  double price;
  String chefId;
  String removedIngrediants;
  String extraNote;
  String deliveryOption;
  String address;
  DateTime dineIn;

  Food(
      {this.dineIn,
      this.address,
      this.deliveryOption,
      this.id,
      this.quantity,
      this.price,
      this.chefId,
      this.removedIngrediants,
      this.extraNote});
}
