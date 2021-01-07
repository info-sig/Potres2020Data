module ApplicationHelper

  def render_hash(hash, options = {})
    return hash.to_s unless hash.is_a? Enumerable # you reached a leaf, you can't dive into a not-hash
    options[:id_prefix] ||= rand.hash
    options[:compact]   ||= 999999999
    options[:level]     ||= 0 and level = options[:level] + 1
    options[:hash]      ||= "#{options[:id_prefix]}#{rand.hash}"
    options[:expand_all] ||= false

    rv = ''
    rv << "<ul id='#{options[:hash]}' style='display:#{options[:compact] < level and !options[:expand_all] ? 'none' : 'block' }'>"
    hash.each do |k,v|
      # <%= link_to t(:search), {}, :id => 'search-link', :class => "btn" %>
      child_hash = "#{options[:id_prefix]}#{rand.hash}"
      if k.is_a? Enumerable and v.nil?
        rv << render_hash(k, options.merge(level: level, hash: child_hash))
      elsif v.nil?
        rv << "<li>#{k.to_s.humanize}</li>"
      else
        rv << "<li><b>#{k.to_s.humanize}: </b>"
        if options[:compact] < level + 1 and v.is_a? Enumerable and !v.empty?
          rv << " [#{link_to(t(:expand), '#', onclick: "$(\"##{child_hash}\").toggle()") }]"
        end
        rv << render_hash(v, options.merge(level: level, hash: child_hash))
        rv << "</li>"
      end
    end
    rv << '</ul>'

    rv.html_safe
  end

end
