require 'sass'

# Extra
# -----
module Sass::Script::Functions

  def inline_svg_image(path, color=nil)

    # real_path = File.join(Compass.configuration.images_path, path.value)
    real_path = File.join(Dir.pwd, path.value)
    svg = data(real_path)

    unless color.nil?
      assert_type color, :Color, :color
      svg = svg.gsub!(/fill="#[0-9a-zA-Z]+"/, "fill=\"#{color}\"")
    end

    encoded_svg = URI::encode(svg)
    data_url = "url('data:image/svg+xml;utf8," + encoded_svg + "')"
    Sass::Script::String.new(data_url)
  end

private

  def data(real_path)
    if File.readable?(real_path)
      File.open(real_path, "rb") {|io| io.read}
    else
      raise Compass::Error, "File not found or cannot be read: #{real_path}"
    end
  end

end
