class FileHelper

  def self.image(file_name)
    File.new(File.join(File.dirname(__FILE__), 'images', file_name))
  end
end