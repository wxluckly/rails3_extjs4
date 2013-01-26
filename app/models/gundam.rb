class Gundam < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include MongoSync

  has_many :driver_gundams
  has_many :force_gundams
  has_many :forces, :through => :force_gundams
  belongs_to :period
  belongs_to :usage
  belongs_to :manufactory
  belongs_to :story
  
	attr_accessible :name, :name_chs, :model, :period_id, :period, :usage_id, :usage, :avatar

  mount_uploader :avatar, GundamAvatarUploader

  validates :model, :presence => true, :uniqueness => {:scope => :period_id, :message => "should have only one model per period", :on => :create}

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


  # 解决mongo数据无法被同步更新的问题
  after_save do 
    mongo.update_attribute(:avatar, self.attributes["avatar"])
  end

end
