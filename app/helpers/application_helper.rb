module ApplicationHelper
  def bootstrap_class_for(flash_type)
    types = {
      'success' => 'alert-success',
      'error' => 'alert-error',
      'alert' => 'alert-block',
      'notice' => 'alert-info'
    }
    return types[flash_type] if types.key? flash_type
    flash_type.to_s
  end

  def omniauth_link_for(provider)
    return if short_name_for(provider) =~ /oauth2/i
    link_to "#{short_name_for provider}", provider.new(request.env).request_path
  end

  def short_name_for(provider)
    provider.name.split('::').last
  end

  def gulp_asset_path(path, options = {})
    options = options.symbolize_keys
    type ||= options[:type].to_s.insert(0, '/')
    path = REV_MANIFEST[path] if defined?(REV_MANIFEST)
    "/assets#{type}/#{path}"
  end

  def gulp_stylesheet_link_tag(*sources)
    options = sources.extract_options!.stringify_keys
    path_options = options.extract!('protocol').symbolize_keys

    sources.uniq.map do |source|
      tag_options = {
        'rel' => 'stylesheet',
        'media' => 'screen',
        'href' => gulp_asset_path(source,
                                  path_options.merge!(type: 'stylesheets'))
      }.merge!(options)
      tag(:link, tag_options)
    end.join("\n").html_safe
  end

  def gulp_image_tag(source, options = {})
    options = options.symbolize_keys

    src = options[:src] = gulp_asset_path(source, type: 'images')

    unless src =~ /^(?:cid|data):/ || src.blank?
      options[:alt] = options.fetch(:alt) { image_alt(src) }
    end

    options[:width], options[:height] =
      extract_dimensions(options.delete(:size)) if options[:size]
    tag('img', options)
  end
end
