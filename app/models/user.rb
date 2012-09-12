class User < ActiveRecord::Base
  authenticated_by_shibboleth
  attr_accessible :emplid, :name_n
end
