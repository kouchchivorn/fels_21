class Category < ActiveRecord::Base
    has_many :words
    has_many :lessons, dependent: :destroy

    validates_presence_of :name
    validates_uniqueness_of :name

    scope :search, -> (content) do
        where("name LIKE ?", "%#{content}%")
    end

    def to_s
        name
    end
end
