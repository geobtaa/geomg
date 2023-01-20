# frozen_string_literal: true

traject_logger = ActiveSupport::Logger.new("#{Rails.root}/log/traject.log")

Kithe.indexable_settings.solr_url = ENV['SOLR_URL']

# Index to solr with solr `id` field being our friendlier_id
Kithe.indexable_settings.solr_id_value_attribute = :friendlier_id

