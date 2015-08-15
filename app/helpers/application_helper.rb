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

  def gulp_asset_path(path)
    path = REV_MANIFEST[path] if defined?(REV_MANIFEST)
    "/assets/#{path}"
  end
end
