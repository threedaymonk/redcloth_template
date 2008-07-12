# $Id$

require 'redcloth'

class RedCloth
  def hard_breaks
    false
  end

  class Template < ActionView::TemplateHandlers::ERB
    def render(template)
      RedCloth.new(super).to_html
    end
  end
end
