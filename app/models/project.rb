class Project < ApplicationRecord
  has_many :todos
  validates :title, uniqueness: true
end
