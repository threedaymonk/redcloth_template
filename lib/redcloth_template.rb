# $Id$

require 'redcloth'

class RedCloth
  def hard_breaks
    false
  end
  class Template
    def initialize(view)
      @view = view
    end

    def render(template, local_assigns)
      output = @view.compile_and_render_template('rhtml', template, nil, local_assigns)
      RedCloth.new(output).to_html
    end
  end
end
