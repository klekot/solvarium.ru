class User < ActiveRecord::Base
  belongs_to :account
  has_many   :articles
  has_many   :projects
  has_many   :tags
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
