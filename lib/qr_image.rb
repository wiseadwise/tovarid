module QrImage
  include GD2

  def self.create_image(path, text, code_size, pixel_size, padding)
    qr = RQRCode::QRCode.new(text, :size => code_size)
    size = qr.modules.size
    length = pixel_size*size + 2*padding
    image = Image::IndexedColor.new(length,length)
    image.draw do |pen|
      i = 0
      while i < size 
        j = 0
        while j < size 
          if qr.is_dark(i,j) 
            pen.color = image.palette.resolve Color::WHITE;
            col = 1
          else
            pen.color = image.palette.resolve Color[1, 1, 1]
            col = 0
          end
          x = i*pixel_size + padding
          y = j*pixel_size + padding
          draw_pixel(image, y, x, col, pixel_size)
          j += 1
        end
        i += 1
      end
    end
    image.export(path)
  end

  def self.draw_pixel(image, x, y, color, size)
    (0...size).each do |a|
      (0...size).each do |b|
        image.set_pixel(x + a,y + b, color)
      end
    end
  end

  def self.get_code(text, code_size)
    RQRCode::QRCode.new(text, :size => code_size)
  end

end

#QrImage.create_image('new_image.jpg', "http://google.com/", 3, 10, 60)
