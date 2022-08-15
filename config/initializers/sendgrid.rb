if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    user_name: ENV["tiphanietourniaire@hotmail.com"],
    password: ENV['Tiphanie88!!sendgrid'],
    domain: ENV['http://monts-et-legumes.fr'],
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end
