require 'qr_image'
class Point < ActiveRecord::Base

  def before_create
    self.visit_number = 0
  end

  def after_destroy
    File.delete(self.qr_path) if File.exist?(self.qr_path)
  end

  QR_IMAGES_DIR = File.join(RAILS_ROOT, 'public/qr')
  QR_SIZE = 5

  def create_qr_image(request)
    QrImage.create_image(qr_path, qr_text(request), 4, 10, 10)
  end

  def qr_text(request)
    "#{request.protocol}#{request.host}/p/v/#{self.id}"
  end

  def qr_code(request)
    QrImage.get_code(qr_text(request), QR_SIZE)
  end

  def qr_url
    File.join('qr/', "#{self.id}.jpg")
  end

  def qr_path
    File.join(QR_IMAGES_DIR, "#{self.id}.jpg")
  end

  def visit!
    self.visit_number += 1
    self.save
  end

end
