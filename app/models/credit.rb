# == Schema Information
#
# Table name: credits
#
#  id         :bigint           not null, primary key
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :integer
#  movie_id   :integer
#
class Credit < ApplicationRecord
  validates(:role, presence: true)
  validates(:actor_id, presence: true)
  validates(:movie_id, presence: true)
end
