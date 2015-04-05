module ReviewsHelper

  def panel_row(label, data)
    content_tag(:p) do
      content_tag(:span, label, class: "strong") + ": " + data
    end
  end

  def extract_date(datetime)
    datetime.strftime("%Y-%m-%d")
  end

end
