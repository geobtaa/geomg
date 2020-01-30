class Document
  class Reference
    URI_VALUES = [
      "http://schema.org/url",
      "http://schema.org/downloadUrl"
    ]

    include AttrJson::Model

    validates_presence_of :category, :value
    validates :category, inclusion:
      { in: URI_VALUES,
        allow_blank: true,
        message: "%{value} is not a valid category" }

    attr_json :category, :string
    attr_json :value, :string
  end
end
