class Todo < ApplicationRecord
  belongs_to :project
  before_save :default_values
  def default_values
    self.isCompleted ||= false 
  end
end
