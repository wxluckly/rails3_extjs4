class User < ActiveRecord::Base
  
	attr_accessible :name, :passwd

  validates :name, :length => { :maximum => 10 }
  validates :passwd, :length => { :maximum => 5 }

end
