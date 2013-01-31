module VersionsHelper
  include HTMLDiff
  def showdiff(gundam,version,*attr_names)
    gundam_attr = gundam
    version_attr = version
    attr_names.each do |attr_name|
      gundam_attr = gundam_attr.try(attr_name)
      version_attr = version_attr.try(attr_name)
    end
    version_attr.nil? ? gundam_attr : diff(gundam_attr,version_attr)
  end
end
