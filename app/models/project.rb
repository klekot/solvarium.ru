class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :users
  has_many :todos, dependent: :destroy
end