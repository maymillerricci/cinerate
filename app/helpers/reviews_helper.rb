module ReviewsHelper

  def panel_row(label, data)
    content_tag(:p) do
      content_tag(:span, label, class: "strong") + ": " + data
    end
  end

end
