require 'net/smtp'
require 'kconv'
require 'yaml'

# 設定ファイルから情報取得
config = YAML.load(IO.read(File.join(File.dirname(__FILE__), "mail.yml")))

# Mail送信 （日本語対応）
t = Time.now
mailaddr_from = config[:from_address]
mail_from     = config[:from]
mailaddr_to   = config[:to_address]
mail_to       = config[:to]
# subject       = "テストメール"
# messages      = "これはテストメールです"
# mailmes = String.new
# mailmes << sprintf("From: %s <%s>\n", Kconv.tojis(mail_from),mailaddr_from)
# mailmes << sprintf("To: %s <%s>\n", Kconv.tojis(mail_to),mailaddr_to)
# mailmes << sprintf("Subject: %s\n", Kconv.tojis(subject))
# mailmes << sprintf("Date: %s\n",t.rfc822)
# mailmes << sprintf("Message-Id: <%s>\n",mail)
# mailmes << messages

# Net::SMTP.start( 'mailserver', 25 ) {|smtp|
#   smtp.send_mail mailmes, mailaddr_from, mailaddr_to
# }
