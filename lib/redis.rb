require 'uri'

class Redis
  # 带集群的初始化
  def initialize_with_string(options = {})
    if options.is_a?(String)
      server = URI(options)
      options = {host: server.host, port: server.port, password: server.password, db: server.path[1..-1].to_i}
    end
    initialize_without_string(options)
  end
  alias_method_chain :initialize, :string

  # 是否在线
  def up?
    ping == 'PONG' rescue false
  end
  
  # 是否正在同步
  def syncing?
    info['master_sync_in_progress'] == '1'
  end
  
  # 是否主服状态
  def master?
    info['role'] == 'master'
  end
  
  # 是否从服状态
  def slave?
    !master?
  end
  
  # 设置服务器为主服
  def tobe_master
    slaveof('NO', 'ONE')
  end
  
  # 设置服务器为主服的从服
  def tobe_slaveof(master_server)
    master_uri = URI(master_server)
    slaveof(master_uri.host, master_uri.port)
  end
  
  # 重写二进制日志文件
  def rewrite_aof
    bgrewriteaof if info['bgrewriteaof_in_progress'] == '0'
  end
  
  class Client
    # 抑制redis连接异常，使得resque:workers和resque:scheduler两个rake不至于因为异常而退出
    def process_with_exception_suppressed(*commands)
      process_without_exception_suppressed(*commands) do
        yield
      end
    rescue Exception  # , RuntimeError
    end
    # alias_method_chain :process, :exception_suppressed
  end
end
