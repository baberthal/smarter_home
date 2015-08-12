module UserServicesHelper
  def render_grid_for services
    services.each_slice(4) do |slice|
      render_row slice
    end
  end

  def render_row service_slice
    content_tag :div, class: 'row' do
      content_tag :div, class: 'col-md-4' do
        render_box_for service_slice[0] unless service_slice[0].nil?
      end
      content_tag :div, class: 'col-md-4' do
        render_box_for service_slice[1] unless service_slice[1].nil?
      end
      content_tag :div, class: 'col-md-4' do
        render_box_for service_slice[2] unless service_slice[2].nil?
      end
      content_tag :div, class: 'col-md-4' do
        render_box_for service_slice[3] unless service_slice[3].nil?
      end
    end
  end

  def render_box_for service
    content_tag :div, class: 'thumbnail' do
      if service.image
        image_tag service.image
      end
      content_tag :div, class: 'caption' do
        content_tag :h3, service.name
        content_tag :p, service.description if service.description
      end
    end
  end
end
