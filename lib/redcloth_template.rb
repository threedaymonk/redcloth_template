# $Id$

require 'redcloth'

module RedCloth
  class Template < ActionView::TemplateHandlers::ERB
    def render(template)
      RedCloth.new(super).to_html
    end
  end
end
