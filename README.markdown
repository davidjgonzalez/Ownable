## INTRODUCTION

Ownable gem helps you verify the "ownership" of a associated models in Rails 3. 

The term "ownership" in the contact of Ownable is the association between two models, usually a User Model (though any model can do) and some other Model.

Ownable exposes an instance method on ActiveRecord objects that declare themselves to be acts_as_ownable:

	owned_by? (and its alias belongs_to?)

For example, assume the associations:

	User has_many Orders has_one Invoice has_many Payments
	
Determine if a User "owns" a particular Payment object
	
	Rather than manually defining and then checking the association between User and Payment like:
		@payment.invoice.order.user == current_user # => true/false
		
	you can use Ownable for a much shorter and simpler syntax:
	   @payment.owned_by? current_user # => true/false

## INSTALLATION
  
Ownable is currently available only in Gem form and requires version >= 3.0 of Rails.

You just have to add the 'ownable' gem to your Gemfile

    gem 'ownable'

Then tell bundler to update the gems :

    $ bundle install
    
## USE

In each Model define the associations from the Model to the "Owner" model (which will be User in this example)

Assuming a set of Model associations as follows:

	User has_many Orders has_one Invoice has_many Payments
	
Ownable is added to the Payment Model using "acts_as_ownable"

	class Payment < ActiveRecord::Base  
	  acts_as_ownable :through => [:invoice, :order, :user]
		...
	end
	
The "acts_as_ownable" method call takes a hash with key :through with an Array value. 
The Array is a list of the Model names that define the association path from the current Model back to, 
and including the "Owner" model. Important note: The last item in the array is always the "Owner" model name.
	
Now all Payment objects will have the instance methods:
	
	@payment.owned_by?(ActiveRecord Object)
	@payment.owned_by?(Fixnum Id)
	
or using the belongs_to? alias

	@payment.belongs_to?(ActiveRecord Object)
	@payment.belongs_to?(Fixnum Id)
	
Note that when declaring acts_as_ownable in the Models, the last Model name in the array must be the "Owner" model name.
Also, this only works when each upstream association returns a single object. For example, the following will NOT work:

	Publisher has_many Authors has_and_belongs_to_many Books 


	class Book < ActiveRecord::Base  
	  acts_as_ownable :through => [:author, :publisher]
		...
	end


	@book.owned_by? Publisher.first
	
This will not work because several authors may have co-authored a Book so there is multiple paths back to the "Owner" model (the Publisher). 
At this time this gem does not support these relationships.

## THANKS

Thanks to jlecour's (http://github.com/jlecour) geokit-rails project for helping me understand how to build a gem that plays well with Rails 3.