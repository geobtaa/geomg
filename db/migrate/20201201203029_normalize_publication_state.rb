class NormalizePublicationState < ActiveRecord::Migration[6.0]
  def change
    errors = []

    docs = DocumentTransition.where(to_state: "Draft")
    docs.each do |doc|
      doc.to_state = 'draft'
      begin
        doc.save
      rescue
        errors << "Failed Save - Doc - #{doc.friendlier_id}"
      end
    end

    docs = DocumentTransition.where(to_state: "Published")
    docs.each do |doc|
      doc.to_state = 'published'
      begin
        doc.save
      rescue
        errors << "Failed Save - Doc - #{doc.friendlier_id}"
      end
    end

    docs = DocumentTransition.where(to_state: "Unpublished")
    docs.each do |doc|
      doc.to_state = 'Unpublished'
      begin
        doc.save
      rescue
        errors << "Failed Save - Doc - #{doc.friendlier_id}"
      end
    end

    docs = Document.all
    docs.each do |doc|
      # Should update Solr with new publication state
      begin
        doc.save
      rescue
        errors << "Failed Save - Doc - #{doc.friendlier_id}"
      end
    end

    puts errors.inspect
  end
end
