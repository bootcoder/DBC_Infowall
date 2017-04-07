class Mentor < ActiveRecord::Base

  def self.parse_deputy_mentors(deputy_array)
    Mentor.delete_all
    return nil if deputy_array == (nil || deputy_array.empty?)
    results = []
    deputy_array.each do |mentor|
      phase = mentor["_DPMetaData"]["OperationalUnitInfo"]["OperationalUnitName"]
      next if phase == ("Admin" || "Remote Support" || "Interviews" || "Phase 0 Guide")
      results << Mentor.create(
        name: mentor["_DPMetaData"]["EmployeeInfo"]["DisplayName"],
        img_url: mentor["_DPMetaData"]["EmployeeInfo"]["Photo"],
        phase: phase,
        staff_type: "Mentor")
    end
    results.sort_by { |mentor| mentor.phase }
  end
end
