class VehicleModel {
  int? id;
  int? odometer;
  String? bodyType;
  String? vin;
  String? stock;
  String? brand;
  String? model;
  String? year;
  String? trim;
  String? transmission;
  String? currency;
  String? priceFormatted;
  String? state;
  String? odometerFormated;
  String? thumbnail;
  List<CatalogItem>? catalog;
  Map<String, dynamic>? geocoordinates;

  VehicleModel({
    this.id,
    this.odometer,
    this.bodyType,
    this.vin,
    this.stock,
    this.brand,
    this.model,
    this.year,
    this.trim,
    this.transmission,
    this.currency,
    this.priceFormatted,
    this.state,
    this.odometerFormated,
    this.thumbnail,
    this.catalog,
    this.geocoordinates,
  });

  factory VehicleModel.fromMapJson(Map<String, dynamic> data) {
    return VehicleModel(
      id: data['id'],
      odometer: data['odometer'],
      bodyType: data['bodyType'],
      vin: data['vin'],
      stock: data['stock'],
      brand: data['brand'],
      model: data['model'],
      year: data['year'],
      trim: data['trim'],
      transmission: data['transmission'],
      currency: data['currency'],
      priceFormatted: data['priceFormatted'],
      state: data['state'],
      odometerFormated: data['odometerFormated'],
      thumbnail: data['thumbnail'],
      catalog: (data['catalog'] as List)
          .map((e) => CatalogItem.fromMapJson(e))
          .toList(),
      geocoordinates: data['geocoordinates'],
    );
  }
}

class CatalogItem {
  String? value;
  String? id;
  String? label;
  String? type;
  String? groupId;
  int? order;
  String? valueId;

  CatalogItem({
    this.value,
    this.id,
    this.label,
    this.type,
    this.groupId,
    this.order,
    this.valueId,
  });

  factory CatalogItem.fromMapJson(Map<String, dynamic> data) {
    return CatalogItem(
      value: data['value'],
      id: data['id'],
      label: data['label'],
      type: data['type'],
      groupId: data['groupId'],
      order: data['order'],
      valueId: data['valueId'],
    );
  }
}

class StatusCount {
  String? label;
  String? id;
  int? total;
  bool? show;
  int? order;
  List<StatusAction>? actions;

  StatusCount({
    this.label,
    this.id,
    this.total,
    this.show,
    this.order,
    this.actions,
  });

  factory StatusCount.fromMapJson(Map<String, dynamic> data) {
    return StatusCount(
      label: data['label'],
      id: data['id'],
      total: data['total'],
      show: data['show'],
      order: data['order'],
      actions: (data['actions'] as List)
          .map((e) => StatusAction.fromMapJson(e))
          .toList(),
    );
  }
}

class StatusAction {
  String? id;
  String? label;

  StatusAction({this.id, this.label});

  factory StatusAction.fromMapJson(Map<String, dynamic> data) {
    return StatusAction(
      id: data['id'],
      label: data['label'],
    );
  }
}
