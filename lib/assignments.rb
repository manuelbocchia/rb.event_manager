require 'csv'
require 'time'

content = CSV.open('event_attendees.csv', headers:true, header_converters: :symbol) if File.exist?('event_attendees.csv')

def check_phone(number)
    number = number.scan(/\d/).join('')
    if number.length == 10
      number
    elsif number.length == 11 && number.match(/^1/)
      number.slice(1,10)
    else
      "Wrong number"
    end

  end

# content.each do |row|
#     puts check_phone(row[5])
# end

time_and_date = []

content.each do |row|
  time_and_date << Time.strptime(row[1], "%m/%d/%y %H:%M")
end

only_times = []

time_and_date.each do |date|
   only_times << date.hour
end

days_week = []

time_and_date.each do |date|
  days_week << date.strftime("%A")
end

most_times = {}

only_times.each do |time|
  most_times[time] = only_times.count(time)
end

best_times = most_times.max(3) {|pair1, pair2| pair1[1] <=> pair2[1]}

weekdays_count = {}

days_week.each do |time|
  weekdays_count[time] = days_week.count(time)
end

best_weekdays = weekdays_count.max(3) {|pair1, pair2| pair1[1] <=> pair2[1]}

p best_weekdays

puts "The times most people connected where at #{best_times[0][0]} hs., #{best_times[1][0]} hs. and #{best_times[2][0]} hs."

puts "The days most people connected where on #{best_weekdays[0][0]}, #{best_weekdays[1][0]} and #{best_weekdays[2][0]}"

# p only_times
