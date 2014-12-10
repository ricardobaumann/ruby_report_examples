require 'gruff'
require 'active_record'

game_id_to_analyze = 5

ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql', 
  :host     => 'localhost', 
  :username => 'redmine', 
  :password => 'redmine', 
  :database => 'redmine')

class IssueHistory < ActiveRecord::Base 
  self.table_name = "rb_issue_history"
  has_one :issues
end

class Issue < ActiveRecord::Base 
  belongs_to :issueHistory
end

class Version < ActiveRecord::Base 
  has_many :issues, :foreign_key => 'fixed_version_id'
end

def puts_underlined(text, underline_char="=")
  puts text
  puts underline_char * text.length 
end

pic_dir='./burndown_graph_pics'
Dir.mkdir(pic_dir) unless File.exists?(pic_dir)

line_chart = Gruff::Line.new(1024)
index=0
columns = {}

points_per_date = {}

IssueHistory.all.each do |e| 
  e.history.split(/---/).each do |h|
    h.split(/- /).each do |i|
      puts "\n\nNovo Item"
      values = {}
      i.split(/\n/).each do |f|
        is = f.split(/: /)
        #puts "item: #{is.first} = #{is.last == is.first ? '' : is.last}\n\n"
        name = is.first.gsub(/:/,'').gsub(/\s/,'')
        value = is.last == is.first ? '' : is.last.gsub(/:/,'').gsub(/\s/,'')
        #puts "#{name} = #{value}"
        values[name] = value
      end
      puts "values: #{values}"
      points_per_date[values["date"]] ||= []
      points_per_date[values["date"]] << values["story_points"]
    end
  end
  #columns[index] = e.event
  #index=index+1
end

puts "\n\npoints per date: #{points_per_date}"

return 1

line_chart.labels = columns 
line_chart.legend_font_size = 10 
line_chart.legend_box_size = 10 
line_chart.title = "Chart of All Players" 
line_chart.minimum_value = 0 
line_chart.maximum_value = 110

Player.all.each do |player| 
  total_games = Play.count(:conditions=>['game_id = ? AND player_id = ?', 
                         game_id_to_analyze, player.id]).to_f
  total_wins = Play.count(:conditions=>['game_id = ? AND player_id = ? AND won=1', 
                         game_id_to_analyze, player.id]).to_f

 sql = "SELECT event, avg(time) as average_time

          FROM events as e
                INNER JOIN
               plays as p
                 ON e.play_id=p.id
         WHERE p.game_id='#{game_id_to_analyze}'
                 AND
               p.player_id='#{player.id}'
         GROUP
            BY e.event;"
 data = []
 Event.find_by_sql(sql).each do |row| 
   data << (row.average_time.to_i/1000)
 end

 line_chart.data(player.name, data )

end

line_chart.write("#{pic_dir}/all_players.png")