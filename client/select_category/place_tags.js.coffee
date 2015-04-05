@placeTags = [
  {tag: "accounting", name: "accounting", active: false}
  {tag: "airport", name: "airport", active: false}
  {tag: "amusement_park", name: "amusement_park", active: false}
  {tag: "aquarium", name: "aquarium", active: false}
  {tag: "art_gallery", name: "art_gallery", active: false}
  {tag: "atm", name: "atm", active: false}
  {tag: "bakery", name: "bakery", active: false}
  {tag: "bank", name: "bank", active: false}
  {tag: "bar", name: "bar", active: false}
  {tag: "beauty_salon", name: "beauty_salon", active: false}
  {tag: "bicycle_store", name: "bicycle_store", active: false}
  {tag: "book_store", name: "book_store", active: false}
  {tag: "bowling_alley", name: "bowling_alley", active: false}
  {tag: "bus_station", name: "bus_station", active: false}
  {tag: "cafe", name: "cafe", active: false}
  {tag: "campground", name: "campground", active: false}
  {tag: "car_dealer", name: "car_dealer", active: false}
  {tag: "car_rental", name: "car_rental", active: false}
  {tag: "car_repair", name: "car_repair", active: false}
  {tag: "car_wash", name: "car_wash", active: false}
  {tag: "casino", name: "casino", active: false}
  {tag: "cemetery", name: "cemetery", active: false}
  {tag: "church", name: "church", active: false}
  {tag: "city_hall", name: "city_hall", active: false}
  {tag: "clothing_store", name: "clothing_store", active: false}
  {tag: "convenience_store", name: "convenience_store", active: false}
  {tag: "courthouse", name: "courthouse", active: false}
  {tag: "dentist", name: "dentist", active: false}
  {tag: "department_store", name: "department_store", active: false}
  {tag: "doctor", name: "doctor", active: false}
  {tag: "electrician", name: "electrician", active: false}
  {tag: "electronics_store", name: "electronics_store", active: false}
  {tag: "embassy", name: "embassy", active: false}
  {tag: "establishment", name: "establishment", active: false}
  {tag: "finance", name: "finance", active: false}
  {tag: "fire_station", name: "fire_station", active: false}
  {tag: "florist", name: "florist", active: false}
  {tag: "food", name: "food", active: false}
  {tag: "funeral_home", name: "funeral_home", active: false}
  {tag: "furniture_store", name: "furniture_store", active: false}
  {tag: "gas_station", name: "gas_station", active: false}
  {tag: "general_contractor", name: "general_contractor", active: false}
  {tag: "grocery_or_supermarket", name: "grocery_or_supermarket", active: false}
  {tag: "gym", name: "gym", active: false}
  {tag: "hair_care", name: "hair_care", active: false}
  {tag: "hardware_store", name: "hardware_store", active: false}
  {tag: "health", name: "health", active: false}
  {tag: "hindu_temple", name: "hindu_temple", active: false}
  {tag: "home_goods_store", name: "home_goods_store", active: false}
  {tag: "hospital", name: "hospital", active: false}
  {tag: "insurance_agency", name: "insurance_agency", active: false}
  {tag: "jewelry_store", name: "jewelry_store", active: false}
  {tag: "laundry", name: "laundry", active: false}
  {tag: "lawyer", name: "lawyer", active: false}
  {tag: "library", name: "library", active: false}
  {tag: "liquor_store", name: "liquor_store", active: false}
  {tag: "local_government_office", name: "local_government_office", active: false}
  {tag: "locksmith", name: "locksmith", active: false}
  {tag: "lodging", name: "lodging", active: false}
  {tag: "meal_delivery", name: "meal_delivery", active: false}
  {tag: "meal_takeaway", name: "meal_takeaway", active: false}
  {tag: "mosque", name: "mosque", active: false}
  {tag: "movie_rental", name: "movie_rental", active: false}
  {tag: "movie_theater", name: "movie_theater", active: false}
  {tag: "moving_company", name: "moving_company", active: false}
  {tag: "museum", name: "museum", active: false}
  {tag: "night_club", name: "night_club", active: false}
  {tag: "painter", name: "painter", active: false}
  {tag: "park", name: "park", active: false}
  {tag: "parking", name: "parking", active: false}
  {tag: "pet_store", name: "pet_store", active: false}
  {tag: "pharmacy", name: "pharmacy", active: false}
  {tag: "physiotherapist", name: "physiotherapist", active: false}
  {tag: "place_of_worship", name: "place_of_worship", active: false}
  {tag: "plumber", name: "plumber", active: false}
  {tag: "police", name: "police", active: false}
  {tag: "post_office", name: "post_office", active: false}
  {tag: "real_estate_agency", name: "real_estate_agency", active: false}
  {tag: "restaurant", name: "restaurant", active: false}
  {tag: "roofing_contractor", name: "roofing_contractor", active: false}
  {tag: "rv_park", name: "rv_park", active: false}
  {tag: "school", name: "school", active: false}
  {tag: "shoe_store", name: "shoe_store", active: false}
  {tag: "shopping_mall", name: "shopping_mall", active: false}
  {tag: "spa", name: "spa", active: false}
  {tag: "stadium", name: "stadium", active: false}
  {tag: "storage", name: "storage", active: false}
  {tag: "store", name: "store", active: false}
  {tag: "subway_station", name: "subway_station", active: false}
  {tag: "synagogue", name: "synagogue", active: false}
  {tag: "taxi_stand", name: "taxi_stand", active: false}
  {tag: "train_station", name: "train_station", active: false}
  {tag: "travel_agency", name: "travel_agency", active: false}
  {tag: "university", name: "university", active: false}
  {tag: "veterinary_care", name: "veterinary_care", active: false}
  {tag: "zoo", name: "zoo", active: false}
]

Meteor.startup ->
  $('body').on "click", ".toggle", (elem) ->
    tagName = $(@).data().tag
    tag = placeTags.filter (tag) ->
      tag.tag == tagName
    tag[0].active = $(@).hasClass('active')

Template.selectCategory.helpers
  placeTags: placeTags
