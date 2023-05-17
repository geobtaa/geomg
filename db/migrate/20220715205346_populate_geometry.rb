class PopulateGeometry < ActiveRecord::Migration[6.1]
  def change
    @steps = 0
    Document.in_batches(of: 1000).each do |relation|
      relation.each do |doc|
        doc.locn_geometry = if doc.dcat_bbox.present?
          doc.derive_polygon
        else
          ""
        end
        doc.save
      rescue Exception => e
        puts "Failed: #{doc.id} - #{e.inspect}"
      end

      @steps += relation.count
      puts "Docs Migrated: #{@steps}"
    end
  end
end
