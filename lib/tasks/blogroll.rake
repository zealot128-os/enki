
namespace :blogroll do

  desc "Blogroll tumblr"
  task :tumblr => :environment do
    require "nokogiri"
    require "open-uri"
    doc = Nokogiri.parse(open("http://feeds.feedburner.com/stefanwienerttumblr?format=xml"))
    items = doc.search("item").map{|i| [i.search("title").text, i.search("guid").text, DateTime.parse(i.search("pubdate").text)]}[0...5]
    source =items.map do |title,link,date|
      "<ul><a href='#{link}' target='_blank'>#{title}</a>
      <span class='date'>#{I18n.l(date)}</span>
      </ul>"
    end.join
    File.open("#{Rails.root}/tmp/tumblr.cache", "w+") { |f| f.write source}


  end
end

