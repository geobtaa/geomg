class FixWholeEarthPolygons < ActiveRecord::Migration[6.1]
  def change
    # Find all database entries with whole earth polygons
    docs = ActiveRecord::Base.connection.execute(
      "SELECT id, json_attributes->>'locn_geometry'
        from kithe_models
        where json_attributes->>'locn_geometry' = 'POLYGON((-180 90, 180 90, 180 -90, -180 -90, -180 90))'"
    )

    # Iterate over docs array and set locn_geometry to whole earth envelopes
    # ENVELOPE(-180,180,90,-90)
    docs = docs.to_a
    count = 0
    docs.each do |doc|
      doc = Document.find(doc["id"])
      doc.locn_geometry = "ENVELOPE(-180,180,90,-90)"
      doc.save
      count += 1
    end

    puts "Documents migrated: #{count}"
  end
end
