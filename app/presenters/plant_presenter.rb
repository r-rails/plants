class PlantPresenter < BasePresenter
  presents :plant

  def add_plant_to_garden(user)
    return _h_.link_to("Sign in to plant your garden", new_user_session_path, class: "p-2 border-2 border-green-700 rounded font-normal hover:bg-green-300 cursor-pointer") unless user
    if user.plant_ids.include?(plant.id)
      _h_.form_tag garden_plant_path, method: :delete do
        _h_.hidden_field_tag(:plant_id, plant.id) +
          _h_.submit_tag("remove", class: "p-2 border-2 border-red-700 rounded hover:bg-red-300 cursor-pointer")
      end
    else
      _h_.form_tag add_to_garden_path, method: :post do
        _h_.hidden_field_tag(:plant_id, plant.id) +
          _h_.submit_tag("add", class: "p-2 border-2 border-green-700 rounded hover:bg-green-400 cursor-pointer")
      end
    end
  end

  def plant_img
    return _h_.image_tag "favicon.png" unless plant.img.present?

    _h_.image_tag plant.img.variant(
      resize_to_fill: [400, 400],
      convert: "webp",
      saver: {quality: 100}
    )
  end

  def link_to_plant_page(html_options = {})
    _h_.link_to(plant.name, plant_path(plant), data: html_options[:data], class: html_options[:class])
  end

  def show_plant_comments
    if plant.comments.blank?
      _h_.render_haml <<-HAML
      .flex.justify-center.mt-6
        .text-2xl.font-serif Be first to comment on this plant!
      HAML
    else
      _h_.render_haml <<-HAML
        = render @comments
      HAML
    end
  end
end
