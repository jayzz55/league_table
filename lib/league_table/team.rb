class Team < Struct.new(:position, :name, :points)
  def self.from_html(row)
    new(
      row.at_css('span.position-number').text.to_i,
      row.at_css('td.team-name').text,
      row.at_css('td.points').text.to_i
    )
  end
end

