# frozen_string_literal: true

require 'haml'

module ApplicationHelper
  # This method will allow us extract logic away from the view into descriptive helper methods
  def render_haml(haml, locals = {})
    Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end
end
