module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-error"
    when "alert"
      "alert-block"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def omniauth_link_for provider
    unless short_name_for(provider) =~ /oauth2/i
      link_to "#{short_name_for provider}", provider.new(request.env).request_path
    end
  end

  def short_name_for provider
    provider.name.split('::').last
  end
end
