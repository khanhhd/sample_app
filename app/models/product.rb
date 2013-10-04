class Product < ActiveRecord::Base
  belongs_to :customer
  has_many :manufacturers, dependent: :destroy
  accepts_nested_attributes_for :manufacturers
end
