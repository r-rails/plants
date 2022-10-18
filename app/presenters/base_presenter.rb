class BasePresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  def initialize(object, template)
    @object = object
    @template = template
  end
  
  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end
end