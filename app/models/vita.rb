class Vita
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name

  field :first_name
  field :last_name

  field :year_of_birth

  field :role

  field :role_description
  field :key_aspects
  field :soft_skills

  has_mongoid_attached_file :photo

  attr_accessor :photo_url

  def photo_url
    "hallo"
  end

  SkillBox.TYPES.each do |t|
    embeds_many t.pluralize.to_sym
    accepts_nested_attributes_for t.pluralize.to_sym, allow_destroy: true
  end

  ExperienceBox.TYPES.each do |t|
    embeds_many t.pluralize.to_sym
    accepts_nested_attributes_for t.pluralize.to_sym, allow_destroy: true
  end

  embeds_many :projects
  accepts_nested_attributes_for :projects, allow_destroy: true

  embeds_many :languages
  accepts_nested_attributes_for :languages, allow_destroy: true

  belongs_to :user
end

class Language
  include Mongoid::Document

  def self.LEVES
    %w{a b c}
  end

  field :name
  field :level

  embedded_in :vita
end

class Project
  include Mongoid::Document

  field :name
  field :role
  field :customer
  field :task
  field :activity
  field :technical_scope

  field :period_start
  field :period_end


  embedded_in :vita
end
