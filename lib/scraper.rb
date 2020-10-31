require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    na = doc.css("div.student-card")
    
    students = []
    
    na.each do |student|
      hash = {}
      hash[:name] = student.css(".card-text-container .student-name").text
      hash[:location] = student.css(".card-text-container .student-location").text
      hash[:profile_url] = student.css("a").attribute('href').value
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    hash = {}
    
    hash[:bio] = doc.css(".details-container .description-holder p").text
    hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    
    social_media = doc.css(".vitals-container .social-icon-container")
    social_media.css("a").each do |media| 
      # binding.pry
      if media.css(".social-icon").attr('src').value == "../assets/img/twitter-icon.png"
        hash[:twitter] = media.attr('href')
      end 
      if media.css(".social-icon").attr('src').value == "../assets/img/linkedin-icon.png"
        hash[:linkedin] = media.attr('href')
      end 
      if media.css(".social-icon").attr('src').value == "../assets/img/github-icon.png"
        hash[:github] = media.attr('href')
      end 
      if media.css(".social-icon").attr('src').value == "../assets/img/rss-icon.png"
        hash[:blog] = media.attr('href')
      end 
    end
    hash
  end
  
end

    


