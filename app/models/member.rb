class Member < ActiveRecord::Base
  belongs_to :initiation_class
  belongs_to :big_brother, class_name: 'Member'
  has_many :little_brothers, class_name: 'Member', foreign_key: :big_brother_id
  
  enum status: %i(active candidate alum withdrawn)
  
  scope :biggable, -> { where.not(status: statuses['candidate']).order(:name) }
  
  
  def graph_identifier
    self.name.gsub(/[^A-Za-z0-9]/,'').downcase
  end
  
  def graph_label
    # Split the name on any space characters, the recombine with newlines.
    # Suppress newlines if any of the following hold:
    #   (1) The previous part is 3 characters or less and it's the first part
    #   (2) The following part is 3 characters or less
    #   (3) The previous part ends with a comma
    reformatted = ''
    self.name.split(%r/\s+/).each do |part|
      if reformatted.length <= 3 or part.length <= 3 or reformatted.end_with? ','
        reformatted += ' ' + part
      else
        reformatted += '\\n' + part
      end
    end
    reformatted
  end
  
  def graph_node_style
    case self.status
    when 'active' then 'rounded'
    when 'candidate' then 'rounded,dashed'
    else ''
    end
  end
  
  
  class << self
    def output_graph(output_path)
      g = GraphViz.new :G, type: :digraph
      g.add_nodes('root',
        label: "Genealogy of the\nPSI UPSILON\nfraternity,\nGAMMA TAU\nchapter",
        fontcolor: 'gold', color: 'gold', fillcolor: 'firebrick4',
        style: 'filled', shape: 'rectangle')
      # The first line of the first node is always set in the wrong typeface, so
      # add a new invisible node
      g.add_nodes('fontfix', style: 'invis')
      g.add_edges('fontfix', 'root', style: 'invis')
      
      # Construct the top section, whihc consists of all members who have no
      # big or little brothers. Generally, this applies to members initiated
      # prior to the advent of the big/little system. 
      top = Member.where(big_brother: nil).select { |m| m.little_brothers.count == 0 }
      top_grid = [[]]
      top.each_index do |i|
        div = (i/11).to_i
        if top_grid.size < div + 1
          top_grid << []
        end
        top_grid[div] << top[i]
      end
      
      # Add the top section to the graph.
      top_grid.each_index do |i|
        top_grid[i].each_index do |j|
          member = top_grid[i][j]
          
          g.add_nodes(member.graph_identifier,
            label: member.graph_label,
            fontcolor: 'black', color: 'black',
            shape: 'rectangle', style: member.graph_node_style)
          
          if i == 0
            # For the first row of the top section, connect each member to the
            # chart header with an invisible link
            g.add_edges('root', member.graph_identifier, style: 'invis')
          else
            # For every other row of the top section, connect each member to
            # the member immediately above with an invisible link
            above = top_grid[i-1][j]
            g.add_edges(above.graph_identifier, member.graph_identifier, style: 'invis')
          end
        end
      end
      
      # Add in an invisible element to stabilize the chart, then connect it to
      # the last row of the top section
      g.add_nodes('newroot', style: 'invis')
      top_grid.last.each do |member|
        g.add_edges(member.graph_identifier, 'newroot', style: 'invis')
      end
      
      # Add a graph element for everyone who's not in the top section
      Member.all.each do |member|
        next if top.include?(member)
        
        g.add_nodes(member.graph_identifier,
          label: member.graph_label,
          fontcolor: 'black', color: 'black',
          shape: 'rectangle', style: member.graph_node_style)
        
        if member.big_brother.nil?
          # If the member has no big, connect them to the stabilizer with an
          # invisible link
          g.add_edges('newroot', member.graph_identifier, style: 'invis')
        else
          # If the member has a big, connect them to their big
          g.add_edges(member.big_brother.graph_identifier, member.graph_identifier)
        end
      end
      
      # Write out the graph
      g.output(pdf: output_path)
    end
  end
  
  
  ATTRIBUTES = %w(founder honorary)
end
