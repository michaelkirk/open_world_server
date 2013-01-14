class Payload < ActiveRecord::Base
  belongs_to :point
  attr_accessible :data, :payload_type, :point_id
end
