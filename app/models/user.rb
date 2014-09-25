class User
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :user_repos, :favourite_lang

  validates :name, :presence => true
  validates :name, format: { with: /\A[\w\.\-@]+\z/, message: "name contains invalid character" }

  def initialize
    self.user_repos = {}
  end

  # Hack for schemaless model to make it work with form_for
  def persisted?
    false
  end

  # Loads repos from GitHub
  def get_favourite_lang
    repos = Github.repos.list user: self.name

    repos.each{|repo| language_counter repo['language']}
    self.favourite_lang = self.user_repos.max_by{|k,v| v}.first
  end

  private

  # Counts favourite languages
  def language_counter lang
    if self.user_repos[lang].blank?
      self.user_repos[lang] = 1
    else
      self.user_repos[lang] += 1
    end
  end
end
