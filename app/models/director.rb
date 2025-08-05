# == Schema Information
#
# Table name: directors
#
#  id           :bigint           not null, primary key
#  bio          :text
#  dob          :date
#  first_name   :string
#  image        :string
#  last_name    :string
#  movies_count :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Director < ApplicationRecord
end
