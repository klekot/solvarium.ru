class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :articles
  has_many :todos, dependent: :destroy
end