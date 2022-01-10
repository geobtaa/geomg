# frozen_string_literal: true

# Constants for various controlled lists for Document attributes.
#
# _Removing_ values from here may require data migration in your existing db.
#
# ## Display lables via i18n
# These are the values actually stored in the DB. Display-translated values can be
# provided via a poorly documented built-in feature of Rails i18n.
#
# If you put an I18n value in your locale file (eg config/locales/en.yml) at:
#     activerecord:
#       attributes:
#         work/format:
#           image: "Really great image"
#
# Then you can look it up with Work.human_attribute_name("format.image"). It even
# does some superclass lookup for you if you have an inheritance hieararchy.
#
# ## Some lists elsewhere
# Controlled values for specific sub-model classes (like Creator) can be found
# within them, not here. This is only for primitive attributes on Work. (But should
# we move sub-model lists here too?)
class Document
  class ControlledLists
    PUBLICATION_STATE = %w[draft published unpublished].freeze

    ACCESS_RIGHTS = %w[Public Restricted].freeze

    LAYER_GEOM_TYPES = %w[Point Line Polygon Image Raster Mixed Table Vector].freeze

    B1G_STATUS = %w[Active Inactive Unknown].freeze

    B1G_ACCRUAL_PERIODICITY = [
      'Annually',
      'Semiannually',
      'Quarterly',
      'Monthly',
      'As Needed'
    ].freeze

    GENRE = [
      'Maps',
      'Datasets',
      'Imagery',
      'Collections',
      'Websites',
      'Web services',
      'Other'
    ].freeze

    SCHEMA_PROVIDER = [
      'Indiana University',
      'University of Illinois Urbana-Champaign',
      'University of Iowa',
      'University of Maryland',
      'University of Minnesota',
      'Michigan State University',
      'University of Michigan',
      'Pennsylvania State University',
      'Purdue University',
      'University of Wisconsin - Madison',
      'The Ohio State University',
      'University of Chicago',
      'University of Nebraska-Lincoln'
    ].freeze

    THEME = [
      'Farming',
      'Biota',
      'Boundaries',
      'Climatology, Meteorology and Atmosphere',
      'Economy',
      'Elevation',
      'Environment',
      'Geoscientific Information',
      'Health',
      'Imagery and Base Maps',
      'Intelligence and Military',
      'Inland Waters',
      'Location',
      'Oceans',
      'Planning and Cadastral',
      'Society',
      'Structure',
      'Transportation',
      'Utilities and Communication'
    ].freeze

    TYPE = [
      'Image',
      'Dataset',
      'Service',
      'Interactive Resource',
      'Physical Object',
      'Collection'
    ].freeze
  end
end
