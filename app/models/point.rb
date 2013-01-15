class Point < ActiveRecord::Base
  attr_accessible :lonlat, :payloads_attributes
  has_many :payloads, :dependent => :destroy
  accepts_nested_attributes_for :payloads

  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(:srid => 4326))

  scope :within_box, lambda { |west, south, east, north|
    intersects_with_bounding_box_sql = sprintf("points.lonlat && ST_MakeEnvelope(%f, %f, %f, %f, 4326)", west, south, east, north)
    where(intersects_with_bounding_box_sql)
  }

  def self.create_from_params(params)
    point_params = {}

    if(params[:longitude] && params[:latitude])
      point_params[:lonlat] = sprintf("POINT(%f %f)", params[:longitude], params[:latitude])
    end

    if(params[:payloads]) 
      point_params[:payloads_attributes] = params[:payloads]
    end

    create(point_params)
  end

  def as_json(params = {})
    super params.reverse_merge(
      only: [:id],
      include: [{ payloads: {
                    only: [:data, :payload_type]}}],
      methods: [:latitude, :longitude])
  end

  def latitude
    if self.lonlat
      self.lonlat.lat
    else
      nil
    end
  end

  def longitude
    if self.lonlat
      self.lonlat.lon
    else
      nil
    end
  end
end
