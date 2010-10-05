require 'active_record'
require 'active_support/concern'

module Ownable
  
  # Add acts_as_ownable to ActiveRecord subclasses  
  module ActsAsOwnable extend ActiveSupport::Concern
      
    module ClassMethods
      
      def acts_as_ownable(options = {})
        cattr_accessor :ownable_through 
        
        self.ownable_through = options[:through] || [':user']
      end

    end #ClassMethods
     
    # Add owned_by? and belongs_to? to ActiveRecord subclasses
    module InstanceMethods

      def owned_by? candidate
        owner = find_owner

        return false if (owner.nil? || candidate.nil?)
        return candidate == owner.id if candidate.is_a? Fixnum
        return candidate == owner          
      end
        
      def belongs_to? candidate
        owned_by? candidate
      end
      
      private 
        
      def find_owner
        owner = self  
            
        self.ownable_through.each do |class_name|          
          begin       
            owner =   owner.send class_name
          rescue      
            owner =   nil
          end         
        end           
            
        return owner  
      end             
      
    end #InstanceMethods
    
  end #ActsAsOwnable
  
end #Ownable