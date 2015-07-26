class Plan < ActiveRecord::Base
  attr_accessor :meals

  def size
    @size ||= (end_date - start_date).to_i.abs + 1
  end
end
