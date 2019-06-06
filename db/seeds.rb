###########################
### SEED USERS ############
###########################

User.create(
  first_name: 'Admin',
  last_name: 'Admin',
  email: 'hello@world.com',
  username: 'admin',
  password: '123',
  password_confirmation: '123',
  is_admin: true,
  is_sysop: true,
  active: true
)

###########################
### SEED PAGES ############
###########################

Page.find_or_create_by(name: 'Home') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Building') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Residences') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Neighborhood') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'The Team') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Contact') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Availability') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Press') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Legal') do |p|
  p.editable = false
  p.in_primary_nav = true
end

Page.find_or_create_by(name: 'Colophon') do |p|
  p.editable = false
  p.in_primary_nav = true
end

###########################
### SEED TEAM MEMBERS #####
###########################

TEAM_MEMBERS = [
  {
    name: 'Post-Office Architectes',
    description: "Founded in Paris and New York in 2014 by French architects David Fagart
      and Francois Leininger, and Swiss interior designer Line Fontana, POA is an architectural
      office reconfigured to fit the specific creative needs of increasingly complex
      and global urban questions, conceived not as a single production space but as
      a gathering of skills, a network of talents and experiences.",
    url: 'http://www.post-office.archi'
  },
  {
    name: 'Cape Advisors',
    description: "Cape Advisors, Inc. was formed in 1995 by Curtis Bashaw and Craig
      Wood as a real estate development and investment firm. Since its inception, the
      company has completed over $1.5 billion in development projects, principally in
      New York City and New Jersey, including multifamily residential projects, hotels
      and conference centers, land development, retail projects, historic preservation,
      adaptive re-use, and environmentally sensitive projects ranging in size from $5
      million to over $250 million. \r\n\r\nAlways forward thinking, Cape Advisors’
      projects are pioneering and set themselves apart from the competition with an
      attention to context and place, exciting design and high quality construction.
      This detailed, hands-on approach has enabled Cape to consistently outperform our
      competition.",
    url: "http://www.capeadvisors.com"
  },
  {
    name: 'Corcoran Sunshine Marketing Group',
    description: "With over 25 years of experience in marketing and collective sales
      in excess of $35 billion, Corcoran Sunshine Marketing Group is the recognized
      industry leader in the planning, design, marketing, and sale of luxury residential
      development.\r\n\r\nRepresenting properties throughout the United States and in
      select international locations, Corcoran Sunshine Marketing Group’s portfolio
      contains a curated collection of the world’s most desirable new addresses.",
    url: "http://www.corcoransunshine.com"
  },
  {
    name: 'HTO Architects',
    role: 'Executive Architect',
    description: "Founded in 1997, HTO Architect, PLLC is a full service architectural
      firm based in Manhattan, specializing in the design of high-rise residential,
      hospitality, and mixed-use buildings in New York City and beyond. H.T.O. Architect’s
      team is comprised of creative, passionate, and extremely skilled individuals,
      proficient in a comprehensive range of architectural design specialties including
      master planning, ground-up construction, renovations, restorations, landmark preservations,
      zoning analysis, layouts, and interior design.",
    url: "http://www.hto-architect.com"
  }
]

TeamMember.destroy_all

TEAM_MEMBERS.each do |member|
  TeamMember.find_or_create_by(name: member[:name]) do |tm|
    tm.description = member[:description]
    tm.role = member[:role]
    tm.url = member[:url]
    tm.active = true
  end
end

###########################
### SEED PRESS CLIPPINGS ##
###########################

PressClipping.destroy_all

20.times do
  PressClipping.create({
    source: "Agniet explit",
    blurb: "Agniet explit, simint que que vluta volupta ecerro dolore liquas expel Curbed",
    date: Date.parse('12-10-2015')
  })
end

###########################
### SEED UNITS ############
###########################

include ActionView::Helpers::TextHelper

Unit.destroy_all
UnitType.destroy_all

types = 3.times.map do |i|
  UnitType.create({
    name: "Seed Unit Type #{i + 1}",
    number_of_bedrooms: i + 1,
    number_of_bathrooms: i + 1,
    number_of_powder_rooms: 1,
    interior_square_feet: 1234,
    exterior_square_feet: 1234,
    interior_square_meters: 123,
    exterior_square_meters: 123
  })
end

penthouse_type = UnitType.create({
  name: "Seed Unit Type Penthouse",
  number_of_bedrooms: 3,
  number_of_bathrooms: 3,
  number_of_powder_rooms: 1,
  interior_square_feet: 1234,
  exterior_square_feet: 1234,
  interior_square_meters: 123,
  exterior_square_meters: 123,
  penthouse: true
})

types_loop = types.cycle
unit_numbers = %w[2A 3A 4A 5A 6A 2B 3B 4B 5B 6B 2C 3C 4C 5C 6C 7A 7B 8B 9A]
penthouse_numbers = %w[10 11 12]

unit_numbers.each do |door|
  type = types_loop.next
  floor, letter = door.split(//)

  Unit.create({
    floor: floor.to_i,
    letter: letter,
    unit_type: type,
    price: 1_450_000 + (floor.to_i * 50_000)
  })
end

penthouse_numbers.each_with_index do |floor, number|
  Unit.create({
    floor: floor.to_i,
    letter: number + 1,
    unit_type: penthouse_type,
    price: 5_000_000
  })
end
