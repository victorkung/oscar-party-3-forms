# == Schema Information
#
# Table name: movies
#
#  id           :bigint           not null, primary key
#  description  :text
#  duration     :integer
#  image        :string
#  oscar_cohort :integer
#  released_on  :date
#  result       :string           default("nominated")
#  title        :string
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  director_id  :integer
#
class Movie < ApplicationRecord
end
