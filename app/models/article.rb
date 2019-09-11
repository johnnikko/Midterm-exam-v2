class Article < ActiveRecord::Base
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category
end