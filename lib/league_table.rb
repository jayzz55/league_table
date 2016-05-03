require 'open-uri'
require 'nokogiri'
require_relative './league_table/team'

class LeagueTable
  DEFAULT_URL = "http://www.bbc.co.uk/sport/football/premier-league/table"

  include Enumerable

  def initialize(url = DEFAULT_URL)
    @url = url
    parse(html)
  end

  def html
    @html ||= open(@url)
  end

  def parse(html)
    @doc ||= Nokogiri::HTML(html)
  end

  def teams
    @teams ||= rows.map { |row| Team.from_html(row) }
  end

  def each(*args, &block)
    teams.each(&block)
  end
  
  private

  def rows
    @doc.at_css('table.table-stats').css('tbody tr')
  end
end

