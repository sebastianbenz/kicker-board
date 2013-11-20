require 'gravatar-ultimate'

users = [
         'sebastian.benz@esrlabs.com',
         'christian.koestlin@esrlabs.com',
         'gerd.schaefer@esrlabs.com',
         'daniel.schick@esrlabs.com',
         'matthias.kessler@esrlabs.com',
         'oliver.mueller@esrlabs.com'
         ]
users.each do |u|
  file_name = "#assets/images/avatars/{u}.png"
  if !File.exists?(file_name)
    data = Gravatar.new(u).image_data
    File.open(file_name, 'wb') do |io|
      io.write(data)
    end
  end
end
