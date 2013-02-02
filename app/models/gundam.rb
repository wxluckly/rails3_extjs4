class Gundam < ActiveRecord::Base
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
  belongs_to :raw_gundam
  belongs_to :period
  belongs_to :usage
  belongs_to :manufactory
  belongs_to :story
  
  # validations ...............................................................
  validates :model, :presence => true, :uniqueness => {:scope => :period_id, :message => "should have only one model per period", :on => :create}

  # callbacks .................................................................
  before_save :reprocess_avatar, :if => :cropping?
  
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
    tire.search(page: params[:page], per_page: params[:per_page]) do |search|
         search.query do |q|
         #q.match([:event, :message], params[:query]) if params[:query].present?
         q.string params[:query] if params[:query].present?
        end
        #search.filter :term, category_id: params[:category_id] if params[:category_id].present?
        search.sort { by :updated_at, "desc" } if params[:query].blank?
      # raise to_curl
    end
  end

  # public instance methods ...................................................
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end 
  
  def reprocess_avatar
    self.avatar.recreate_versions!
  end  

  # protected instance methods ................................................
  # private instance methods ..................................................

end
