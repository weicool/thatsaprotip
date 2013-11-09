module TagsHelper

  def render_tags(protip)
    tags_content = protip.tags.map do |tag|
      render_tag(tag) 
    end.join.html_safe
    content_tag(:ul, tags_content, :class => 'tags clearfix')
  end

  def render_tag(tag)
    content_tag(:li, tag.tag, :class => 'tag')
  end

end
