namespace :data do
  desc "transport raw to gundam"
  task :process_raw_gundam => :environment do
    RawGundam.not_processed.each do |raw_gundam|
      gundam = Gundam.new(raw_gundam.attributes.slice("name", "name_chs", "model", "name_jp", "specifications", "internal_environment", "measurement", "weight", "armor", "output", "propulsion", "acceleration", "special_equipped", "default_weapon", "selected_weapon", "hand_weapon", "ranged_weapon", "summary"))
      if gundam.save
        raw_gundam.update_attributes(is_processed: true, gundam_id: gundam.id)
        p "gundam.#{gundam.id} created"
      else
        gundam = Gundam.where(model: raw_gundam.model).first
        if gundam.present?
          gundam.raw_gundams << raw_gundam
          gundam.save
          raw_gundam.update_attributes(is_processed: true)
          p "raw_gundam.#{raw_gundam.id} processed"
        end
      end
    end
  end

  desc "synchronize mysql data to mongo"
  task :sync_mongo => :environment do
    p "make sure you have deleted your mongo data ... work begining :"
    Dimension.all.each{ |i| i.mongo_save }
    Driver.all.each{ |i| i.mongo_save }
    Force.all.each{ |i| i.mongo_save }
    ForceGundam.all.each{ |i| i.mongo_save }
    Gundam.all.each do |i|
      i.mongo_save
      obj = GundamMongo.find(i.id)
      obj.write_uploader("avatar", i.read_uploader("avatar"))
      obj.save
    end
    GundamPhoto.all.each do |i|
      i.mongo_save
      obj = GundamPhotoMongo.find(i.id)
      obj.write_uploader("image", i.read_uploader("image"))
      obj.save
    end
    Manufactory.all.each{ |i| i.mongo_save }
    Period.all.each{ |i| i.mongo_save }
    Story.all.each{ |i| i.mongo_save }
    Usage.all.each{ |i| i.mongo_save }

    DriverGundam.all.each{ |i| i.mongo_save }
    p "all done!"
  end

  desc "index all search suggestion"
  task :index_search_suggestion => :environment do
    p "work begining :"
    SearchSuggestion.index_products
    p "all done!"
  end
end