class GoogleAdapter

  # 2016 Lead for the day Schedule - DBC-SF
  # https://docs.google.com/spreadsheets/d/1cNslAPoctBreV5dzNspIAbVckaY5RvaET81cl-8bJkM/edit#gid=2102156371

  def initialize
    access_token = Token.last.access_token
    session = GoogleDrive.login_with_oauth(access_token)
    @ws = session.spreadsheet_by_key("1cNslAPoctBreV5dzNspIAbVckaY5RvaET81cl-8bJkM").worksheets
  end

  def topics_worksheet
    # check title of sheet here....
    @daily_topics ||= @ws[3].cells
  end

  def leads_worksheet
    # check title of sheet here....
    @daily_leads ||= @ws[0].cells
  end

  def get_daily_staff
    # will need documentation in the schedule about how this pull works.
    # first val == row
    # second val == col

    results = {}
    ws = leads_worksheet
    day_root_cell = find_day_root_cell
    return results if day_root_cell.nil?
    off_root_cell = find_off_root_cell(day_root_cell)
    count = off_root_cell[0] - day_root_cell[0]

    count.times do |count_int|
      day_type = ws[[day_root_cell[0] + count_int, 2]]
      day_lead = ws[[day_root_cell[0] + count_int, day_root_cell[1]]]
      next if (day_type.nil? || day_lead.nil? || day_lead.match(/Final/))
      results[day_lead.match(/^[^\W]*/).to_s] = day_type
    end
    results['Walker'] = 'Campus Director'
    results
  end

  def find_day_root_cell
    today = Date.today.to_s
    # today = Date.parse("12-08-2016").to_s
    leads_worksheet.each do |key, value|
      if value.match(/^\d{1,2}\/\d{1,2}\/\d{4}$/)
        formatted_value = Date.strptime(value, "%m/%d/%Y").to_s
        return key if Date.parse(formatted_value).to_s == today
      end
    end
    nil
  end

  def find_off_root_cell(day_root_cell)
    root_cell = [day_root_cell[0], 2]

    10.times do
      root_cell[0] += 1
      return root_cell if leads_worksheet[root_cell] == "Off"
    end
  end

end
