require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    html = open(index_url)
    list_hash = Nokogiri::HTML.parse(html)
    student_scraper = list_hash.css(".roster-cards-container .student-card").collect do |student_hash|
      # binding.pry
      assignment_hash = {}
      assignment_hash[:name] = student_hash.css(".student-name").text
      assignment_hash[:location] = student_hash.css(".student-location").text
      assignment_hash[:profile_url] = student_hash.css("a").first.values.first
      assignment_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

