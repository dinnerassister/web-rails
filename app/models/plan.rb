class Plan < ActiveRecord::Base
  has_many :meal, dependent: :delete_all

  def meals

  end
end
