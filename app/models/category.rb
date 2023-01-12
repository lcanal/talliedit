class Category < ApplicationRecord
  has_many :tallies, :dependent => :destroy
end
