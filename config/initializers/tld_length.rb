ActionDispatch::Http::URL.tld_length = if Rails.env.production?
  1
elsif Rails.env.staging?
  2
else
  0
end
