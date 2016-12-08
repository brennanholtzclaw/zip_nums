require 'csv'

class Location
attr_accessor :city, :state, :zip, :people_counter

  def initialize(zip, city, state)
    @city = city
    @state = state
    @zip = zip
    @people_counter = 0
    @@all.push(self)
  end

  @@all = []

    def self.all
      @@all.uniq
    end
end

puts "zips incoming"

us_zips = CSV.open "usa_zip_codes.csv", headers: true

us_zips.each do |line|
  Location.new(line[0], line[3], line[6] )
end

mvp_zips = CSV.open "mvp_zips.csv", headers: true
counter = 1
mvp_zips.each do |mvp|
  Location.all.each do |loc|
    if loc.zip == mvp[3]
      loc.people_counter +=1
      break
    end
  end
puts counter
counter +=1
end


output = CSV.open("output_file.csv", "w") do |line|
  line << ["zipcode", "city", "state", "counter"]
  Location.all.each do |loc|
    line << [loc.zip, loc.city, loc.state, loc.people_counter] unless loc.people_counter == 0
    puts loc.zip
  end
end
