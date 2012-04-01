module HtmlHelpers
  def include_stylesheet name, options={}
    href = "/stylesheets/#{name}.css" unless name.to_s.match(/^http/)
    content_tag :link, nil, options.merge(:rel => "stylesheet", :href => (href || name))
  end

  def include_favicon name, options={}
    href = "/images/#{name}.ico" unless name.to_s.match(/^http/)
    content_tag :link, nil, options.merge(:rel => "shortcut icon", :href => (href || name))
  end

  def include_javascript name, options={}
    href = "/javascripts/#{name}.js" unless name.to_s.match(/^http/)
    content_tag :script, "", :type => "text/javascript", :src => (href || name)
  end

  def image_tag name, options={}
    src = "/images/#{name}" unless name.to_s.match(/^http/)
    content_tag :img, nil, options.merge(:alt => name, :src => (src || name))
  end

  # TODO: correct to include link text
  def link_to name, href, options={}
    content_tag :a, name, options.merge(:href => href)
  end

  def number_to_percentage(number, options = {})
    precision = options[:precision] || 2
    (sprintf("%.#{precision.to_s}f", number).to_f * 100).round
  end

  def number_with_delimiter(number, default_options = {})
    options = {
      :delimiter => ','
    }.merge(default_options)
    number.to_s.reverse.gsub(/(\d{3}(?=(\d)))/, "\\1#{options[:delimiter]}").reverse
  end

  def content(section, *args)
    view_content[section.to_sym].map! do |content|
      if respond_to?(:block_is_haml?) && block_is_haml?(content)
        capture_haml(*args, &content)
      else
        content.call(*args)
      end
    end.join if view_content[section.to_sym]
  end

  def content_for(section, &block)
    view_content[section.to_sym] << block
  end

  def view_content
    @view_content ||= Hash.new([])
  end

  def content_tag tag, value, options={}
    element = "<#{tag}"
    options.each do |name, value|
      element << " #{name}=\"#{value}\""
    end

    if value.nil?
      element << "/>"
    else
      element << ">"
      element << (block_given? ? yield : value)
      element << "</#{tag}>"
    end

    element
  end
end
