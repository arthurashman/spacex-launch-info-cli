require 'httparty'
require 'colorize'

def title(content)
  puts ""
  puts " -----------------------------"
  puts " #{content} ".blue.on_white.bold
  puts " -----------------------------"
  puts ""
end

title("Welcome to SpaceX Launch Info")

rockets = HTTParty.get("https://api.spacexdata.com/v2/rockets").map {|rocket| rocket["id"]}

puts "We have data available for following rockets:".bold
rockets.each do |rocket|
  print "- "
  puts rocket
end
puts ""

puts "Which rocket do you want to see the launches of: ".bold
selected_rocket = gets.chomp
until rockets.include?(selected_rocket)
  puts "We don't have the data for that rocket, please try again"
  selected_rocket = gets.chomp
end

launch_year = 0

puts "Great! And which year of launches?"
  launch_year = gets.chomp.to_i
until (launch_year > 2005 && launch_year <= Time.now.year)
  puts "I don't think there were any launches that year. Want to try again?"
  launch_year = gets.chomp.to_i
end

response = HTTParty.get("https://api.spacexdata.com/v2/launches?launch_year=#{launch_year}&rocket_id=#{selected_rocket}")
File.write("api_call_logs/spacex-api-call-#{Time.now}.log", "Request made at #{Time.now}, and api responded in #{response.response["spacex-api-response-time"]}")

while response.empty? && launch_year != 0
  puts "It looks like there were no launches that year. Do you want to try again? Type 0 to exit"
  launch_year = gets.chomp.to_i
  response = HTTParty.get("https://api.spacexdata.com/v2/launches?launch_year=#{launch_year}&rocket_id=#{selected_rocket}")
  File.write("api_call_logs/spacex-api-call-#{Time.now}.log", "Request made at #{Time.now}. API responded in #{response.response["spacex-api-response-time"]}")
end

if launch_year == 0
  abort title("Thanks for using SpaceX Launch Info")
end

puts ""
print "-- Launches --".bold.light_yellow

response.each do |flight| 
  puts ""
  puts "---------------------".light_blue
  print "Flight number: ".magenta.bold
  puts flight["flight_number"]
  puts ""
  print "Date of flight: ".magenta.bold
  puts flight["launch_date_utc"][0...10]
  puts ""
  print "Rocket: ".magenta.bold
  puts flight["rocket"]["rocket_name"]
  puts ""
  print "Launch site: ".magenta.bold
  puts flight["launch_site"]["site_name_long"]
  puts ""
  print "Details: ".magenta.bold
  puts flight["details"]
  puts "---------------------".light_blue
end

title("Thanks for using SpaceX Launch Info")