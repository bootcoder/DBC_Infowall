class Teacher < ActiveRecord::Base

  after_initialize :add_attributes

  def add_attributes
    self.img_url = set_img_url
    self.staff_type = "Staff"
  end

  def set_img_url
    random_placeholder =
       ["https://s-media-cache-ak0.pinimg.com/564x/30/93/d2/3093d2a63cf2a6d4d1a6a276676d7ae7.jpg",
        "http://flicksplay.com/images/defaults/batman.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuS2-GUSjAprIn3feBuh1nyhuIHfacVbtrVMiHDzWnisf_lg78-A"]

    case self.name.downcase
    when "hunter"
      self.img_url = "https://dbc-backoffice-production.s3.amazonaws.com/profile_images/2561.jpeg"
    when "sarah"
      self.img_url = "https://avatars.githubusercontent.com/u/424254?v=3"
    when "sherif"
      self.img_url = "https://avatars.githubusercontent.com/u/24913?v=3"
    when "ken"
      self.img_url = "https://avatars.githubusercontent.com/u/2986627?v=3"
    when "seba"
      self.img_url = "https://avatars.githubusercontent.com/u/6635552?v=3"
    when "max"
      self.img_url = "https://avatars.githubusercontent.com/u/16928707?v=3"
    when "walker"
      self.img_url = "https://avatars.githubusercontent.com/u/16601726?v=3"
    when "shambhavi"
      self.img_url = "https://avatars.githubusercontent.com/u/5216008?v=3"
    else
      self.img_url = random_placeholder.shuffle.pop
    end

  end

end
