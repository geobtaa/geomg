class PopulateGeometry < ActiveRecord::Migration[6.1]
  def change
    @steps = 0
    Document.in_batches(of: 1000).each do |relation|
      relation.each do |doc|
        begin
          if doc.dcat_bbox.present?
            doc.locn_geometry = doc.derive_polygon
          else
            doc.locn_geometry = ''
          end
          doc.save
        rescue Exception => e
          puts "Failed: #{doc.id} - #{e.inspect}"
        end
      end

      @steps = @steps + relation.count
      puts "Docs Migrated: #{@steps}"
    end
  end
end
