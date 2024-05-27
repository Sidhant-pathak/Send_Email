class User < ApplicationRecord
    after_create :send_welcome_email

    private
    def send_welcome_email
        SendEmailsJob.perform_now(@user)
        SendEmailsJob.set(wait: 2.minutes).perform_later(@user)        
        # SendEmailsJob.set(wait_until: Date.tomorrow.noon).perform_later(@user)

    end


    # def send_welcome_email
    #     SendEmailsJob.perform_later(self)
    # end

    # SendEmailsJob.set(wait: 1.week).perform_later(user)


end
