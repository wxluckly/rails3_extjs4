class Gundam < ActiveRecord::Base
  WIKI   = Rails.root.join("db", "wiki.git")

  # extends ...................................................................
  # includes ..................................................................
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include MongoSync
  
  # security (i.e. attr_accessible) ...........................................
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :name, :name_chs, :name_jp, :model, :period_id, :period, :usage_id, :usage, :avatar, :remote_avatar_url, :crop_x, :crop_y, :crop_w, :crop_h, :specifications, :internal_environment, :measurement, :weight, :armor, :output, :propulsion, :acceleration, :special_equipped, :default_weapon, :selected_weapon, :hand_weapon, :ranged_weapon, :summary
  
  # relationships .............................................................
  has_many :driver_gundams
  has_many :force_gundams
  has_many :forces, :through => :force_gundams
  has_many :gundam_photos
  has_many :versions, class_name: "GundamVersion"
  has_many :history_versions, class_name: "GundamVersion", conditions: proc{ "id <= #{self.version_id||0}" }
  has_many :unmerge_versions, class_name: "GundamVersion", conditions: proc{ "id > #{self.version_id||0}" }
  has_many :raw_gundams
  belongs_to :period
  belongs_to :usage
  belongs_to :manufactory
  belongs_to :story
  
	attr_accessible :name, :name_chs, :model, :period_id, :period, :usage_id, :usage, :avatar, :version_id

  mount_uploader :avatar, GundamAvatarUploader

  # validations ...............................................................
  validates :model, :presence => true, :uniqueness => {:message => "should have only one model per period", :on => :create}

  # callbacks .................................................................
  before_save :reprocess_avatar, :if => :cropping?
  after_create  :create_page
  after_update  :update_page
  after_destroy :delete_page

  # 解决mongo数据无法被同步更新的问题
  after_save do 
    mongo.update_attribute(:avatar, self.attributes["avatar"])
  end

  # scopes ....................................................................
  scope :from_period, lambda{ |period_id| where(period_id: period_id) if period_id.present?}
  scope :from_dimension, lambda{ |period_id, dimension_id|
    if period_id.blank? and dimension_id.present?
      where(period_id: Period.where(dimension_id: dimension_id).map(&:id))
    end
  }

  # additional config .........................................................
  mount_uploader :avatar, GundamAvatarUploader

  # indexes 
  mapping do
    indexes :id,           index: :not_analyzed
    indexes :name
    indexes :name_chs
    indexes :model
    indexes :updated_at,   type: 'date', include_in_all: false
  end
  # attr_accessor :story_name, :usage_name, :manufactory_name, :force_name, :period_name
  # def init_names
  #   %w{story usage manufactory force period}.each do |source|
  #     if send("#{source}_name").present?
  #       instance_variable_set("#{source}_class_id") = source.classify.constantize.where(name: send("#{source}_name")).first_or_create
  #       send("#{source}_id=(#{instance_variable_get("#{source}_class_id")})")
  #     end
  #   end
  # end

  # class methods .............................................................
  def self.search_by_keywords(params = {})
    tire.search(page: params[:page], per_page: params[:per_page]) do
      query do |q|
        q.string params[:query], default_operator: "AND"
      end if params[:query].present?
      filter :range, created_at: {lte: Time.zone.now}
      sort { by :updated_at, "desc" } if params[:query].blank?
    end
  end

  # public instance methods ...................................................
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end 
  
  def reprocess_avatar
    self.avatar.recreate_versions!
  end

  def to_indexed_json
    to_json(:methods => [:period_year, :period_name, :dimension_name])
  end

  def period_year
    period.try(:year)
  end

  def period_name
    period.try(:name)
  end

  def dimension_name
    period.try(:dimension).try(:name)
  end

  def page
    wiki.page(page_name)
  end

  def page_name
    "gundam-#{id}"
  end

  def wiki
    @@golum ||= Gollum::Wiki.new(WIKI)
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
 private

  def commit
    commit = { :message => 'commit message',
           :name => 'Gollum',
           :email => 'freebird0221@gmail.com' }
  end

  def create_page
    wiki.write_page(page_name, :rdoc, to_yaml, commit)
  end

  def update_page
    # fio = File.new("wiki/gundam-#{id}",'w+')
    # fio.write(to_yaml)
    # fio.close
    if page
      wiki.update_page(page, page_name, page.format, 'Page contents', commit)
    else
      create_page
    end
  end

  def delete_page
    # File.unlink("wiki/gundam-#{id}.wiki.yaml")
    wiki.delete_page(page, commit)
  end
end
