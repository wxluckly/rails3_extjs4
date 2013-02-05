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
  has_many :raw_gundams
  belongs_to :period
  belongs_to :usage
  belongs_to :manufactory
  belongs_to :story
  
  # validations ...............................................................
  validates :model, :presence => true, :uniqueness => {:message => "should have only one model per period", :on => :create}

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
    params[:query] ||= ""
    tire.search(page: params[:page], per_page: params[:per_page]) do
      query do
        boolean do
          should { match :model, params[:query] }
          should { match :name, params[:query] }
          should { match :name_chs, params[:query] }
          must { term :period_id, params[:period_id] } if params[:period_id].present?
        end
      end 
      # filter :range, created_at: {lte: Time.zone.now}
      sort { by :dimension_id, "desc" }
      sort { by :period_id, "asc" }
    end

    # tire.search load: load_value, page: params[:page], per_page: params[:per_page] do
    #   query do
    #     boolean do
    #       should { match :title, params[:q], boost: 10 } if params[:q].present?
    #       should { match :content, params[:q] } if params[:q].present?
    #       must { term :article_category_id, params[:cat] } if params[:cat].present?
    #       must { term :recommend_category_id, params[:r] } if params[:r].present?
    #       must { term :user_id, params[:user_id] } if params[:user_id].present?
    #       must { terms :id, params[:id].split(' ') } if params[:id].present?
    #       must { range :updated_at, gte: params[:start_at], lte: params[:end_at] } if params[:start_at].present? && params[:end_at].present?
    #       must { range :updated_at, gte: params[:updated_at_from], lte: params[:updated_at_to] } if params[:updated_at_from].present? && params[:updated_at_to].present? 
    #     end
    #   end if params.slice(:q, :cat, :r, :user_id, :id, :start_at, :end_at).values.any?(&:present?)

    #   sort { params[:sort].each { |k, v| by k, v } } if params[:sort].present? && params[:q].blank?
    # end

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

  # protected instance methods ................................................
  # private instance methods ..................................................

end
