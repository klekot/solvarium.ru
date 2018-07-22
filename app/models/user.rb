class User < ActiveRecord::Base
  belongs_to :account
  has_many   :articles
  has_many   :tags
  has_many   :messages
  has_many   :projects, foreign_key: "creator_id", class_name: "Project"
  has_and_belongs_to_many :projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
