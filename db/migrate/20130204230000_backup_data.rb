class BackupData < ActiveRecord::Migration
  def change
    source = File.new(Rails.root.join("db","sql","data.sql"), "r")
    while (line = source.gets)
      begin
        execute line
      rescue => e
        Rails.logger.error e.inspect
      end
    end
    source.close
  end
  # execute "use rails3_extjs4"
  # execute "source #{Rails.root.join('db','sql','test.sql')}"
end