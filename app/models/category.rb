class Category < ActiveRecord::Base
    has_many :words
    has_many :lessons, dependent: :destroy

    validates_presence_of :name
    validates_uniqueness_of :name
end
