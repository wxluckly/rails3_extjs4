namespace :spider do
  desc "spider for cnmsl."
  task :get_cnmsl => :environment do
    p "begin"
    Spider::CNMSL.get_infos
    p "done!"
  end
end