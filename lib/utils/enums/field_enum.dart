enum FieldsEnum {
  Username("Username"),
  Password("Password"),
  Email("Email"),
  VehicleBrand("VehicleBrand"),
  VehicleHp("VehicleHp"),
  VehicleModel("VehicleModel"),
  VehicleDescription("VehicleDescription"),
  Title("Title"),
  Description("Description"),
  Date("Date");

  const FieldsEnum(this.value);
  final String value;
}