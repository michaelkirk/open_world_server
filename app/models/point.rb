class Point < ActiveRecord::Base
  attr_accessible :lonlat, :payload, :category
  #factory = RGeo::Geographic.spherical_factory(:srid => 4326)
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(:srid => 4326))

  def self.create_from_params(params)
    point_params = { 
      lonlat: sprintf("POINT(%f %f)", params[:longitude], params[:latitude]),
      payload: params[:payload],
      category: params[:category]
    }

    create(point_params)
  end

  def as_json(params = {})
    super params.reverse_merge(:only => [:category, :payload],
                               :methods => [:latitude, :longitude])
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
