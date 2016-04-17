class Account < ActiveRecord::Base
  has_many :user
end
