require 'redcloth'
begin
  require 'rdiscount'
  ::BlueCloth = ::RDiscount unless defined?(::BlueCloth)
rescue LoadError
  require 'bluecloth'
  warn "Using bluecloth for Markdown rendering. Install rdiscount for better performance."
end

module ActionView
  module TemplateHandlers
    module RedClothCompiler
      def compile_with_renderer(klass, template)
        %{
          interpolated = ::ERB.new(template.source, nil, "#{erb_trim_mode}").result(binding)
          interpolated.sub!(/\A#coding:.*\n/, '') if RUBY_VERSION >= '1.9'
          ::#{klass}.new(interpolated).to_html
        }
      end

      def self.included(base)
        base.__send__(:cattr_accessor, :erb_trim_mode)
        base.__send__(:erb_trim_mode=, '-')
      end
    end

    class TextileTemplate < TemplateHandler
      include Compilable
      include RedClothCompiler

      def compile(template)
        compile_with_renderer(RedCloth, template)
      end
    end

    class MarkdownTemplate < TemplateHandler
      include Compilable
      include RedClothCompiler

      def compile(template)
        compile_with_renderer(BlueCloth, template)
      end
    end
  end
end
