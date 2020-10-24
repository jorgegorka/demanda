function countriesForSelect(countries) {
  const selectCountries = countries.map((country) => ({
    id: country.id,
    name: JSON.parse(country.translations).es,
  }));

  return selectCountries.sort(sortByName);
}

function sortByName(a, b) {
  if (a.name < b.name) {
    return -1;
  }
  if (a.name > b.name) {
    return 1;
  }

  return 0;
}

export { countriesForSelect };
