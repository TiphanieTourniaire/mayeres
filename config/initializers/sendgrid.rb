if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    username: "apikey",
    password: ENV['SENDGRID_API_KEY'],
    domain: 'http://monts-et-legumes.fr',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end
