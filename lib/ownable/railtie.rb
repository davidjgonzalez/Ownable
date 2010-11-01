require 'ownable'
require 'rails'

module Ownable
  class Railtie < Rails::Railtie
    
    initializer 'ownable.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send :extend, Ownable::ActsAsOwnable::ClassMethods
          ActiveRecord::Base.send :include, Ownable::ActsAsOwnable::InstanceMethods
      end  
    end
    
  end
end