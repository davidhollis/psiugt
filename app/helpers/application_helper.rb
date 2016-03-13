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
  
  def page_table_rows(page_list, depth=0)
    rows = ''
    
    page_list.each do |page|
      rows += content_tag(:tr) do
        [
          content_tag(:td, casein_table_cell_link(
            [
              table_spacers(depth),
              casein_span_icon('file'),
              '&nbsp;',
              page.title
            ].join.html_safe,
            casein_page_path(page)
          )),
          content_tag(:td, casein_table_cell_link(content_tag(:code,page.path), casein_page_path(page))),
          content_tag(:td, casein_table_cell_link(publication_status_badge(page), casein_page_path(page))),
          content_tag(:td, casein_table_cell_link((page.parent&.title || '(root page)'), casein_page_path(page))),
          content_tag(:td,
            link_to(casein_show_row_icon("new-window"), casein_page_path(page)),
            class: 'action'
          ),
          content_tag(:td,
            link_to(casein_show_row_icon("plus-sign"), new_casein_page_path(parent_id: page.id)),
            class: 'action'
          ),
          content_tag(:td,
            link_to(casein_show_row_icon("trash"), casein_page_path(page), :method => :delete, :data => { :confirm => "Are you sure you want to delete this page?" }),
            class: 'delete'
          )
        ].join.html_safe
      end
      rows += page_table_rows(page.children.order(:title), depth + 1)
    end
    
    rows.html_safe
  end
  
  protected
  def table_spacers(how_many)
    if how_many == 0
      ''
    else
      (content_tag(:b, '', class: 'table-spacer') * how_many).html_safe
    end
  end
end
