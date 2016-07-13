class Mentor < ActiveRecord::Base

  def self.parse_deputy_mentors(deputy_array)
    # You should be able to use deputy_arry.blank? instead of
    # (deputy_array == nil || deputy_array.empty?)
    # (blank? does this for you for any type of object)
    return nil if deputy_array == nil || deputy_array.empty?
    # You can use each_with_object here instead, which will save you a couple
    # lines of boilerplate.
    results = []
    deputy_array.each do |mentor|
      results << Mentor.create(
        name: mentor["_DPMetaData"]["EmployeeInfo"]["DisplayName"],
        img_url: mentor["_DPMetaData"]["EmployeeInfo"]["Photo"],
        phase: mentor["_DPMetaData"]["OperationalUnitInfo"]["OperationalUnitName"])
    end
    results.sort_by { |mentor| mentor.phase }
  end
end
