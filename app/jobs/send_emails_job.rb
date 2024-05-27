class SendEmailsJob < ApplicationJob
  queue_as :default

  before_perform { |job| puts job.arguments }
  # around_perform :around_cleanup

  after_perform do |job|
    record = job.arguments.first
  end

  # def perform

  # end


  def perform(user)
    UserMailer.welcome_email(user).deliver_now
  end

  private

  # def around_cleanup
  #   yield
  # end
end
