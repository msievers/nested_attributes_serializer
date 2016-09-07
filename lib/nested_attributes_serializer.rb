require "nested_attributes_serializer/version"

module NestedAttributesSerializer
  # Returns a hash representing the model. It accepts the some options
  # as serializable_hash.
  def as_nested_attributes(options = {})
    hash = serializable_hash(options)
    NestedAttributesSerializer.rename_includes(hash, options)
    hash
  end

  # see #as_nested_attributes
  def to_nested_attributes(*args)
    as_nested_attributes(*args)
  end

  # Renames the keys of associations to conform to rails nested attributes
  # naming convention. This is a implemented as a module method in order
  # to not pollute the method namespace of the including class/module.
  def self.rename_includes(hash, options)
    # inspired by activemodel/lib/active_model/serialization.rb
    return unless includes = options[:include]

    unless includes.is_a?(Hash)
      includes = Hash[Array(includes).map { |n| n.is_a?(Hash) ? n.to_a.first : [n, {}] }]
    end

    includes.each do |association, opts|
      old_key = association.to_s
      new_key = "#{old_key}_attributes"
      hash[new_key] = hash.delete(old_key)
      rename_includes(hash[new_key], opts)
    end
  end
end
