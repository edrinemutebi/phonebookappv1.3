require 'roo'
namespace :import do
  desc "Import data from spreadsheet"
  task data: :environment do
    puts 'Importing Data'
    data = Roo::Spreadsheet.open('lib/five.xlsx') # open spreadsheet
    headers = data.row(1) # get header row
    data.each_with_index do |row, idx|
      next if idx == 0 # skip header row
      # create hash from headers and cells
      person_data = Hash[[headers, row].transpose]
      # next if user exists
      if Person.exists?(phone: person_data['phone'])
        puts "User with email #{person_data['email']} already exists"
        next
      end
      
      person = Person.new(person_data)
      puts "Saving User with email '#{person.email}'"
      person.save

      
    end
  end
end