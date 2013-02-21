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

    periods = PeriodMongo.where(dimension_id: params[:dimension_id].to_i).map(&:id) if params[:dimension_id].present?
    periods = params[:period_id] if params[:period_id].present?

    tire.search(page: params[:page] || 1, per_page: params[:per_page] || 20) do
      query do
        boolean do
          should { match :model, params[:query], boost: 10 }
          should { match :name, params[:query], boost: 10 }
          should { match :name_chs, params[:query], boost: 10 }
          should { match :period_name, params[:query] }
          should { match :period_year, params[:query] }
          should { match :dimension_name, params[:query] }
        end
      end if params[:query].present?
      filter :terms, :period_id => periods.to_a if periods.present?
      sort do
        by :dimension_id, "desc"
        by :period_year_sort, "asc"
      end if params[:query].blank?
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
    to_json(:methods => [:period_year, :period_year_sort, :period_name, :dimension_id, :dimension_name])
  end

  def period_year
    period.try(:year)
  end

  def period_year_sort
    period.try(:year).to_i
  end

  def period_name
    period.try(:name)
  end

  def dimension_id
    period.try(:dimension).try(:id)
  end

  def dimension_name
    period.try(:dimension).try(:name)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................

end
