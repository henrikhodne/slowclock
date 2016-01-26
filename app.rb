require "sinatra"

get "/" do
  now = Time.now.to_i
  a_midnight = ENV["A_MIDNIGHT"].to_i
  seconds_in_a_day = 24*60*60
  seconds_in_a_long_day = seconds_in_a_day + ENV["EXTRA_SECONDS"].to_i
  seconds_into_long_day = (now - a_midnight) % seconds_in_a_long_day
  seconds_into_normal_day = (seconds_into_long_day.to_f * (seconds_in_a_day.to_f / seconds_in_a_long_day.to_f)).to_i

  hours = (seconds_into_normal_day/60/60).to_i
  minutes = (seconds_into_normal_day/60).to_i % 60
  seconds = (seconds_into_normal_day) % 60

  content_type :html

  "<!DOCTYPE html><html><body><span style=\"text-align: center; font-size: 2em;\">%02d:%02d:%02d</span></body></html>" % [hours, minutes, seconds]
end
