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
end
