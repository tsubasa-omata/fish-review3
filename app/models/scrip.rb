class Scrip < ApplicationRecord
  require 'mechanize'
  def self.sc
    agent = Mechanize.new
    page = agent.get("https://www.zukan-bouz.com/index/%E9%AD%9A%E9%A1%9E")
    elements = page.search('div.idxcol a')
    ActiveRecord::Base.transaction do
      elements.each do |element|
        fish = Fish.new
        fish.name = element.inner_text
        fish.save!
      end
    end
  end

end