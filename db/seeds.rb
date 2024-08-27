# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# SEEDS FOR AIRLINE MODEL

puts "Destroying existing airlines..."
Airline.destroy_all

puts "Creating airlines ✈️"
klm = {name: "KLM"}
transavia = {name: "Transavia"}
easyjet = {name: "EasyJet"}
wizzair = {name: "WizzAir"}
lufthansa = {name: "Lufthansa"}

[klm, transavia, easyjet, wizzair, lufthansa].each do |attributes|
  airline = Airline.create(attributes)
  puts "#{airline.name} has been added to Airlines. ✈️"
end

# SEEDS FOR POLICY MODEL

puts "Destroying existing policies..."
Policy.destroy_all

puts "Creating baggage policies 📃"
klm = Airline.find_by(name: 'KLM')
transavia = Airline.find_by(name: 'Transavia')
easyjet = Airline.find_by(name: 'EasyJet')
wizzair = Airline.find_by(name: 'WizzAir')
lufthansa = Airline.find_by(name: 'Lufthansa')

Policy.create([
  # KLM Policies
  {
    airline_id: klm.id,
    category: "cabin baggage",
    title: "Economy Class Hand Baggage",
    content: "Passengers are allowed to bring 1 piece of hand baggage with a maximum size of 55 x 35 x 25 cm, including handles and wheels. Additionally, 1 accessory (such as a handbag or laptop bag) with a maximum size of 40 x 30 x 15 cm is allowed. The combined weight of these items must not exceed 12 kg."
  },
  {
    airline_id: klm.id,
    category: "checked baggage",
    title: "Checked Baggage for Economy Class",
    content: "Light ticket: no checked baggage included. Standard or Flex ticket: 1 item of checked baggage, up to 158 cm (length + width + height) including handles and wheels and with a maximum weight of 23 kg."
  },
  {
    airline_id: klm.id,
    category: "special baggage",
    title: "For Kids",
    content: "For each child, you can bring a buggy, stroller, or back carrier without any additional costs. If you bring a collapsible umbrella stroller with a maximum size of 15 x 30 x 100 cm, you can take it into the cabin."
  },
  {
    airline_id: klm.id,
    category: "special baggage",
    title: "Sports Equipment",
    content: "Sports equipment such as skis or snowboards can be transported. If replacing a checked baggage item, there is no extra charge. For additional sports equipment, charges apply depending on the route and season."
  },
  {
    airline_id: klm.id,
    category: "special baggage",
    title: "Pets",
    content: "Small pets are allowed in the cabin if they fit in a kennel under the seat in front of you. The maximum dimensions of the kennel are 46 x 28 x 24 cm, and the combined weight of the pet and kennel must not exceed 8 kg."
  },

  # Transavia Policies
  {
    airline_id: transavia.id,
    category: "cabin baggage",
    title: "Economy Class Hand Baggage",
    content: "Maximum of 1 piece of hand baggage with dimensions up to 55 x 40 x 25 cm. Weight should not exceed 10 kg."
  },
  {
    airline_id: transavia.id,
    category: "checked baggage",
    title: "Checked Baggage for Economy Class",
    content: "Passengers can check in baggage with a maximum weight of 20 kg. Baggage fees vary depending on the route and are charged per item."
  },
  {
    airline_id: transavia.id,
    category: "special baggage",
    title: "For Kids",
    content: "You may take one pram, one folding umbrella buggy, or one travel buggy with a maximum weight of 10 kg for each child. It must be checked in at the check-in desk."
  },
  {
    airline_id: transavia.id,
    category: "special baggage",
    title: "Sports Equipment",
    content: "Sports equipment, such as bicycles, can be transported in the hold. Bicycles must be packed in a bike box or bike bag, and the total weight must not exceed 23 kg."
  },
  {
    airline_id: transavia.id,
    category: "special baggage",
    title: "Pets",
    content: "Small pets are allowed in the cabin, provided they are transported in a suitable travel container with maximum dimensions of 47 x 30 x 27 cm and a weight not exceeding 10 kg."
  },

  # EasyJet Policies
  {
    airline_id: easyjet.id,
    category: "cabin baggage",
    title: "Free Carry-on Baggage",
    content: "All passengers are allowed one free carry-on bag with their ticket. The dimensions must not exceed 56 x 45 x 25 cm, including handles and wheels."
  },
  {
    airline_id: easyjet.id,
    category: "checked baggage",
    title: "Checked Baggage",
    content: "Passengers can check up to three bags per person with options of 15 kg or 23 kg per bag. The maximum total size for any checked bag is 275 cm (height + width + length)."
  },
  {
    airline_id: easyjet.id,
    category: "special baggage",
    title: "For Kids",
    content: "Each child can have a stroller or car seat checked free of charge. Strollers and car seats must be checked at the gate and collected at the baggage claim upon arrival."
  },
  {
    airline_id: easyjet.id,
    category: "special baggage",
    title: "Sports Equipment",
    content: "Sports equipment, such as skis, snowboards, and golf clubs, can be checked in. Charges apply based on the type of equipment and route."
  },
  {
    airline_id: easyjet.id,
    category: "special baggage",
    title: "Pets",
    content: "Pets are not allowed in the cabin or hold on EasyJet flights, except for registered assistance dogs."
  },

  # Wizz Air Policies
  {
    airline_id: wizzair.id,
    category: "cabin baggage",
    title: "Basic Cabin Bag",
    content: "Passengers are allowed one free cabin bag with dimensions of 40 x 30 x 20 cm. For additional cabin bags or larger items, a fee applies."
  },
  {
    airline_id: wizzair.id,
    category: "checked baggage",
    title: "Checked Baggage",
    content: "Checked baggage options are available in 10 kg, 20 kg, and 32 kg sizes. Fees vary depending on the route and time of booking."
  },
  {
    airline_id: wizzair.id,
    category: "special baggage",
    title: "For Kids",
    content: "Passengers can bring one collapsible stroller free of charge per child. The stroller must be checked in at the boarding gate."
  },
  {
    airline_id: wizzair.id,
    category: "special baggage",
    title: "Sports Equipment",
    content: "Sports equipment like bicycles and surfboards can be checked in for an additional fee. Equipment must not exceed 32 kg."
  },
  {
    airline_id: wizzair.id,
    category: "special baggage",
    title: "Pets",
    content: "Only service animals are allowed in the cabin on Wizz Air flights. No other pets are permitted in the cabin or hold."
  },

  # Lufthansa Policies
  {
    airline_id: lufthansa.id,
    category: "cabin baggage",
    title: "Economy and Premium Economy Cabin Baggage",
    content: "Passengers are allowed one carry-on baggage item with a maximum size of 55 x 40 x 23 cm and one personal item, such as a laptop bag or handbag."
  },
  {
    airline_id: lufthansa.id,
    category: "checked baggage",
    title: "Checked Baggage for Economy Class",
    content: "Passengers can check one piece of baggage up to 23 kg for Economy Class. For Premium Economy Class, two pieces are allowed, each up to 23 kg."
  },
  {
    airline_id: lufthansa.id,
    category: "special baggage",
    title: "For Kids",
    content: "Children under 2 years are entitled to one checked baggage item up to 23 kg, in addition to a stroller or car seat."
  },
  {
    airline_id: lufthansa.id,
    category: "special baggage",
    title: "Sports Equipment",
    content: "Bicycles, surfboards, and other large sports equipment can be transported for an additional fee. The fees and handling procedures vary by item size and weight."
  },
  {
    airline_id: lufthansa.id,
    category: "special baggage",
    title: "Pets",
    content: "Small pets can travel in the cabin in an approved carrier that fits under the seat. The maximum weight, including the carrier, is 8 kg. Larger pets can travel in the hold in an appropriate pet crate."
  }
])

puts "Policies have been created for each airline ✅"
