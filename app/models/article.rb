require 'elasticsearch/model'

class Article < ActiveRecord::Base
  has_many                :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :projects
  belongs_to              :user
  
  #accepts_nested_attributes_for :projects

  scope :common,  -> { Article.where(common: true) }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
Article.import force: true # for auto sync model with elastic search
