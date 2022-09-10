require 'csv'

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

content.each do |row|
    puts check_phone(row[5])
end