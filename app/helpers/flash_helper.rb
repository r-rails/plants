# frozen_string_literal: true

module FlashHelper
  def css_for_flash(key)
    case key.to_sym
    when :error
      'bg-red-200 text-red-800 border-red-800'
    else
      'bg-green-200 text-green-800 border-green-800'
    end
  end
end
