class Message < ActiveRecord::Base
  belongs_to :user
  sync :all
end
