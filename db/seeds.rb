require 'csv'

# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Elements
CSV.foreach(File.expand_path('seeds_elements.csv', File.dirname(__FILE__)), headers: true) do |row|
  Element.create!(row.to_hash)
end

# FormElements
CSV.foreach(File.expand_path('seeds_form_elements.csv', File.dirname(__FILE__)), headers: true) do |row|
  FormElement.create!(row.to_hash)
end