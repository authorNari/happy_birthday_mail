require "rubygems"
require "tlsmail"
require 'net/smtp'
require 'kconv'
require 'yaml'
require 'time'

def sendgmail(to, subject, body)
  # 設定ファイルから情報取得
  config = YAML.load(IO.read(File.join(File.dirname(__FILE__), "mail.yml")))

  body = <<EOT
From: #{config["from"]} <#{config["from_address"]}>
To: #{to.to_a.join(",\n ")}
Subject: #{NKF.nkf("-WMm0", subject)}
Date: #{Time::now.strftime("%a, %d %b %Y %X %z")}
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
 
#{NKF.nkf("-Wjm0", body)}
EOT

  smtp_conf = config["smtp"]
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  Net::SMTP.start(smtp_conf["hostname"],
                  smtp_conf["port"], 
                  smtp_conf["domain"],
                  smtp_conf["account"], 
                  smtp_conf["password"],
                  smtp_conf["format"]) do |smtp|
    smtp.send_mail body, config["from_address"], to
  end
end

require 'logger'
@logger = Logger.new(File.join(File.dirname(__FILE__), "../../sendmail.log"))

$: << File.join(File.dirname(__FILE__), "../../")
require "models/friends"

def birthday_mail
  today = Date.today
  Friends.where(:birthmonth => today.month, :birthday => today.day).each do |friend|
    @logger.info "sendmail to #{friend.name}, address #{friend.mail_address}"
    sendgmail(friend.mail_address, friend.subject, friend.message)
  end
  @logger.info "invoke"
end

birthday_mail
