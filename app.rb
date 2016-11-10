require "sinatra"

def make_time(now)
  a_midnight = ENV["A_MIDNIGHT"].to_i
  seconds_in_a_day = 24*60*60
  seconds_in_a_long_day = seconds_in_a_day + ENV["EXTRA_SECONDS"].to_i
  seconds_into_long_day = (now - a_midnight) % seconds_in_a_long_day
  seconds_into_normal_day = (seconds_into_long_day.to_f * (seconds_in_a_day.to_f / seconds_in_a_long_day.to_f)).to_i

  hours = (seconds_into_normal_day/60/60).to_i
  minutes = (seconds_into_normal_day/60).to_i % 60
  seconds = (seconds_into_normal_day) % 60

  "%02d:%02d:%02d" % [hours, minutes, seconds]
end

get "/time.txt" do
  content_type :txt

  make_time(Time.now.to_i)
end

get "/" do
  content_type :html

  @time = make_time(Time.now.to_i)

  erb :time
end

__END__

@@ time
<!DOCTYPE html>
<html>
  <head>
    <title>Henrik Time</title>
    <style type="text/css">
      .time {
        text-align: center;
        font-size: 2em;
      }
    </style>
  </head>
  <body>
    <span class="time"><%= @time %></span>
  </body>
</html>
