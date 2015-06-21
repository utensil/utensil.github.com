# encoding: UTF-8
require './downmark_it'
require './pinyin.rb'
require 'open-uri'
require 'oga'

pinyin = PinYin::PinYin.instance
# paste the newest link here
next_page_link = 'http://utensil-river.diandian.com/post/2015-04-23/40066253870'
stop_link = 'http://utensil-river.diandian.com/post/2014-08-08/40062436157'
doc = Oga.parse_html(open(next_page_link).read)

while true do
  doc.css('.text-post').each do |post|
    title = post.css('h2')[0].inner_text.strip
    puts next_page_link

    #puts pinyin.to_pinyin(title, separator = '-', tone = true) 
    file_name = ''

    datetime = post.css('.date')[0].inner_text.strip.gsub(/[ :]/, '-')

    file_name = "../source/writings/#{datetime}-#{pinyin.to_permlink(title)}.md"

    tags = []
    post.css('p.tags a').each { |tag| tags << tag.inner_text }

    unless File.exist?(file_name)
      File.open(file_name, "w") do |f|
        f.puts "---\r\ntitle: #{title}\r\ntags: #{tags.join ', '}\r\n---\r\n"  
        f.puts DownmarkIt.to_markdown(post.css('.rich-content')[0].to_xml, 'utf-8').gsub(/\r\n\r\n\r\n|\n\n\n/, '\r\n')
      end
    end
  end

  next_page_link = doc.css('.pageturn a.next_page') 

  if next_page_link.size > 0
    next_page_link = next_page_link[0].attr('href').value
    break if next_page_link == stop_link
    doc = Oga.parse_html(open(next_page_link).read)
  else
    break
  end

  sleep(1.0)
end 

