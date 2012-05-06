class IdeaMailer < ActionMailer::Base

  def invitation(to, from, channel)
    @subject    = "You have been invited to brainstorm about #{channel.name}"
    @body["channel"] = channel
    @body["from"] = from
    @recipients = to
    @from       = 'brainstorms@alexkroman.com'
    @headers    = {}
  end
  
  def welcome(to, channel)
    @subject    = "You have been an ideabox named: #{channel.name}"
    @body["channel"] = channel
    @recipients = to
    @from       = 'brainstorms@alexkroman.com'
    @headers    = {}
  end
end
