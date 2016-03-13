module ApplicationHelper
  def member_attribute_check_boxes(member)
    Member::ATTRIBUTES.map do |attribute_name|
      content_tag(:div, class: 'checkbox') {
        content_tag(:label) {
          check_box_tag(
            'member_attributes[]',
            attribute_name,
            member.member_attributes.include?(attribute_name)) +
          " " +
          attribute_name
        }
      }
    end.join.html_safe
  end
  
  def attribute_badges(member)
    Member::ATTRIBUTES.map do |attribute_name|
      if member.member_attributes.include?(attribute_name)
        content_tag(:span, attribute_name, class: 'label label-primary')
      else
        ''
      end
    end.join(' ').html_safe
  end
  
  def publication_badge(page)
    if page.published?
      [
        content_tag(:span, 'published', class: 'label label-primary'),
        'on',
        page.published_on.strftime('%F')
      ]
    else
      [
        content_tag(:span, 'draft', class: 'label label-default'),
        'to be published on',
        page.published_on.strftime('%F')
      ]
    end.join(' ').html_safe
  end
  
  def publication_status_badge(post)
    if post.published?
      content_tag(:span, 'published', class: 'label label-primary')
    else
      content_tag(:span, 'draft', class: 'label label-default')
    end
  end
  
  def summernote_field(form, attribute)
    form_element_id = "#{attribute}_backing_value"
    [
      form.hidden_field(attribute, id: form_element_id),
      content_tag(:div, form.object.send(attribute)&.html_safe, class: 'summernote', data: { backing_value: form_element_id })
    ].join.html_safe
  end
end
