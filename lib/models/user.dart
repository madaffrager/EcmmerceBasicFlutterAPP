class AddressModel {
  String nom;
  String mobile;
  String rue;
  String ville;
  String zip;

  AddressModel({
    this.nom,
    this.mobile,
    this.rue,
    this.ville,
    this.zip,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    mobile = json['mobile'];
    rue = json['rue'];
    ville = json['ville'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['mobile'] = this.mobile;
    data['rue'] = this.rue;
    data['ville'] = this.ville;
    data['zip'] = this.zip;

    return data;
  }
}
