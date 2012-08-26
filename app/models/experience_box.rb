class ExperienceBox
  include Mongoid::Document

  def self.TYPES
    %w{certificate education workshop}
  end

  field :name
  field :year

  embedded_in :vita
end

ExperienceBox.TYPES.each do |t|
  eval <<-DYNAMIC
    class #{t.classify}  < ExperienceBox
        field :category, default: "#{t}"
    end
  DYNAMIC
end