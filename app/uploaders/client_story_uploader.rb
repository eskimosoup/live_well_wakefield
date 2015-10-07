class ClientStoryUploader < Optimadmin::ImageUploader

  version :index do
    process resize_to_fit: [200, 200]
  end

  version :show do
    process resize_to_fit: [200, 200]
  end
end
