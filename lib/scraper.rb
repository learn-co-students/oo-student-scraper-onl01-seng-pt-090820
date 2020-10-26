require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    document = Nokogiri::HTML(open(index_url))
    document.css(".student-card").each do |element|
      student_hash = { name: element.css(".student-name").text,
        location: element.css(".student-location").text,
        profile_url: element.css('@href').text
        }
        student_array << student_hash
    end
    return student_array
  end

  def self.scrape_profile_page(profile_url)
    profHash = {}
    document = Nokogiri::HTML(open(profile_url))
    document.css("div.main-wrapper.profile .social-icon-container a").each do |element|
      if (element.attribute("href").value.include?('twitter'))
        profHash[:twitter] = element.attribute("href").value
      elsif (element.attribute("href").value.include?('linkedin'))
        profHash[:linkedin] = element.attribute("href").value
      elsif (element.attribute("href").value.include?('github'))
        profHash[:github] = element.attribute("href").value
      else
        profHash[:blog] = element.attribute("href").value
      end
    end
    profHash[:profile_quote] = document.css(".profile-quote").text.strip
    profHash[:bio] = document.css(".description-holder/p").text.strip
    return profHash
  end
end
