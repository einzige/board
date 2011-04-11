class Notifications < ActionMailer::Base

  default :from => 'szinin@localhost'
  default :to   => 'szinin@localhost'

  def test
    @notify_subject = "TEST SUBJECT"
    mail(:subject => @notify_subject)
  end

end
