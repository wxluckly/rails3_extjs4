CarrierWave.configure do |config|
  config.storage = :aliyun
  config.aliyun_access_id = "fhH7WF6CpwgFJ84c"
  config.aliyun_access_key = 'lI4DHkiFsymzAQ3TVjqwsa5dvk5k08'
  # 你需要在 Aliyum OSS 上面提前创建一个 Bucket
  config.aliyun_bucket = "wxluckly"
  # 是否使用内部连接，true - 使用 Aliyun 局域网的方式访问  false - 外部网络访问
  config.aliyun_internal = true
end