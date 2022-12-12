class AardvarkUpdates < ActiveRecord::Migration[6.1]
  def change
    @steps = 0
    Document.in_batches(of: 1000).each do |relation|
      relation.each do |doc|
        # Set new dcat_centroid value
        begin
          if doc&.dcat_centroid_ss&.present?
            doc&.dcat_centroid = doc&.dcat_centroid_ss
          end

          # Set new dcat_bbox value
          if doc&.locn_geometry&.present?
            doc&.dcat_bbox = doc&.locn_geometry
          end

          # Reindex doc
          begin
            doc.save
          rescue
            puts "Save Failed: #{doc.id}\n"
          end
        rescue
          puts "Fail"
        end
      end

      @steps = @steps + relation.count
      puts "Docs Migrated: #{@steps}"
    end
  end
end
