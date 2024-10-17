class DashboardConstants {
  DashboardConstants._();

  static const upcomingExpiryReport = [
    "Expiry in next (1-3) days",
    "Expiry in next (4-7) days",
    "Expiry in next (7-30) days",
    "Expired Active Members",
  ];

  static const registartionReport = [
    "Total Members",
    "Active Members",
    "Expired Members",
    "Blocked Members"
  ];

  static const filterByActiveStatusDropdownOptions = [all, active, inActive];

  static const filterByPackageExpiry = [
    "Select Filter",
    oneToThreeDaysFilter,
    fourToSevenDaysFilter,
    twoWeeksFilter,
    expired
  ];

  static const String all = "All";
  static const String active = "Active";
  static const String inActive = "InActive";
  static const String oneToThreeDaysFilter = "1-3 days";
  static const String fourToSevenDaysFilter = "4-7 days";
  static const String twoWeeksFilter = "2 weeks";
  static const String expired = "expired";
}
