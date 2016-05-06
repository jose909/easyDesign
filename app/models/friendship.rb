class Friendship < ActiveRecord::Base
  belongs_to :usario
  belongs_to :friend, class_name: "Usario"
end
