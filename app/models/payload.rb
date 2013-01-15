class Payload < ActiveRecord::Base
  belongs_to :point
  attr_accessible :data, :payload_type, :point_id

  #validates_presence_of :data, :payload_type, :point_id

  def as_json(params = {})
    super params.reverse_merge(
      only: [:data, :payload_type, :id]
    )
  end

end
