class SkillBox
  include Mongoid::Document

  def self.TYPES
    %w{project_management it_consulting software engineering service_management analytic testing quality_management tool common_software operating_system network programming_language framework markup_language application_server database data_communication hardware }
  end

  def self.LEVELS
    [
        '< 2 Jahre',
        '2-5 Jahre',
        '> 5 Jahre'
    ]
  end

  field :name
  field :level

  embedded_in :vita
end

SkillBox.TYPES.each do |t|
  eval <<-DYNAMIC
    class #{t.classify}  < SkillBox
        field :category, default: "#{t}"
    end
  DYNAMIC
end