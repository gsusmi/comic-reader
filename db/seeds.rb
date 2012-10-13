# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'yaml'

feeds = YAML.load_file(File.join(Rails.root, 'config/feeds.yml'))

feeds.each { |feed|
  if !Feed.find_by_name(feed['name'])
    Feed.create!(feed.reject { |key, value| key == 'filter' })
  end
}
