module ApplicationHelper
  def show_sentence_with_entities(sentence)
    text = sentence.text
    # Try to avoid overriding spans as much as possible by sorting in descending length
    sentence.entities.to_a.sort{|el| el.text.length}.each do |entity|
      style = styling_data(entity.type)
      text.gsub!(entity.text,
        "<span class='element' style='background-color: #{style[:bg_color]}; color: #{style[:text_color]}'>
          #{entity.text} <sup>#{entity.type}</sup>
        </span>"
      )
    end
    text.html_safe
  end

  def styling_data(type)
    # Generate styling data (bg-color and text color) based on type characters on the fly
    # Group styling based on entity type in order to provide a more uniform UX
    # Use YIQ similar to Bootstrap's color-yiq https://en.wikipedia.org/wiki/YIQ
    @styling_data ||= {}
    return @styling_data[type] || add_styling_data(type)
  end

  private

  def add_styling_data(type)
    # Use same algorithm so same color scheme is always generated
    sum = type.each_char.map(&:ord).sum
    r = (sum*3) % 255
    g = (sum*4) % 255
    b = (sum*5) % 255
    hsp = Math.sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b))
    text_color = hsp > 127.5 ? "black" : "white"
    @styling_data[type] = {
      bg_color: "rgb(#{r},#{g},#{b})",
      text_color: text_color
    }
  end
end
