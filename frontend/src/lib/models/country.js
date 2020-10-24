import { Countries } from "../database/countries";

class CountryModel {
  static find(params) {
    return Countries.find(params);
  }

  static findOne(countryId) {
    return Countries.findOne(countryId);
  }
}

export { CountryModel };
