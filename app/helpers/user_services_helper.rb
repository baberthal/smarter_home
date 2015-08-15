module UserServicesHelper
  def class_for_away(away_type)
    case away_type
    when 'away'
      'panel-nest-away'
    when 'home'
      'panel-nest-home'
    else
      away_type.to_s
    end
  end

  def status_class_for(device)
    case device.stats['hvac_state']
    when 'heating'
      'heat'
    when 'cooling'
      'cool'
    else
      device.stats['hvac_state'].to_s
    end
  end

  def leaf_icon(options = {})
    options = options.merge(class: 'leaf')
    gulp_image_tag('nest_leaf.svg', options)
  end

  def heat_cool_icon(device)
    case device.stats['hvac_state']
    when 'heating'
      icon = "<span class='glyphicon glyphicon-fire pull-right'></i>"
    when 'cooling'
      icon = "<span class='icon -snowflake'></i>"
    else
      icon = ''
    end
    icon.html_safe
  end
end
