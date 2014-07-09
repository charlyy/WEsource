class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :title, :language, :link, :note

end
