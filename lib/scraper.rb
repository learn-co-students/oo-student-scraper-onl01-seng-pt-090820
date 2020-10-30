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
    html = open(profile_url)
    student_page = Nokogiri::HTML.parse(html)
    social_link_ary = student_page.css(".social-icon-container a").collect {|el| el.values}.flatten
    scraped_profile = {}
    social_link_ary.each do |link|
      if link.match?(/twitter/)
        scraped_profile[:twitter] = link
      elsif link.match?(/linkedin/)
        scraped_profile[:linkedin] = link
      elsif link.match?(/github/)
        scraped_profile[:github] = link
      else
        scraped_profile[:blog] = link
      end
    end
    scraped_profile[:bio] = student_page.css(".description-holder p").text
    # binding.pry
    scraped_profile[:profile_quote] = student_page.css(".profile-quote").text
    # binding.pry
    scraped_profile
  end

end

