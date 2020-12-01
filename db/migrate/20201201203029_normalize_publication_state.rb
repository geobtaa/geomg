class NormalizePublicationState < ActiveRecord::Migration[6.0]
  def change
    docs = DocumentTransition.where(to_state: "Draft")
    docs.each do |doc|
      doc.to_state = 'draft'
      doc.save
    end

    docs = DocumentTransition.where(to_state: "Published")
    docs.each do |doc|
      doc.to_state = 'published'
      doc.save
    end

    docs = DocumentTransition.where(to_state: "Unpublished")
    docs.each do |doc|
      doc.to_state = 'Unpublished'
      doc.save
    end

    docs = Document.all
    errors = []
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
