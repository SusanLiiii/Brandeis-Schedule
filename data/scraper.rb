require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'csv'

browser = Watir::Browser.new
browser.goto 'https://www.brandeis.edu/student-activities/clubs-organizations/club-support/event-support/capacities.html'
room_page = Nokogiri::HTML(browser.html)
browser.close

CSV.open("room.csv", "a+") do |csv|
  csv << ["location", "name", "capacity"]

  room_names = ["Shapiro Campus Center", "Other Student Activities Spaces", "Usdan Student Center", "Hassenfeld Conference Center", "Gosman Sports and Convocation Center", "Other Spaces"]
  room_card = room_page.xpath("//div[contains(@class, 'table__scroll')]")
  room_card.each_with_index do |card, index|
    name = room_names[index]
    card.xpath("table[2]/tbody/tr").each do |row|
      location = row.xpath("td[1]")
      if location.first.nil?
        next
      end
      location = location.first.content
      if name.start_with?("Other")
        name = location
      end
      capacity = row.xpath("td[2]").first.content
      csv << [name, location, capacity]
    end
  end
end